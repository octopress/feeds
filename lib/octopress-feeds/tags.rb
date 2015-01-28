module Octopress
  module Feeds
    class FeedTag < Liquid::Tag
      def render(context)
        context['site.pages'].dup \
          .select  { |p| p.data['feed'] } \
          .sort_by { |p| p.path.size } \
          .map     { |p| tag(p) } \
          .join("\n")
      end

      def tag(page)
        url = page.url.sub(File.basename(page.url), '')

        "<link href='#{url}' title='#{page_title(page)}' rel='alternate' type='application/atom+xml'>"
      end

      def page_title(page)
        title = page.site.config['name'].dup || ''
        title << ': ' unless title.empty?
        title << page.data['title']

        title
      end
    end

    class FeedUpdatedTag < Liquid::Tag
      def render(context)
        feed = context['feed_type'] || 'posts'
        site = context['site']

        case feed
        when 'articles'
          posts = site['articles']
        when 'linkposts'
          posts = site['linkposts']
        else
          posts = site['posts']
        end

        if !posts.empty?
          post = posts.sort_by do |p|
            p.data['date_updated'] || p.date
          end.last

          post.data['date_updated_xml'] || post.data['date_xml']
        end
      end
    end
  end
end

Liquid::Template.register_tag('feed_tag', Octopress::Feeds::FeedTag)
Liquid::Template.register_tag('feed_updated_date', Octopress::Feeds::FeedUpdatedTag)


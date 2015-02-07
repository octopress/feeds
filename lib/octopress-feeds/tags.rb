module Octopress
  module Feeds
    class FeedTag < Liquid::Tag
      def render(context)
        Octopress::Ink.plugin('feeds').pages.dup
          .map { |p| tag(p.page) }
          .join("\n")
      end

      def tag(page)
        url = page.url.sub(File.basename(page.url), '')

        "<link href='#{url}' title='#{page_title(page)}' rel='alternate' type='application/atom+xml'>"
      end

      def page_title(page)
        title = page.site.config['name'].dup || ''
        title << ': ' unless title.empty?
        title << page_title_config(page)

        if defined?(Octopress::Multilingual) && page.lang
          title << " (#{Octopress::Multilingual.language_name(page.lang)})"
        end

        title
      end

      def page_title_config(page)
        plugin = page.plugin
        config = plugin.config(page.lang)

        case plugin.feed_type(page.asset)
        when 'article'; config['titles']['article-feed']
        when 'link'; config['titles']['link-feed']
        else config['titles']['main-feed']
        end
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

        if posts && !posts.empty?
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


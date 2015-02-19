module Octopress
  module Feeds
    class FeedTag < Liquid::Tag
      def render(context)
        Octopress::Ink.plugin('feeds').templates
          .sort_by { |template| template.file.size }
          .map { |template| template.pages }
          .flatten.map {|page| tag(page) }
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
        plugin = Octopress::Ink.plugin('feeds')
        config = plugin.config(page.lang)['titles']

        case page.data['feed_type']
        when 'articles'; config['article-feed']
        when 'links'; config['link-feed']
        when 'category'; config['category-feed'].sub(/@category_name/, page.data['category'])
        else config['main-feed']
        end
      end
    end

    class FeedUpdatedTag < Liquid::Tag
      def render(context)
        feed = context['page.feed_type']
        site = context['site']

        case feed
        when 'articles'
          posts = site['articles']
        when 'links'
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


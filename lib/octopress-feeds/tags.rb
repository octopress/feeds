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
        title = page_title_config(page)

        if defined?(Octopress::Multilingual) && page.lang
          title << " (#{Octopress::Multilingual.language_name(page.lang)})"
        end

        title
      end

      def page_title_config(page)
        plugin = Octopress::Ink.plugin('feeds')
        config = plugin.config(page.lang)['titles']

        site_name = page.site.config['name'] || ''
        type = page.data['feed_type']
        title = config[type]

        if type == 'category'
          category = page.data['category'].capitalize

          if labels = Octopress.site.config['category_labels']
            category = labels[category.downcase] || category
          end

          title = title.sub(/category\.name/, category)
        end

        title.sub(/site\.name/, site_name)
      end
    end

    class FeedUpdatedTag < Liquid::Tag
      def render(context)
        feed = context['page.feed_type']
        site = context['site']

        if feed == 'category'
          posts = site['categories'][context['page.category']]
        else
          posts = site[feed] || site['posts']
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


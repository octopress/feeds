require 'octopress-feeds/version'
require 'octopress-ink'

Octopress::Ink.add_plugin({
  name:          "Octopress Feeds",
  slug:          "feeds",
  assets_path:   File.expand_path(File.join(File.dirname(__FILE__), "../assets")),
  type:          "plugin",
  version:       Octopress::Ink::Feeds::VERSION,
  description:   "A nice RSS feed for Octopress and Jekyll sites.",
  website:       "https://github.com/octopress/feeds"
})

module Octopress
  module Ink
    module Tags
      class FeedTag < Liquid::Tag
        def render(context)
          tags = []

          Ink.plugin('feeds').pages.dup.map do |p|
            if p.filename == 'main-feed.xml' && !p.disabled?
              tag(p.page)
            end
          end
        end

        def tag(page)
          url = page.url.sub(/index\.xml/, '')
          "<link href='#{url}' rel='alternate' title='#{page.data['title']}: #{Ink.site.config['name']}' type='application/atom+xml'>"
        end
      end

      class FeedUpdatedTag < Liquid::Tag
        def render(context)
          feed = context.environments.first['page']['feed'] || 'posts'

          case feed
          when 'articles'
            post = Ink.articles.last
          when 'linkposts'
            post = Ink.linkposts.last
          else
            post = Ink.site.posts.last
          end
          
          if post.data['updated']
            post.data['updated_date_xml']
          else
            post.data['date_xml']
          end
        end
      end
    end
  end
end



Liquid::Template.register_tag('feed_tag', Octopress::Ink::Tags::FeedTag)
Liquid::Template.register_tag('feed_updated_date', Octopress::Ink::Tags::FeedUpdatedTag)


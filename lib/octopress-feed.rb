require 'octopress-feed/version'
require 'octopress-ink'

Octopress::Ink.add_plugin({
  name:          "Octopress Feed",
  slug:          "feed",
  assets_path:   File.expand_path(File.join(File.dirname(__FILE__), "../assets")),
  type:          "plugin",
  version:       Octopress::Ink::Feed::VERSION,
  description:   "A nice RSS feed for Octopress and Jekyll sites.",
  website:       "https://github.com/octopress/feed"
})

module Octopress
  module Ink
    module Tags
      class FeedTag < Liquid::Tag
        def render(context)
          tags = []

          Ink.plugin('feed').pages.dup.map do |p|
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
    end
  end
end

Liquid::Template.register_tag('feed_tag', Octopress::Ink::Tags::FeedTag)


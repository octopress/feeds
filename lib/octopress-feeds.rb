require 'octopress-feeds/version'
require 'octopress-ink'
require 'octopress-include-tag'
require 'octopress-abort-tag'
require 'octopress-return-tag'
require 'octopress-date-format'
require 'octopress-feeds/tags'


module Octopress
  module Feeds
    class Plugin < Ink::Plugin

      def add_pages
        super

        # Remove linkblog pages if the octopress-linkblog plugin isn't installed
        unless defined? Octopress::Linkblog
          @pages.reject! do |p|
            p.file =~ /(article|link)/
          end
        end
      end
    end
  end
end

Octopress::Ink::Plugins.register_plugin(Octopress::Feeds::Plugin, {
  name:          "Octopress Feeds",
  slug:          "feeds",
  gem:           "octopress-feeds",
  path:          File.expand_path(File.join(File.dirname(__FILE__), "..")),
  type:          "plugin",
  version:       Octopress::Feeds::VERSION,
  description:   "RSS feeds for Jekyll sites, featuring link-blogging and multilingual support",
  website:       "https://github.com/octopress/feeds"
})



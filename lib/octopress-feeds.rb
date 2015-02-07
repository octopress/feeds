require 'octopress-feeds/version'
require 'octopress-ink'
require 'octopress-include-tag'
require 'octopress-abort-tag'
require 'octopress-return-tag'
require 'octopress-date-format'
require 'octopress-feeds/tags'
require 'octopress-feeds/config-asset'


module Octopress
  module Feeds
    class Plugin < Ink::Plugin

      def config_defaults
        @config ||= Feeds::Config.new(self, @config_file)
      end

      def add_pages
        super

        # Remove linkblog pages if the octopress-linkblog plugin isn't installed

        unless defined? Octopress::Linkblog
          @pages.reject! do |p|
            p.file =~ /(article|link)/
          end
        end

        @pages.sort_by! {|p| p.path.size }

        if defined? Octopress::Multilingual

          # Add default language to main feeds
          @pages.each do |page| 
            lang = Octopress.site.config['lang']
            page.data.merge!({'lang' => lang}) 
            page.permalink ||= lang_permalink(page, lang)
          end

          # Ensure multilingual pages are set up for `ink list` view
          Octopress.site.read if Octopress.site.posts.empty?

          # Add pages for other languages
          Octopress::Multilingual.languages.each do |lang|
            next if lang == Octopress::Multilingual.main_language
            @pages.concat add_lang_pages(lang)
          end
        end
      end

      def lang_permalink(page, lang)
        File.join("/#{lang}", "feed", feed_url(page), '/')
      end

      def add_lang_pages(lang)
        lang_pages = []

        # For each page template, create a new page, and configure its permalink defaults
        #
        @pages.each do |page|
          # New name for permalink settings in plugin config.yml
          permalink_name = "#{page.permalink_name}-#{lang}"

          # Set the permalink default to /[lang]/feed/[type]
          permalink = File.join("/#{lang}", "feed", feed_url(page), '/')

          # Create a copy of the page
          lang_pages << page.clone(permalink_name, permalink, {'lang'=>lang})
        end

        lang_pages.sort_by {|p| p.path.size }
      end

      def feed_url(page)
        case feed_type(page)
        when 'article'; 'articles'
        when 'link'; 'links'
        else ''
        end
      end

      def feed_type(page)
        if page.file =~ /article/
          'article'
        elsif page.file =~ /link/
          'link'
        else
          'main'
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

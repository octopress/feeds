require 'octopress-feeds/version'
require 'octopress-ink'
require 'octopress-include-tag'
require 'octopress-return-tag'
require 'octopress-date-format'
require 'octopress-feeds/tags'


module Octopress
  module Feeds
    class Plugin < Ink::Plugin

      def multilingual?
        (defined?(Octopress::Multilingual) && !Octopress.site.config['lang'].nil?)
      end

      def add_template_pages
        # Remove linkblog pages if the octopress-linkblog plugin isn't installed
        if multilingual?
          # Add pages for other languages
          Octopress::Multilingual.languages.each do |lang|
            add_feeds(lang)
          end
        else
          add_feeds
        end
      end

      def add_feeds(lang=nil)

        lang = nil unless multilingual?

        config = self.config(lang)
        files = ['main.xml']

        if defined? Octopress::Linkblog
          files.concat %w{links.xml articles.xml}
        end

        files.each do |file|
          add_template_page(file, permalink(file, lang), {
            'lang' => lang,
            'feed_type' => feed_type(file)
          })
        end

        if config['category_feed']
          add_category_feeds(config, lang)
        end
      end

      def add_category_feeds(config, lang)
        categories = Array(config['categories'])

        if categories.empty?
          if lang
            categories = Octopres::Multilingual.categories_by_language(lang).keys
          else
            categories = Octopress.site.categories.keys
          end
        end


        categories.each do |category|
          dir = config['permalinks']['category'].sub('@category_name', category)
          permalink = File.join(lang || '', dir, 'index.xml')
          add_template_page('category.xml', permalink, {
            'lang' => lang,
            'category' => category,
            'feed_type' => 'categorty'
          })
        end
      end

      def permalink(template, lang)
        type = feed_type(template)
        url = File.join(lang || '', config(lang)['permalinks'][type])

        # Allow permalinks to specify a filename (ugh, if you must…)
        unless File.extname(url) == '.xml'
          url = File.join(url, 'index.xml')
        end

        url
      end

      # Discern feed type based on filename
      def feed_type(template)
        if template =~ /article/
          'articles'
        elsif template =~ /link/
          'links'
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

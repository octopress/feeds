require 'octopress-feeds/version'
require 'octopress-ink'
require 'octopress-include-tag'
require 'octopress-return-tag'
require 'octopress-date-format'


Octopress::Ink.add_plugin({
  name:          "Octopress Feeds",
  slug:          "feeds",
  gem:           "octopress-feeds",
  path:          File.expand_path(File.join(File.dirname(__FILE__), "..")),
  version:       Octopress::Feeds::VERSION,
  description:   "RSS feeds for Jekyll sites, featuring link-blogging and multilingual support",
  website:       "https://github.com/octopress/feeds"
})

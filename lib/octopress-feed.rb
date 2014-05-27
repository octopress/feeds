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

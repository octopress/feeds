# Octopress Feed

Add nice RSS feed to Octopress and Jekyll sites.

## Installation

Add this line to your application's Gemfile:

    gem 'octopress-feed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octopress-feed

### Add gem to Jekyll

Add the gem to Jekyll's configuration file:

```yaml
gems:
  - octopress-feed
```

## Usage

Be sure your Jekyll configuration has a `url`, a `title`, and an `author`.

```yaml
url: http://yoursite.com/
title: My Awesome Site
author: Guy McDude
```

Next generate your site with `jekyll build` and an xml feed will be generated at `/feed/index.xml`.

To be sure you've installed the plugin correctly, run `octopress ink list feed` which will list detailed information about the plugin.

```
Plugin: Octopress Feed - v1.0.0
Slug: feed
A nice RSS feed for Octopress and Jekyll sites.
https://github.com/octopress/feed
================================================================================
 includes:
  - entry.xml
  - head.xml
  - index.xml

 pages:
  - feed.xml

 default configuration:
    count: 20
    full_content: true
    external_links: true
```

NOTE: Any relative URLs in your posts will be expanded based on your site's `url` configuration.

## Customization

Octopress Ink can copy all of the plugin's assets to `_plugins/feed/*` where you can override them with your own modifications. This is
only necessary if you want to modify this plugin's behavior.

```
octopress ink copy feed
```

This will copy the plugin's configuration, pages, and includes from the gem, to your local site. If, for example, you want to change the XML for an entry, you can simply edit the `_plugins/feed/includes/entry.xml` file.

If you want to revert to the defaults, simply delete any file you don't care to override from the `_plugins/feed/` directory.

## Configuration

| Option            | Description                                                 | Default     |
|:------------------|:------------------------------------------------------------|:------------|
| `count`           | How many posts should appear in your feed                   | 20          |
| `full_content`    | Feed entries will contain full post content (not excerpts)  | true        |
| `external_links`  | Use the external URL as the primary link for a link post    | true        |


To configure this plugin, first create a configuration file at `_plugins/feed/config.yml`. If you like, you can have Octopress Ink add it for you.

```
octopress ink copy feed --config-file
```

This will create a configuration file populated with the defaults for this plugin. Deleting this file will restore the default configuration.

## Contributing

1. Fork it ( https://github.com/octopress/feed/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

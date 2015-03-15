# Octopress Feeds

RSS feeds for Jekyll sites, featuring:
 - link-blogging - feeds for links and articles
 - Feeds for categories and tags
 - Multilingual support - automatic language specific feeds for all feed types

[![Build Status](http://img.shields.io/travis/octopress/feeds.svg)](https://travis-ci.org/octopress/feeds)
[![Gem Version](http://img.shields.io/gem/v/octopress-feeds.svg)](https://rubygems.org/gems/octopress-feeds)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://octopress.mit-license.org)

## Installation

Using Bundler:

Add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octopress-feeds'
    end

Then install the gem with Bundler

    $ bundle

Or install manually:

    $ gem install octopress-feeds

Then add the gem to your Jekyll configuration.

    gems:
      -octopress-feeds

## Usage

For link blogging features (article-only and link-only feeds), install [octopress-linkblog](https://github.com/octopress/linkblog).
For secondary language feeds, install [octopress-multilingual](https://github.com/octopress/multilingual).

Be sure your Jekyll configuration has a `url`, a `name` and an `author`. 

```yaml
url: http://yoursite.com/
name: Your Site Name
author: Guy McDude
```

Note: Relative URLs in your posts will be expanded based on your site's `url` and `basename` configuration.

Next, add a `<link>` tag to your site's `<head>`.

```html
<head>
{% feeds %}
</head>
```

This would output:

```html
<head>
<link href='http://yoursite.com/feed/' title='Your Site Name: Main Feed' rel='alternate' type='application/atom+xml'>
</head>
```

That's it. When you build your site with `jekyll build` and this plugin will generate RSS feed(s) and generate the proper `<link>`
tags.

## Link-blogging

Install [octopress-linkblog](https://github.com/octopress/linkblog) and posts with an `external-url` will be added to a feed at `/feeds/links/index.xml` while an articles-only feed will be generated at `/feeds/articles/index.xml`.

## Multilingual support

If you are using [octopress-multilingual](https://github.com/octopress/multilingual), additional feeds will automatically be added for
each language. Your feed urls will be organized by language. For example:

```
/en/feed/index.xml       # All English posts feed
/de/feed/index.xml       # All German posts feed

# Feeds added with octopress-linkblog
/en/feed/articles/index.xml    # English articles only feed
/en/feed/links/index.xml       # English link-posts only feed
/de/feed/articles/index.xml    # German articles only feed
/de/feed/links/index.xml       # German link-posts only feed
```

To change the URL for these pages, read the [Feed Permalinks](#feed-permalinks) section below.

## Configuration

To configure this plugin, first copy the plugin's configuration file to `_plugins/feeds/config.yml` buy running:

```
$ octopress ink copy feeds --config-file
```

This will create a configuration file populated with the defaults for this plugin. Deleting this file will restore the default configuration.

### Configuration defaults

```
feed_count: 20               # Maximum number of posts in a feed
posts_link_out: true         # Linkposts should direct visitors to the linked site
feed_excerpts: false         # Use post excerpts in feeds
category_feeds: false        # Add a feed for post categories
tag_feeds: false             # Add a feed for post tags
categories: []               # Only add feeds for these categories. (empty adds feeds for all categories)
tags: []                     # Only add feeds for these tags. (empty adds feeds for all tags)

read_more_label:  "Continue reading →"
permalink_label:  "Permalink"

titles:
  main_feed:      Posts - :site_name
  links_feed:     Links - :site_name
  articles_feed:  Articles - :site_name
  category_feed:  Posts in :category - :site_name
  tag_feed:       Posts tagged with :tag - :site_name

permalinks: 
  main_feed:      /feed/
  links_feed:     /feed/links/
  articles_feed:  /feed/articles/
  category_feed:  /feed/categories/:category/
  tag_feed:       /feed/tags/:tag/
```

### Feed titles

The `titles` configuration allows you to control the title that RSS subscribers see for your feed.

As you'd expect, `:site_name` is replaced with the value from your site configuration and `:category` is replaced with the
category for that feed.

If you want to change the title for other languages you can add a new language localized config file. For example if you have German
feeds, you would add a config file at `_plugins/feeds/config_de.yml` and set titles for your German language feeds.

### Feed permalinks

You can set the URL for the feed pages by configuring the `permalinks` setting.

If you are running a multilingual site with [octopress-multilingual](https://github.com/octopress/multilingual) permalinks will be
prepended with the lanugage code that corresponds with the posts in that feed. So `/feed/` will become `/en/feed/` and `/de/feed/`
and so on.

### Excerpted feeds

Post excerpts are determined by Jekyll's `excerpt_separator` configuration. It defaults to splitting your
post at the first double line-break, `\n\n`. If you want more control over where the excerpt happens on your individual
posts, You can change that to something like `<!--more-->` and place that comment wherever you like in your post to
split the content there.


### Customizing feed templates

When you run `$ octopress ink list feeds` the includes and templates section might like this:

```
includes:
  - entry.xml
  - head.xml
 
templates:
 - articles.xml                  # template file
    /feed/articles/index.xml     # page generated from template
 - category.xml
 - links.xml
    /feed/links/index.xml
 - main.xml
    /feed/index.xml
```

To customize feed templates and inlcudes, Copy all of the plugin's assets to `_plugins/feeds/` by running this command:

```
octopress ink copy feeds --templates --includes
```

Any changes you make to these templates will override the templates in the plugin.  If you want to revert to the defaults, simply delete any file you don't care to override from the `_plugins/feeds/` directory.


## Contributing

1. Fork it ( https://github.com/octopress/feeds/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

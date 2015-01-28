# Octopress Feeds

RSS feeds for Jekyll sites, featuring link-blogging and multilingual support.

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

Next, add a `<link>` tag to your site's `<head>`.

```html
<head>
{% feed_tag %}
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

If you are using [octopress-multilingual](https://github.com/octopress/multilingual), your feed urls will be organized by language. If
your site's main language is `en` your English feeds will be here:

```
/en/feed/index.xml       # All English posts feed
/en/links/index.xml      # English link posts (if using octopress-linkblog)
/en/articles/index.xml   # English article posts (if using octopress-linkblog)
```

To change the URL for these pages, read the [Feed Permalinks](#feed-permalinks) section below.

Adding a secondary language feed is pretty simple. Let's say you want to add a German language feed. Here's what you'd do.

First, create a page at `/de/feed/index.xml` (or whatever path suits your site's URL conventions) and add the following.

```
---
feed: true
title: Deutsch feed
---
{% include feeds:main-feed.xml lang='de' %}
```

The page config, `feed: true` ensures that it will be added to your site's feed listing with `{% feed_tag %}`. The title, as you'd
expect will show up as your feed title in RSS readers.

If you are using the [octopress-linkblog](https://github.com/octopress/linkblog) plugin, you can also add article-only and link-only feeds for additional languages.

To create an articles feed, add a file to `/de/feed/articles/index.xml` (or wherever suits your site) containing the following:

```
---
feed:true
title: Deutsch Artikel Feed
---
{% include feeds:article-feed.xml lang='de' %}
```

To add a link-posts feed, add a file to `/de/feed/links/index.xml` containing the following:

```
---
feed:true
title: Deutsch Link Feed
---
{% include feeds:article-feed.xml lang='de' %}
```

That's it. When you generate your site. These feeds should contain only German posts. If you have more than one language, you can just repeat the steps above for each.

## Customize feeds

To list detailed information about this plugin, run `$ octopress ink list feeds`. This will output something like this:

```
Plugin: Octopress Feeds - v1.1.5
Slug: feeds
RSS feeds for Jekyll sites, featuring link-blogging and multilingual support.
https://github.com/octopress/feeds
=============================================================
 includes:
  - article-feed.xml
  - entry.xml
  - head.xml
  - link-feed.xml
  - main-feed.xml

pages:                              urls:
  - article-feed.xml                   /feed/articles/index.xml
  - link-feed.xml                      /feed/links/index.xml
  - main-feed.xml                      /feed/index.xml

 default configuration:
    count: 20
    excerpts: false         # Feed excerpts post content
    external_links: true    # Linkposts should direct visitors to the linked site
    articles_feed: false    # Add a feed with articles only
    linkposts_feed: false   # Add a feed with linkposts only
```

NOTE: Any relative URLs in your posts will be expanded based on your site's `url` configuration.

Octopress Ink can copy all of the plugin's assets to `_plugins/feeds/*` where you can override them with your own modifications. This is
only necessary if you want to modify this plugin's behavior.

```
octopress ink copy feeds
```

This will copy the plugin's configuration, pages, and includes from the gem, to your local site. If, for example, you want to change the XML for an entry, you can simply edit the `_plugins/feeds/includes/entry.xml` file.

If you want to revert to the defaults, simply delete any file you don't care to override from the `_plugins/feeds/` directory.

## Configuration

To configure this plugin, first create a configuration file at `_plugins/feeds/config.yml`. If you like, you can have Octopress Ink add it for you.

```
$ octopress ink copy feeds --config-file
```

This will create a configuration file populated with the defaults for this plugin. Deleting this file will restore the default configuration.


| Option                | Description                                                 | Default     |
|:----------------------|:------------------------------------------------------------|:------------|
| `count`               | How many posts should appear in your feeds.                 | 20          |
| `excerpts`            | Feed entries will contain excerpts of post content.         | false       |
| `external_linkposts`  | Link posts should direct visitors to the linked site.       | true        |
| `articles_feed`       | Add an additional articles-only feed.                       | false       |
| `linkposts_feed`      | Add an additional link-posts-only feed.                     | false       |
| `permalinks`          | Set the permalink for feed pages.                           |             |


### Feed permalinks

You can set the URL for the feed pages by configuring the `permalink` setting. Here's an example:

```yaml
permalinks:
  main-feed: /rss/
  link-feed: /rss/links/
  article-feed: /rss/articles/
```

Now when you run `$ octopress ink list feeds` the pages section will look like this:

```
pages:                              urls:
  - article-feed.xml                   /rss/articles/index.xml
  - link-feed.xml                      /rss/links/index.xml
  - main-feed.xml                      /rss/index.xml
```

Note: Multilingual feeds will not show up here. This only shows pages that come with this plugin.

### Excerpted feeds

Post excerpts are determined by Jekyll's `excerpt_separator` configuration. It defaults to splitting your
post at the first double line-break, `\n\n`. If you want more control over where the excerpt happens on your individual
posts, You can change that to something like `<!--more-->` and place that comment wherever you like in your post to
split the content there.


## Contributing

1. Fork it ( https://github.com/octopress/feeds/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

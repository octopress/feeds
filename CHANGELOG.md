# Changelog

### 2.0.3 (2015-03-14)
- New: Configure permalink and "read more" link labels.
- Fix: Feed excerpt settings are now set properly.

### 2.0.2 (2015-03-04)
- Fix: Liquid doesn't understand `||`, it prefers `or`.

### 2.0.1 (2015-03-04)
- Fix: Feeds blew up if site author was not configured

### 2.0.0 (2015-03-04)
- New: Feeds for each post tag (or configure specific tags).
- Now integrated with Octopress Ink's plugin bootstrap.
- Some configurations have changed, see Readme for details.
- Feeds are now plugin templates instead of pages (this only matters if you've been overriding them).

### 1.4.0 (2015-02-20)
- New: Added category index feeds
- New: Better configuration management for titles and permalinks

### 1.3.4 (2015-02-14)

- Only default feed language if a default site language is set.
- Removed abort-tag (no longer needed)

### 1.3.3 (2015-02-14)

- Updated compatibility with latest Octopress Ink.

### 1.3.2 (2015-02-08)

- New: Feed titles can be configured (for additional languages too).

### 1.3.1 (2015-02-03)

- Feed titles include the full language name.

### 1.3.0 (2015-02-01)

- New: All language feeds are automatically generated.

### 1.2.7 (2015-01-31)

- Added support for new octopress-multilingual page.lang feature.

### 1.2.6 (2015-01-27)

- On multilingual sites, the main language feed URL will default to `/[lang]/feed/index.xml`

### 1.2.5 (2015-01-26)

- Fix: Feed excerpts work with linkblog and multilingual sites.
- Fix: Only add link and article feeds if octopress-linkblog is installed.

### 1.2.4 (2015-01-26)

- Link and Article feeds are automatically added when linkblog plugin is added.

### 1.2.3 (2015-01-24)
- Fix: Posts use canonical URLs in feeds.
- Improved `baseurl` support.

### 1.2.2 (2015-01-22)
- Removed faux `set_lang` tag as it is now integrated into Octopress Ink.

### 1.2.1 (2015-01-22)
- Sorted feed links

### 1.2.0 (2015-01-22)
- Added support for multilingual feeds via the [octopress-multilingual](https://github.com/octopress/multilingual) plugin.

### 1.1.4 (2015-01-09)
- Fixed invalid whitespace issue, [#6](https://github.com/octopress/feeds/issues/6).

### 1.1.3 (2015-01-09)
- Readme fixes (feed -> feeds)

### 1.1.2 (2015-01-06)
- Fixed: Bug in main feed index.

### 1.1.1 (2015-01-06)

- Fixed: Bug in sort by date
- Fixed: No more empty feeds

### 1.1.0 (2015-01-06)

- Updated dependencies
- Fix: Works with new octopress-date-format
- Fix: Works with octopress-linkblog (optionally)

### 1.0.0 (2014-06-09)

- Initial release

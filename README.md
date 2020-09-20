# Hugo Natrium
This is a simple, responsive blog theme for [Hugo](https://gohugo.io/) based on [Lithium](https://github.com/jrutheiser/hugo-lithium-theme.git). [Hugo Natrium](https://github.com/mobybit/hugo-natrium-theme) was created by Tim ([mobybit](https://github.com/mobybit)).

## Changes
In September 2020, minor changes have been introduced to make this theme compatible with the latest Hugo versions (0.57 and newer). **These changes may break the theme under older Hugo versions (0.56 and prior).** Upgrading to at least Hugo 0.57 is required to maintain functionality. The changes include:

* Replace instances of *.URL* with *.RelPermalink* (fixes "*WARN Page.URL is deprecated and will be removed in a future release. Use .Permalink or .RelPermalink.*")
* Replace instances of *.Hugo* with *hugo* (fixes "*WARN Page.Hugo is deprecated and will be removed in a future release. Use the global hugo function.*")
* Replace instances of *.RSSLink* with *.OutputFormats.Get "RSS"* (fixes: "*WARN Page.RSSLink is deprecated and will be removed in a future release. Use the Output Format's link.*")
* Replace instances of *.Data.Pages* with *.Site.RegularPages* (fixes "*Error <.Paginate>: error calling Paginate: cannot convert type page.PagesGroup to Pages*")

**To use Natrium with older versions of Hugo (0.25 - 0.56), use the previous commit ([c0906c9ec0878985af4cd86b0b083c5b8f1f78df](https://github.com/mobybit/hugo-natrium-theme/tree/c0906c9ec0878985af4cd86b0b083c5b8f1f78df)).**

Natrium includes: taxonomies (categories, tags), static footer, new fonts (Roboto Mono, Font Awesome), local fonts, syntax highlighting, better support for code, img and RSS, pagination, multiple design optimizations, i18n, 404.html...


## Features
- Blog
- Responsive
- Privacy (no Google)
- Taxonomies
- Syntax highlighting
- Pagination


## Installation
Run the following inside your Hugo site folder:

```
$ mkdir themes
$ cd themes
$ git clone https://github.com/mobybit/hugo-natrium-theme
```


## Configuration
Take a look at the sample [config.toml](https://github.com/mobybit/hugo-natrium-theme/blob/master/exampleSite/config.toml)
file located in the [exampleSite](https://github.com/mobybit/hugo-natrium-theme/blob/master/exampleSite) folder.


## Content Types

### Post
Used for blog posts. Blog posts are listed on the homepage.

Run `hugo new post/<post-name>.md` to create a post.

### Page
Used for site pages.

Run `hugo new page/<page-name>.md` to create a page.


## Syntax highlighting
Natrium is using [Chroma](https://gohugo.io/content-management/syntax-highlighting/) and `pygmentsStyle = "native"` by default. If you would like to use another style you have to adjust the colors in `pre` in main.css.


## License
The code is available under the [MIT License](https://github.com/mobybit/hugo-natrium-theme/blob/master/LICENSE.md). 

Natrium is using [Font Awesome](http://fontawesome.io) by Dave Gandy ([SIL OFL 1.1](http://scripts.sil.org/OFL)). Realated files (CSS, LESS, SCSS) are licensed under the [MIT License](http://opensource.org/licenses/mit-license.html).

Other used fonts are [Merriweather](https://github.com/EbenSorkin/Merriweather) by Sorkin Type (Copyright © 2016 The Merriweather Project, [SIL OFL 1.1](http://scripts.sil.org/OFL)), [Lato](http://www.latofonts.com/) by Łukasz Dziedzic (Copyright © 2010-2014 by tyPoland Lukasz Dziedzic, [SIL OFL 1.1](http://scripts.sil.org/OFL)) and [Roboto Mono](https://github.com/google/roboto/) by Christian Robertson (Copyright © 2015 Google Inc., [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)).

Special thanks to [Artem Sidorenko](https://www.sidorenko.io/post/2017/07/nice-tagcloud-with-hugo/) (tag cloud).

The content of the example site is generated with [Metamorphosum](http://metaphorpsum.com/) (Copyright © 2014 Kyle Stetz, [MIT License](https://github.com/kylestetz/metaphorpsum/blob/master/LICENSE.md)).

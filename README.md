# Hugo Chlorine

A simple responsive blog theme for [Hugo](https://gohugo.io/) based on [Natrium](https://github.com/mobybit/hugo-natrium-theme).

## Changes

It is now possible to have multiple authors.

## Features

- Blog
- Responsive
- Privacy (no Google)
- Taxonomies
- Syntax highlighting
- Pagination
- Multiple authors

## Installation

Run the following inside your Hugo site folder:

```
$ mkdir themes
$ cd themes
$ git clone https://github.com/AnnaOpss/hugo-chlorine-theme.git
```

## Configuration

Take a look at the sample [config.toml](https://github.com/AnnaOpss/hugo-chlorine-theme/blob/master/exampleSite/config.toml)
file located in the [exampleSite](https://github.com/AnnaOpss/hugo-chlorine-theme/blob/master/exampleSite/) folder.

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

The code is available under the [MIT License](https://github.com/AnnaOpss/hugo-chlorine-theme/blob/master/LICENSE.md). 

Natrium is using [Font Awesome](http://fontawesome.io) by Dave Gandy ([SIL OFL 1.1](http://scripts.sil.org/OFL)). Realated files (CSS, LESS, SCSS) are licensed under the [MIT License](http://opensource.org/licenses/mit-license.html).

Other used fonts are [Merriweather](https://github.com/EbenSorkin/Merriweather) by Sorkin Type (Copyright © 2016 The Merriweather Project, [SIL OFL 1.1](http://scripts.sil.org/OFL)), [Lato](http://www.latofonts.com/) by Łukasz Dziedzic (Copyright © 2010-2014 by tyPoland Lukasz Dziedzic, [SIL OFL 1.1](http://scripts.sil.org/OFL)) and [Roboto Mono](https://github.com/google/roboto/) by Christian Robertson (Copyright © 2015 Google Inc., [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)).

The content of the example site is generated with [Metamorphosum](http://metaphorpsum.com/) (Copyright © 2014 Kyle Stetz, [MIT License](https://github.com/kylestetz/metaphorpsum/blob/master/LICENSE.md)).

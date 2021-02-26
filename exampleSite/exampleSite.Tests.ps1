# ###############################
# Hugo Natrium
# https://github.com/neil-sabol/hugo-natrium-theme
# Neil Sabol
# neil.sabol@gmail.com
# ###############################

# Capture the path the theme and tests reside in
$script:currentPath = (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Define test parameters (expected results)
$script:expectedVersionFull = Invoke-Command {hugo version}
# Try Hugo 0.81.0 and later version string format
$script:expectedVersionShort = $expectedVersionFull.Split("-")[0].Replace("hugo v","")
# Try Hugo prior to 0.81.0 version string format (fall through from replace above)
$script:expectedVersionShort = $expectedVersionShort.Split("-")[0].Replace("Hugo Static Site Generator v","")
$script:expectedFileandFolderCount = 140
$script:expectedPostsAll = 3
$script:expectedPostsonFirstPage = 2
$script:expectedPostsonSecondPage = 1
$script:expectedCategoryCount = 2
$script:expectedTagCount = 11
$script:expectedPageswithHugoVersion = 25
$script:expectedUrlsinRSSFeed = 3
$script:expectedUrlsinSiteMap = 23

# Begin Pester tests
Describe 'Hugo Natrium Theme' {
    BeforeAll {
        # Apply the Hugo Natrium theme to the exampleSite
        New-Item -Path "$currentPath\themes" -Name "hugo-natrium-theme" -ItemType "Directory"
        Copy-Item -Path "$((Get-Item $currentPath).Parent.FullName)\*" -Recurse -Destination "C:\Users\Neil\Documents\GitHub\hugo-natrium-theme\exampleSite\themes\hugo-natrium-theme" -Exclude "exampleSite"
    }
    Context "Basic functionality" {
        It "Should create new posts without ERRORS when Hugo is executed" {
            cd $currentPath
            $hugoResult = Invoke-Command {hugo new post/TestPost1.md 2>&1}
            $hugoResult | Should -Not -BeLike "*error*"
        }
        It "Should create new posts without WARNINGS when Hugo is executed" {
            cd $currentPath
            $hugoResult = Invoke-Command {hugo new post/TestPost2.md 2>&1}
            $hugoResult | Should -Not -BeLike "*warn*"
        }
        It "Should render without ERRORS when Hugo is executed" {
            cd $currentPath
            $hugoResult = Invoke-Command {hugo 2>&1}
            $hugoResult | Should -Not -BeLike "*error*"
        }
        It "Should render without WARNINGS when Hugo is executed" {
            cd $currentPath
            $hugoResult = Invoke-Command {hugo 2>&1}
            $hugoResult | Should -Not -BeLike "*warn*"
        }
        It 'Should render into the "public" folder' {
            "$currentPath\public" | Should -Exist
        }
        It 'Should render completely (139 files and folders)' {
            Get-ChildItem -Path "$currentPath\public" -Recurse | Measure-Object | select -ExpandProperty Count | Should -Be $expectedFileandFolderCount
        }
    }
    Context "Pagination" {
        It "Should render 2 posts on the first page" {
            Get-Content "$currentPath\public\index.html" | Where-Object { $_ -like '*<nav class="list-item">*' } | Measure-Object | select -ExpandProperty Count | Should -Be $expectedPostsonFirstPage
        }
        It "Should render 1 post on the second page" {
            Get-Content "$currentPath\public\page\2\index.html" | Where-Object { $_ -like '*<nav class="list-item">*' } | Measure-Object | select -ExpandProperty Count | Should -Be $expectedPostsonSecondPage
        }
        It "Should render the correct navigation (next) on the first page" {
            Get-Content "$currentPath\public\index.html" -Raw | Should -BeLike '*<a href="/page/2/" aria-label="Next">*'
        }
        It "Should render the correct navigation (back) on the second page" {
            Get-Content "$currentPath\public\page\2\index.html" -Raw | Should -BeLike '*<a href="/" aria-label="Previous">*'
        }
    }
    Context "Taxonomies" {
        It "Should render the correct number (2) of categories" {
            Get-Content "$currentPath\public\categories\index.html" | Where-Object { $_ -like '*<ul class="category-item">*' } | Measure-Object | select -ExpandProperty Count | Should -Be $expectedCategoryCount
        }
        It "Should render the metaphorsum category" {
            "$currentPath\public\categories\metaphorsum\index.html" | Should -Exist
        }
        It "Should render the post category" {
            "$currentPath\public\categories\post\index.html" | Should -Exist
        }
        It "Should render the correct number (11) of tags" {
            Get-Content "$currentPath\public\tags\index.html" | Where-Object { $_ -like '*<li><a href="/tags/*' } | Measure-Object | select -ExpandProperty Count | Should -Be $expectedTagCount
        }
        It "Should render the actor tag" {
            "$currentPath\public\tags\actor\index.html" | Should -Exist
        }
        It "Should render the beach tag" {
            "$currentPath\public\tags\beach\index.html" | Should -Exist
        }
        It "Should render the bookcase tag" {
            "$currentPath\public\tags\bookcase\index.html" | Should -Exist
        }
        It "Should render the fahrenheit tag" {
            "$currentPath\public\tags\fahrenheit\index.html" | Should -Exist
        }
        It "Should render the interest tag" {
            "$currentPath\public\tags\interest\index.html" | Should -Exist
        }
        It "Should render the lamb tag" {
            "$currentPath\public\tags\lamb\index.html" | Should -Exist
        }
        It "Should render the nothing tag" {
            "$currentPath\public\tags\nothing\index.html" | Should -Exist
        }
        It "Should render the riddles tag" {
            "$currentPath\public\tags\riddles\index.html" | Should -Exist
        }
        It "Should render the shell tag" {
            "$currentPath\public\tags\shell\index.html" | Should -Exist
        }
        It "Should render the snowflakes tag" {
            "$currentPath\public\tags\snowflakes\index.html" | Should -Exist
        }
        It "Should render the visitor tag" {
            "$currentPath\public\tags\visitor\index.html" | Should -Exist
        }
    }
    Context "Disqus" {
        It "Should render the Disqus code block on a post" {
            Get-Content "$currentPath\public\post\the-actor-is-a-gander\index.html" -Raw | Should -BeLike "*s.src = 'https://example.disqus.com/embed.js'*"
        }
        It "Should NOT render the Disqus code block on the about page" {
            Get-Content "$currentPath\public\about\index.html" -Raw | Should -Not -BeLike "*s.src = 'https://example.disqus.com/embed.js'*"
        }
    }
    Context "Content validation" {
        It "Should contain the correct Hugo version (generator) on each page" {
            Get-ChildItem -Path "$currentPath\public" -Recurse | where { $_.Name -like "*.html" -or $_.Name -like "*.xml" } | Get-Content | Where-Object { $_ -like "*<meta name=""generator"" content=""Hugo $expectedVersionShort"" />*" } | Measure-Object | select -ExpandProperty Count | Should -Be $expectedPageswithHugoVersion
        }
        It "Should render a valid RSS feed (XML)" {
            { [xml]$rssFeed = Get-Content "$currentPath\public\index.xml" } | Should -Not -Throw
        }
        It "Should render all posts in the RSS feed" {
            [xml]$rssFeed = Get-Content "$currentPath\public\index.xml"
            $rssFeed.rss.channel.item.Count | Should -Be $expectedUrlsinRSSFeed
        }
        It "Should render the correct title for a page in the RSS feed" {
            [xml]$rssFeed = Get-Content "$currentPath\public\index.xml"
            $rssFeed.rss.channel.item[0].title | Should -Be "Extending this logic"
        }
        It "Should render the correct link for a page in the RSS feed" {
            [xml]$rssFeed = Get-Content "$currentPath\public\index.xml"
            $rssFeed.rss.channel.item[0].link | Should -Be "https://example.org/post/extending-this-logic/"
        }
        It "Should render the correct pubDate for a page in the RSS feed" {
            [xml]$rssFeed = Get-Content "$currentPath\public\index.xml"
            $rssFeed.rss.channel.item[0].pubDate | Should -Be "Fri, 09 Feb 2018 00:00:00 +0000"
        }
        It "Should render the correct description for a page in the RSS feed" {
            [xml]$rssFeed = Get-Content "$currentPath\public\index.xml"
            $rssFeed.rss.channel.item[0].description | Should -BeLike "The quiets could be said to resemble terete lambs.*"
        }
        It "Should render a valid Site Map (XML)" {
            { [xml]$siteMap = Get-Content "$currentPath\public\sitemap.xml" } | Should -Not -Throw
        }
        It "Should render all pages in the Site Map" {
            [xml]$siteMap = Get-Content "$currentPath\public\sitemap.xml"
            $siteMap.urlset.url.Count | Should -Be $expectedUrlsinSiteMap
        }
        It "Should render the correct URL for a page in the Site Pap" {
            [xml]$siteMap = Get-Content "$currentPath\public\sitemap.xml"
            $siteMap.urlset.url.loc | Should -Contain "https://example.org/post/extending-this-logic/"
        }
        It "Should render safe markdown (code box) on a specific page" {
            Get-Content "$currentPath\public\post\the-beach-is-a-push\index.html" -Raw | Should -BeLike '*<pre><code>In ancient times a whapping*'
        }
        It "Should render unsafe markdown (html) on a specific page" {
            Get-Content "$currentPath\public\post\extending-this-logic\index.html" -Raw | Should -BeLike '*<font style="color:red">This markdown is unsafe</font>*'
        }
        It "Should render the 'about' page to the root folder" {
            "$currentPath\public\about\index.html" | Should -Exist
        }
        It "Should render posts to the posts folder" {
            Get-ChildItem -Path "$currentPath\public\post" | Where-Object { $_.Mode -eq "d-----" } | Measure-Object | select -ExpandProperty Count | Should -Be $expectedPostsAll
        }
        It "Should render static content to the root folder" {
            "$currentPath\public\.gitkeep" | Should -Exist
        }
        It "Should render a correct link rel='alternate' tag to a category page" {
            Get-Content "$currentPath\public\categories\post\index.html" -Raw | Should -BeLike '*<link rel="alternate" type="application/rss+xml" href="https://example.org/categories/post/index.xml" title="Natrium Theme" />*'
        }
        It "Should render a correct link rel='alternate' tag to a tag page" {
            Get-Content "$currentPath\public\tags\shell\index.html" -Raw | Should -BeLike '*<link rel="alternate" type="application/rss+xml" href="https://example.org/tags/shell/index.xml" title="Natrium Theme" />*'
        }
    }
    AfterAll {
        # Clean up
        Remove-Item -Path "$currentPath\themes" -Recurse -Force
        Remove-Item -Path "$currentPath\public" -Recurse -Force
        Remove-Item -Path "$currentPath\resources" -Recurse -Force
        Remove-Item -Path "$currentPath\content\post\TestPost*" -Recurse -Force
    }
}
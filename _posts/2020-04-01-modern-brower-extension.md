---
layout: post
title: A modern (circa 2019) cross platform browser extension.
tags: project typescript
---

In mid 2019 I got the urge to work on a browser extension. It was pretty fun!

<div style="text-align: center">
  <a href="https://github.com/moribellamy/graytabby">
    <img src="/img/graytabby.png" style="width: 250px">
  </a>
</div>

* TOC
{:toc}

# Background

Everyone has different workflows when it comes to their browser tabs. Some
people open so many that you can no longer see a tab's title, and the favicon
is all that remains of the content.

I personally like to have a few pinned tabs. For me, if it's not worthy enough
to be pinned then it's not worthy enough to stick around. And if it IS worthy
enough to be pinned, then I want it open by default when the browser starts.
This heuristic helps me focus on one task at a time, which I find makes me more
effective.

It turns out that my preferences are not shared by most people. This makes a
default behavior of most browsers not exactly what I want. And since I'm always
looking for a cool new programming project, GrayTabby happened.

# Toolchain

Unsurprisingly, the UX for most web extensions is written in HTML and JS --
languages that the browser is already good at working with. This fact
decides a lot of the development toolchain.

## NodeJS / NPM / Webpack

At the end of the day, I need to be in an ecosystem with access to
good libraries that can compile down to HTML/JS/CSS. NPM is for
downloading and managing dependencies. Webpack is for bundling the
UI from its constituent ingredients. Node is the runtime for both of
these technologies.

## VSCode / Typescript

I'm extremely optimistic on VSCode. While it has the downside of
being in a hyperspeed ecosystem, it is also completely open and
backed by a major tech player (Microsoft). The TS and JS integrations
are the best I've seen in the industry.

I've gotten a ton of mileage out of the TS type system. Lots
of stupid bugs avoided. And the compiler is very flexible
in the kind of JS it targets.

[DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) is a
great repository of people who open-source their quality type declarations.


## Web Extension

Web extensions have a long history. I started paying attention when
they became a large part of Chrome. Eventually firefox supported
them too, mostly reverse engineering the Chrome API since so many
extensions had already been written for Chrome. Firefox is pushing
a [new standardization](https://github.com/browserext/browserext),
but browser makers aren't in a hurry to get on the same page here.

# Testing

Testing is a big pain and I almost wish I hadn't even bothered. I found
multiple bugs in the toolchain:

* [coverage report generation bug](https://github.com/gotwarlost/istanbul/issues/702)
* [coverage computation bug](https://github.com/istanbuljs/nyc/issues/1148)

Also, so much of the execution environment is too tightly integrated with the
browser. This is reasonable (it IS an browser extension, after all) but the
mocking logic is so complicated compared to the system under test.

# Packaging

This is the least fun part of the process. Bundling your code and submitting it
to a web store required a lot of extra steps. The process was even [outright
broken](https://github.com/mozilla/addons/issues/1085) for firefox. It really ought
to be a one-click solution for open source projects. If I have a travis-CI on
an open source project that produces the code, I should have a simple flow to
deploy it on a web store via an OAuth integration.

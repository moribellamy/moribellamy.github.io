---
layout: post
title: My Favorite Open Source Involvement Through 2023
tags: foss
---

Much of my activity is browsable on [my GitHub account page](https://github.com/moribellamy).
As such, I am part of the honored group which has code buried
[deep in the Svalbard archipelago](https://archiveprogram.github.com/arctic-vault/). So
that's pretty neat :).

* TOC
{:toc}

<div style="text-align: center">
  <div class="image-container">
    <img src="/img/gnu.png" alt="Image description">
  </div>
  <p class="caption">GNU, the cultural trend-setter for FOSS in a capitalist world.</p>
</div>

# Hadoop (2008)
I had a pleasant summer internship at Apple one year, researching if Hadoop could replace
their in-house analytics for music recommendations on the iTunes store. It could not (or,
at least, I could not ;). In the process I actively participated in a Hadoop mailing list.
Mostly I was asking questions, but I occasionally helped others.

I'm not sure how much survives, but I did find [one message from an online archive](https://web.archive.org/web/20231231232837/https://marc.info/?l=hadoop-dev&m=121684515011969&w=2)! Not even indexed by Google when you search my name. Talk about deep in the internet.

```
On Jul 22, 2008, at 12:22 PM, Mori Bellamy wrote:

> hey all,
> let us say that i have 3 boxes, A B and C. initially, map tasks are  
> running on all 3. after most of the mapping is done, C is 32% done  
> with reduce (so still copying stuff to its local disk) and A is  
> stuck on a particularly long map-task (it got an ill-behaved record  
> from the input splits). does A's intermediate map output data go  
> directly to C's local disk, or is it still written to HDFS and  
> therefore distributed amongst all the machines? also, will A's disk  
> be a favored target for A's output bytes, or is the target volume  
> independent of the corresponding mapper?
```

# Wavefront Agent (2015-2017)

[Wavefront](https://web.archive.org/web/20231118100420/https://docs.wavefront.com/wavefront_introduction.html) is a metrics ingestion, monitoring, and alerting solution.
It has been renamed a few times due to an acquisition.

I had an opportunity to contribute an open source open source parts of
Wavefront: the Agent. Intelligent batching and encoding enables greater
scale than more naive approaches.

I also had a hand in the creation and distribution of RPMs and DEBs
for said agent.

My favorite contribution to FOSS during this time is actually my participation
on a 8 year old (and presently unsolved) docker issue:
[TCP-RESET Packets are not masqueraded](https://github.com/moby/moby/issues/18630).
At that time in my journey, diagnosing a heisenbug in a machine's transport
layer was a heavy lift. The issue is so subtle, it remains open for 8 years and counting,
with someone chiming in once a year. It makes me ponder what "production quality"
means, in a good way.

# CPython (2022)

If you ever find yourself on Windows and you want to play a sound
through your computer's speakers, [I hope you will find it somewhat easier than before](https://github.com/python/cpython/issues/91061)

It's a small contribution, but Python is so important to me that I want to show it off anyway!

# Hobby Projects (2019-now)
Of course, we have some other `project` entries from this very blog.

[GrayTabby](/2020-04-01-modern-brower-extension) is named after my cat. It's a
browser extension compliant with the [WebExtensions API](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions), formalized by Mozilla. While it was fun, its value was marginal,
and eventually the History browsing experience of web browsers became good enough
to obviate it.

[Porygon](/2019-03-26-joycon-circuit) was an absolutely engaging romp
through the world of digital circuits and interfacing with them through GPIO.
I shared it with Pyninsula [in a talk](https://www.youtube.com/watch?v=wT6ftRm27fU).
That was the talk I learned that excitement makes talks run long, and I really
ought to practice talks in advance with timing in mind. Sorry to all attendees
for going over :).

[Platonic Game](https://github.com/moribellamy/platonic-game) is a simple
2D platformer designed to help debug issues in Godot. It is already used
in debugging [crashes for in-browser games on OSX](https://github.com/godotengine/godot/issues/65696).

# And to wrap up, participation
I think one of the overlooked things in open source participation is commenting on bug reports.
The anecdata and code snippets you post there are part of a larger process in which everyone
converges on something helpful to solve a complicated issue.

[GitHub comments ordered by time](https://github.com/search?q=is%3Aissue%20commenter%3Amoribellamy&type=issues)

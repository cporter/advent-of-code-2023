# advent-of-code-2023

Kickin' it 2015 style with [D](https://dlang.org/).

For any day's problem, it's probably

    cd dayN
    dub build
    ./dayN < input.txt

* [Day 1](day1/source/app.d). Fun little problem. Probably could have done more with ranges.
* [Day 2](day2/source/app.d). Need to spend a little more time and not just write Python in D.
* [Day 3](day3/source/app.d). Was it just me, or were there no wacky corner cases in this one? Though it does look like we're getting into problems for which the naive solution might take a second or two.
* [Day 4](day4/source/app.d). Our first problem where parsing the rules of the problem was the tricky part.
* [Day 5](day5/source/app.d). Big oof. I spent half an hour trying to find a start-at-the end solution and didn't realize that it was unnecessary until I really needed to go to sleep. So, slow day. But got to a quick solution the next day.
* [Day 6](day6/source/app.d). I spent solidly five minutes on this one worrying that there was an analytic solution and that it would be necessary to fit within compute time. Should have just done the brute force version first, as it was all that was necessary. (Update: yes, there is a [closed form solution](day6/closed_form.py))
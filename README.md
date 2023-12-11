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
* [Day 7](day7/day7.py). By this point it should be clear that I do the actual problems and then transliterate them into D to relearn D. I think I'm going to give that part up and just stick with Python. Anyway, didn't get the "just use the most frequent/highest ranking card" trick for part 2, but the brute force approach worked.
* [Day 8](day8/day8.py). This was the night of the town holiday parade, which was a *lot* of fun. I got home way too late for me to start in on an AOC problem, but I gave it a go anyway. Got part 1 and then a solution that looked right for part 2, but I couldn't make it pass so I went to sleep. Turned out that I just needed to start an enumeration at 1 instead of 0 and it would have worked. Fun!
* [Day 9](day9/day9.py). I didn't get the "just reverse it" trick here and instead both appended and prepended values. Oh well. Worked.
* [Day 10](day10/day10.py). Banged my head against part 1 for the longest time because I didn't line up the inputs/outputs of adjoining cells when constructing a graph.
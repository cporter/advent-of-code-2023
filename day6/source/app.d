import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.stdio;
import std.string;

void main()
{
	auto lines = stdin.byLineCopy.map!chomp.array;
	auto times = lines[0].split(":").back.chomp.split.map!(to!long).array;
	auto dists = lines[1].split(":").back.chomp.split.map!(to!long).array;

	long p1 = 1;
	foreach (t, d; zip(times, dists)) {
		long c = 0;
		foreach (i; iota(1, t)) {
			if (d < (i * (t - i))) {
				++c;
			}
		}
		p1 *= c;
	}

	long t = times.map!(to!string).joiner.to!long;
	long d = dists.map!(to!string).joiner.to!long;

	long p2 = 0;
	foreach (i; iota(1, t)) {
		if (d < (i * (t-i))) {
			++p2;
		}
	}

	writefln("p1: %d", p1);
	writefln("p2: %d", p2);
}

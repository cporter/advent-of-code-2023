import std.stdio;
import std.algorithm;
import std.array;
import std.conv;
import std.string;
import std.range;

enum int[string] MAXIMUM = [
	"red": 12,
	"green": 13,
	"blue": 14
];

void main()
{
	auto lines = stdin.byLine.map!(to!string).map!chomp;
	int p1 = 0;
	int p2 = 0;

	foreach (i, line; lines.enumerate(1)) {
		auto groups = line.split(":")[1].split(";");
		bool bad = false;
		int[string] local_max = [
			"red": 0,
			"green": 0,
			"blue": 0
		];
		foreach (group; groups) {
			auto colors = group.split(',');
			foreach (color; colors) {
				auto a = color.split();
				auto n = a.front.to!int;
				auto col = a.back.chomp;
				if (n > MAXIMUM[col]) {
					bad = true;
				}
				local_max[col] = max(local_max[col], n);
			}
		}
		if (! bad) {
			p1 += i;
		}
		p2 += reduce!((a, b) => a * b)(1, local_max.values);
	}

	writefln("p1: %d", p1);
	writefln("p2: %d", p2);
}

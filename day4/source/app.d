import std.algorithm.iteration : map, filter, sum;
import std.algorithm.searching : canFind;
import std.array;
import std.ascii;
import std.conv;
import std.math;
import std.range;
import std.stdio;
import std.string;

int[] parseLine(const string line) {
	return line.split().map!(to!int).array;
}

void main()
{
	int p1 = 0;
	auto lines = stdin.byLineCopy.map!chomp.array;
	auto cardcount = lines.map!(x => 1).array;
	foreach (i, line; lines.enumerate) {
		auto raw = line.split(":").back;
		auto numlists = raw.split("|");
		auto winners = parseLine(numlists.front);
		auto current = parseLine(numlists.back);
		
		auto ct = current.filter!(x => winners.canFind(x)).count;
		if (0 < ct) {
			p1 += pow(2, ct - 1);
			foreach(ii; iota(i + 1, i + 1 + ct)) {
				cardcount[ii] += cardcount[i];
			}
		}
	}

	writefln("p1: %d", p1);
	writefln("p2: %d", cardcount.sum);
}

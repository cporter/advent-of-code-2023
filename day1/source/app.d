import std.algorithm.iteration;
import std.array;
import std.ascii;
import std.conv;
import std.stdio;
import std.string;

int firstLastDigit(string cs) {
	auto numbers = cs.filter!(ch => ch.isDigit).map!(x => to!int([x])).array;
	int N = to!(int)(numbers.length);
	return 10 * numbers[0] + numbers[N-1];
}

enum int[string] DIGITS = [
	"0": 0, "1": 1, "2": 2, "3": 3, "4": 4,
	"5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
	"one": 1, "two": 2, "three": 3, "four": 4, "five": 5,
	"six": 6, "seven": 7, "eight": 8, "nine": 9
];

int firstLastDigitWords(string cs) {
	int[] numbers = [];
	while (0 < cs.length) {
		foreach(k, v; DIGITS) {
			if (cs.startsWith(k)) {
				numbers ~= v;
			}			
		}
		cs = cs[1..$];
	}
	int N = to!(int)(numbers.length);
	return 10 * numbers[0] + numbers[N-1];
}

void main()
{
	auto lines = stdin.byLine.map!(to!string).map!(chomp).array;
	auto p1 = lines.map!(l => l.firstLastDigit).sum;
	auto p2 = lines.map!(l => l.firstLastDigitWords).sum;

	writefln("part 1: %d", p1);
	writefln("part 2: %d", p2);
}

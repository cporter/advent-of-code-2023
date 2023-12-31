import std.algorithm.iteration;
import std.array;
import std.ascii;
import std.conv;
import std.stdio;
import std.string;

import stuff;

int firstLastDigit(string cs) {
	auto numbers = cs.filter!isDigit.map!(x => to!int([x])).array;
	return 10 * numbers.front + numbers.back;
}

enum int[string] DIGITS = [
	"0": 0, "1": 1, "2": 2, "3": 3, "4": 4,
	"5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
	"one": 1, "two": 2, "three": 3, "four": 4, "five": 5,
	"six": 6, "seven": 7, "eight": 8, "nine": 9
];

int firstDigit(string s) {
	foreach (k, v; DIGITS) {
		if (s.startsWith(k)) {
			return v;
		}
	}
	return -1;
}


int firstLastDigitWords(string cs) {
	auto numbers = cs.tails.map!(firstDigit)
		.filter!(x => x >= 0).array;
	return 10 * numbers.front + numbers.back;
}

void main()
{
	auto lines = stdin.byLine.map!(to!string).map!chomp.array;
	auto p1 = lines.map!firstLastDigit.sum;
	auto p2 = lines.map!firstLastDigitWords.sum;

	writefln("part 1: %d", p1);
	writefln("part 2: %d", p2);
}

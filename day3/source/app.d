import std.algorithm;
import std.array;
import std.ascii;
import std.conv:to;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

bool isNumber(const dchar ch) {
	return isDigit(ch);
}

bool isSymbol(const dchar ch) {
	return !(isNumber(ch) || ch == '.');
}

bool isGear(const dchar ch) {
	return ch == '*';
}

struct Coord {
	long row, col;
	bool opEquals(const Coord other) const {
		return row == other.row && col == other.col;
	}
	size_t toHash() const {
		return to!(size_t)(row << 8 + col);
	}
}

struct Number {
	Coord coord;
	dchar[] num;

	this(Coord _coord, const dchar ch) {
		coord = _coord;
		num = [ch];
	}

	void add(const dchar ch) {
		num ~= ch;
	}

	int value() const {
		return to!int(num);
	}

	bool near(const Coord cd) const {
		foreach(r; (coord.row - 1) .. (coord.row + 2)) {
			foreach(c; max(0, coord.col - 1) .. (coord.col + num.length + 1)) {
				if (cd.row == r && cd.col == c) {
					return true;
				}
			}
		}
		return false;
	}
}

unittest {
	auto n = Number(Coord(0, 0), '4');
	n.add('3');
	n.add('2');
	n.add('1');
	writefln("n.value = %d", n.value);
	assert(n.value == 4321);
	assert(n.near(Coord(0, 1)));
	assert(n.near(Coord(1, 4)));
}

void main()
{
	auto lines = stdin.byLine;
	Coord[] symbols;
	Coord[] gears;
	Number[] numbers = [];
	Nullable!Number number;
	number.nullify;

	foreach (row, line; lines.enumerate()) {
		foreach (col, ch; line.enumerate()) {
			if(isNumber(ch)) {
				if(number.isNull) {
					number = Number(Coord(row, col), ch);
				} else {
					number.get.add(ch);
				}
			} else {
				if (! number.isNull) {
					numbers ~= number.get;
					number.nullify;
				}
			} 
			if (isGear(ch)) {
				gears ~= Coord(row, col);
			} 
			if (isSymbol(ch)) {
				symbols ~= Coord(row, col);
			}
		}
		if (! number.isNull) {
			numbers ~= number.get;
			number.nullify;
		}
	}

	int p1 = 0;
	int p2 = 0;
	
	foreach(n; numbers) {
		if (! symbols.filter!(s => n.near(s)).empty) {
			p1 += n.value;
		}
	}

	foreach (g; gears) {
		auto close = numbers.filter!(n => n.near(g)).array;
		if (2 == close.length) {
			p2 += close.front.value() * close.back.value();
		}
	}

	writefln("p1: %d", p1);
	writefln("p2: %d", p2);
}

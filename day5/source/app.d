import std.algorithm;
import std.algorithm.comparison;
import std.container.dlist;
import std.conv;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

struct Range {
	long begin, end;

	this(long begin, long end) {
		assert(begin >= 0);
		assert(begin <= end);
		this.begin = begin;
		this.end = end;
	}

	long length() const {
		return end - begin;
	}

 	auto opCmp(const Range other) const {
		auto b = begin - other.begin;
		if (0 == b) { return end - other.end; }
		return b;
	}

	bool contains(long x) const {
		return begin <= x && x < end;
	}

	Range intersection(Range other) const {
		auto b = max(begin, other.begin);
		auto e = min(end, other.end);
		if (b <= e) {
			return Range(b, e);
		} else {
			return Range(0, 0);
		}
	}

	Range[] difference(Range other) const {
		Range[] ret;
		if (0 == intersection(other).length) {
			ret ~= this;
		} else {
			if (begin <= other.begin) {
				ret ~= Range(begin, other.begin);
			}
			if (end >= other.end) {
				ret ~= Range(other.end, end);
			}
		}
		return ret;
	}
}

struct Window {
	Range irange;
	long offset;

	bool contains(long x) const {
		return irange.contains(x);
	}

	bool contains(const Range r) const {
		return 0 < r.intersection(irange).length;
	}

	long compute(long x) const {
		if (irange.contains(x)) {
			return x + offset;
		} else {
			return x;
		}
	}

	Range compute(const Range r) const {
		auto ist = r.intersection(irange);
		if (0 < ist.length) {
			return Range(ist.begin + offset, ist.end + offset);
		} else {
			return Range(0, 0);
		}
	}

	auto difference(const Range r) const {
		return r.difference(irange);
	}

	auto intersection(const Range r) const {
		return r.intersection(irange);
	}
}

alias Windows = DList!Window;

struct Problem {
	long[] p1;
	Range[] p2;
	Window[][7] windows;
	int insertIndex = -1;

	void pushMap() {
		++insertIndex;
	}

	void addDestMap(long dest, long src, long size) {
		windows[insertIndex] ~= Window(Range(src, src + size), dest - src);
	}

	void parseProblem(R)(R lines) {
		foreach(line; lines) {
			if (0 == p1.length) {
				auto nums = line.split(":");
				foreach(s; nums[$-1].split()) {
					p1 ~= to!long(s);
				}
				foreach(i; iota(0, p1.length, 2)) {
					p2 ~= Range(p1[i], p1[i] + p1[i+1]);
				}
			} else if (0 == line.strip.length) {
				// pass
			} else if (line.endsWith("map:")) {
				pushMap();
			} else {
				auto nums = line.split.map!(to!long);
				addDestMap(nums[0], nums[1], nums[2]);
			}
		}
	}

	long location(long x) const {
		foreach (ws; windows) {
			foreach (w; ws) {
				if (w.contains(x)) {
					x = w.compute(x);
					break;
				}
			}
		}
		return x;
	}

	long computeP1() const {
		return p1.map!(x => location(x)).minElement;
	}

	long computeP2() const {
		return p2.map!(x => locationRange(x, 0)).minElement;
	}

	long locationRange(Range r, int index) const {
		if(index == windows.length) {
			return r.begin;
		}
		auto ws = windows[index];
		long smol = long.max;
		auto rs = new DList!Range;
		rs.insertBack(r);
		while (! rs.empty) {
			r = rs.front; rs.removeFront;
			Nullable!long current;
			foreach(w; ws) {
				if (w.contains(r)) {
					foreach(rr; w.difference(r)) {
						if (0 < rr.length) {
							rs.insertBack(rr);
						}
					}
					auto inter = w.compute(r);
					current = locationRange(inter, 1 + index);
					break;
				}
			}
			if (current.isNull) {
				current = locationRange(r, 1 + index);
			}
			smol = min(smol, current.get);
		}
		return smol;
	}
}

void main()
{
	auto lines = stdin.byLineCopy.map!(chomp);
	Problem p;
	p.parseProblem(lines);

	writefln("p1: %d", p.computeP1);
	writefln("p2: %d", p.computeP2);
}

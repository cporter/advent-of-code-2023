module stuff;

auto tails(R)(R r) {
	import std.range;
	struct Tails {
		R l;
		bool empty() const { return l.empty(); }
		void popFront() { if (! l.empty()) { l.popFront(); } }
		auto front() const { return l; }
	}
	return Tails(r);
}

unittest {
	import std.array;
	auto result = [1, 2, 3].tails.array;
	assert(! result.empty);
	assert([[1, 2, 3], [2, 3], [3]] == result);
}
from collections import defaultdict
from dataclasses import dataclass
from enum import IntEnum
from itertools import permutations
import sys
from typing import Optional, Tuple

cards = {
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    'T': 10,
    'J': 11,
    'Q': 12,
    'K': 13,
    'A': 14
}

def joke(ch: str) -> int:
    if 'J' == ch:
        return 0
    else:
        return cards[ch]

class Strength(IntEnum):
    HIGH_CARD = 1
    PAIR = 2
    TWO_PAIR = 3
    THREE_KIND = 4
    BOAT = 5
    FOUR_KIND = 6
    FIVE_KIND = 7

def _strength(hand) -> Tuple[int]:
    ret = []
    counts = defaultdict(int)
    for card in hand:
        counts[card] += 1

    biggest = max(counts.values())
    if len(counts) == 5:
        ret.append(Strength.HIGH_CARD)
    elif len(counts) == 4:
        ret.append(Strength.PAIR)
    elif len(counts) == 3:            
        if 2 == biggest:
            ret.append(Strength.TWO_PAIR)
        elif 3 == biggest:
            ret.append(Strength.THREE_KIND)
        else:
            assert(f"Whuck: {hand}.")
    elif len(counts) == 2:
        if 3 == biggest:
            ret.append(Strength.BOAT)
        elif 4 == biggest:
            ret.append(Strength.FOUR_KIND)
        else:
            assert(f"Whuck: {hand}")
    elif len(counts) == 1:
        ret.append(Strength.FIVE_KIND)

    return tuple(int(x) for x in ret)

def make_hand(hand, repl):
    ret = []
    for ch in hand:
        if 'J' == ch:
            ret.append(repl[0])
            repl = repl[1:]
        else:
            ret.append(ch)
    return ''.join(ret)

def hand_perms(hand, n, letters):
    for repl in set(
        x[:n] for x in permutations(''.join(ch * n for ch in letters))
    ):
        yield make_hand(hand, repl)

@dataclass
class Hand:
    hand: str
    bid: int
    _s2: Optional[int] = None

    def __repr__(self) -> str:
        return f"Hand<{self.hand}, {self.bid}>"

    def strength(self) -> Tuple[int]:
        return _strength(self.hand) + tuple(
            cards[card] for card in self.hand
        )

    def s2(self) -> Tuple[int]:
        if self._s2 is None:
            s1 = None
            if 'JJJJJ' == self.hand:
                s1 = (Strength.FIVE_KIND,)
            elif 'J' not in self.hand:
                s1 = _strength(self.hand)
            else:
                nj = sum(1 for x in self.hand if x == 'J')
                other_cards = set(x for x in self.hand if x != 'J')
                s1 = max(
                    _strength(h) for h in
                    hand_perms(self.hand, nj, other_cards)
                )
            self._s2 = s1 + tuple(joke(x) for x in self.hand)
        return self._s2

def main():
    lines = [x.strip() for x in sys.stdin]
    hands = []
    for line in lines:
        cards, bid = line.split()
        hands.append(Hand(hand = cards, bid = int(bid)))
    
    p1 = 0
    for i, hand in enumerate(sorted(hands, key = Hand.strength)):
        p1 += (1 + i) * hand.bid

    p2 = 0
    for i, hand in enumerate(sorted(hands, key = Hand.s2)):
        p2 += (1 + i) * hand.bid

    print(f"p1: {p1}")
    print(f"p2: {p2}")

if '__main__' == __name__:
    main()
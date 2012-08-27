#!/usr/bin/env python
from __future__ import division

__version__ = "$Revision$"

# Copyright 2008-2012 Michael M. Hoffman <mmh1@washington.edu>

from itertools import chain
from collections import deque
import re
import sys

FIELDNAMES = ["chrom", "chromStart", "chromEnd", # required
              "name", "score", "strand", "thickStart", "thickEnd", "itemRgb",
              "blockCount", "blockSizes", "blockStarts"]

class Datum(object):
    def __init__(self, words):
        self.__dict__ = dict(zip(FIELDNAMES, words))
        self._words = tuple(words)

    def __repr__(self):
        return "%s%s" % (self.__class__.__name__, self._words)

class NativeDatum(Datum):
    def __init__(self, *args, **kwargs):
        Datum.__init__(self, *args, **kwargs)

        # zero-based, http://genome.ucsc.edu/FAQ/FAQformat#format1
        self.chromStart = int(self.chromStart)
        self.chromEnd = int(self.chromEnd)

        try:
            self.score = float(self.score)
        except AttributeError:
            self._words = (self.chrom, self.chromStart,
                           self.chromEnd) + self._words[3:]
        else:
            self._words = (self.chrom, self.chromStart, self.chromEnd,
                           self.name, self.score) + self._words[5:]

def read(iterator, datum_cls=Datum):
    for line in iterator:
        words = line.split()
        if not words or words[0] == "track":
            continue # skip

        assert len(words) >= 3

        yield datum_cls(words)

def read_native(*args, **kwargs):
    return read(datum_cls=NativeDatum, *args, **kwargs)

def read_native_file(fname, *args, **kwargs):
    if not fname:
        return None
    with open(fname) as f:
        data = list(read_native(f, *args, **kwargs))
    return data

def parse_bed4(line):
    """
    alternate fast path
    """
    row = line.split()
    chrom, start, end, seg = row[:4]
    return row, (chrom, start, end, seg)

def iter_chroms(data):
    if data:
        chroms = set([datum.chrom for datum in data])
        for chrom in chroms:
            coords_list = [(datum.chromStart, datum.chromEnd) for datum in data if datum.chrom == chrom]
            starts, ends = map(deque, zip(*coords_list))
            yield chrom, (starts, ends)


re_trackline_split = re.compile(r"(?:[^ =]+=([\"'])[^\1]+?\1(?= |$)|[^ ]+)")
def get_trackline_and_reader(iterator, datum_cls=Datum):
    line = iterator.next()

    if line.startswith("track"):
        # retrieves group 1 of re_trackline_split match, which is the whole item
        trackline = [match.group(0)
                     for match in re_trackline_split.finditer(line)]
        reader = read(iterator, datum_cls)
    else:
        trackline = []
        reader = read(chain([line], iterator), datum_cls)

    return trackline, reader

def get_trackline_and_reader_native(*args, **kwargs):
    return get_trackline_and_reader(datum_cls=NativeDatum, *args, **kwargs)

def main(args=sys.argv[1:]):
    pass

if __name__ == "__main__":
    sys.exit(main())

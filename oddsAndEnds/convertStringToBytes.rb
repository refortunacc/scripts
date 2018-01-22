#!/usr/bin/env ruby
#

str = "UnpausedTimeSeconds"
str = "FlushLevelStreaming"


def bin_to_hex(s)
  s.each_byte.map { |b| " #{b.to_s(16)}" }.join
end


puts bin_to_hex( str )


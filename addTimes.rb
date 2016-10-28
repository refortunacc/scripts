#!/usr/bin/env ruby
#
class Track
    attr_accessor :duration

    def initialize(duration)
        @duration = duration
    end
end

t1 = gets
t2 = gets

arr = [Track.new(t1), Track.new(t2)]

total_seconds = arr.reduce(0) do |a, i| 
    min, sec = i.duration.split(":").map(&:to_i)
    a + min * 60 + sec
end

total_duration = '%d:%02d' % total_seconds.divmod(60)
print "#{total_duration}\n"

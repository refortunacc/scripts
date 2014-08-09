#!/usr/bin/env ruby
# Handy script to help you find pastables
# When you're trying to do X
#
# To Add:
# * xspy
# * xwininfo
# * xwatchwin
# * screenshot over x11
# 


def sshmasq( host )
  print "ssh -v -a  #{host} /bin/sh\n"
  print "unset HISTFILE HISTSIZE HISTFILESIZE\n"
end


sshmasq( "127.0.0.1" )

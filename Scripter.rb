#!/usr/bin/env ruby
#
# The purpose of this is to ensure that our actions while on a pentest are logged properly
# Each shell window should be scripted out to the right location

require 'process'

system( "mkdir -p ~/Foreground/Ops" ) # Ops is our log location

# Get the date and time
d = `date +%F:%H-%M`.chomp
# Get the shell's process id
ppid = Process.ppid

# Print the command to run:
print "**** Copy and Paste the below for a scripted window ****\n\n"

print "script -a ~/Foreground/Ops/script-#{d}_pid#{ppid}.txt\n"
print "export PS1=\"%{$fg[red]%}[SCRIPTED]%{$reset_color%} $PS1\"\n"

print "\n\n**** End C&P Block ****\n"

# 
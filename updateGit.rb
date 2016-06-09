#!/usr/bin/env ruby
#

$gitdir = "/opt/gitrepos/"

def updateRepo( directory )
    Dir.chdir( directory ) do
      print "Updating repo #{directory}\n" 
      system( "git submodule foreach \"(git checkout master ; git pull)\"" )
      system( "git checkout master ; git pull" )
    end
end

Dir.chdir( $gitdir )
Dir.entries(".").each do |entry|
  next if( entry =~ /^\.+$/i )
  if File.directory?(entry)
    # Do stuff
    updateRepo( "#{$gitdir}#{entry}" )
  else
    # Do nothing
  end
end


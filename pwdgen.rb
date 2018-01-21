#!/usr/bin/env ruby

require "part_of_speech"

@lexpath = "./lexicon.txt"
@dict = "./words.txt"
@dict = "./google-10000-english.txt"
@numPwds = 20

def validate_word( word )
  analyze = PartOfSpeech.analyze(@lexpath,word)
  case analyze[0][1] 
  when  "NN", "NNP", "NNPS", "NNS"
    # print "Noun\n"
  when "JJ", "JJR", "JJS"
    # print "Adjective\n"
  when "RP"
    # print "Particle\n"
  else
    # print "Other\n"
    return false
  end
  if( word.length < 4 || word.length > 9 )
    return false
  elsif( word.include? "'" )
    return false
  else
    return true
  end
end

def pick_random_line
  chosen_line = nil
  File.foreach(@dict). each_with_index do |line,number|
    chosen_line = line if rand < 1.0/(number+1)
    chosen_line.chomp!
    chosen_line.downcase!
  end
  return chosen_line
end

def select_words( num )
  (1..num).each do |iterate|
    word = nil
    loop do
      word = pick_random_line
      break if validate_word(word) == true
    end
    print "#{word} "
  end
  print "\n"
end

# Generate #num passwords

(1..@numPwds).each do 
  select_words( 4 )
end

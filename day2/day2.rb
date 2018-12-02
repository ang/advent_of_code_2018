require 'set'
require 'pp'

# --- Day 2: Inventory Management System ---
# You stop falling through time, catch your breath, and check the screen on the
# device. "Destination reached. Current Year: 1518. Current Location: North Pole
# Utility Closet 83N10." You made it! Now, to find those anomalies.
#
# Outside the utility closet, you hear footsteps and a voice. "...I'm not sure
# either. But now that so many people have chimneys, maybe he could sneak in that
# way?" Another voice responds, "Actually, we've been working on a new kind of
# suit that would let him fit through tight spaces like that. But, I heard that a
# few days ago, they lost the prototype fabric, the design plans, everything!
# Nobody on the team can even seem to remember important details of the project!"
#
# "Wouldn't they have had enough fabric to fill several boxes in the warehouse?
# They'd be stored together, so the box IDs should be similar. Too bad it would
# take forever to search the warehouse for two similar box IDs..." They walk too
# far away to hear any more.
#
# Late at night, you sneak to the warehouse - who knows what kinds of paradoxes
# you could cause if you were discovered - and use your fancy wrist device to
# quickly scan every box and produce a list of the likely candidates (your puzzle
# input).
#
# To make sure you didn't miss any, you scan the likely candidate boxes again,
# counting the number that have an ID containing exactly two of any letter and
# then separately counting those with exactly three of any letter. You can
# multiply those two counts together to get a rudimentary checksum and compare
# it to what your device predicts.
#
# For example, if you see the following box IDs:
#
# abcdef contains no letters that appear exactly two or three times.
# bababc contains two a and three b, so it counts for both.
# abbcde contains two b, but no letter appears exactly three times.
# abcccd contains three c, but no letter appears exactly two times.
# aabcdd contains two a and two d, but it only counts once.
# abcdee contains two e.
# ababab contains three a and three b, but it only counts once.
# Of these box IDs, four of them contain a letter which appears exactly twice, and
# three of them contain a letter which appears exactly three times. Multiplying
# these together produces a checksum of 4 * 3 = 12.
#
# What is the checksum for your list of box IDs?

def checksum(input_filename)
  appeared_twice = 0
  appeared_thrice = 0

  File.readlines(input_filename).each do |line|
    count = {}

    line.split('').each do |char|
      count[char] ||= 0
      count[char] += 1
    end

    appeared_twice += 1 if count.any? { |k, v| v == 2 }
    appeared_thrice += 1 if count.any? { |k, v| v == 3 }
  end

  appeared_twice * appeared_thrice
end

# --- Part Two ---
# Confident that your list of box IDs is complete, you're ready to find the
# boxes full of prototype fabric.
#
# The boxes will have IDs which differ by exactly one character at the same
# position in both strings. For example, given the following box IDs:
#
# abcde
# fghij
# klmno
# pqrst
# fguij
# axcye
# wvxyz
# The IDs abcde and axcye are close, but they differ by two characters (the
# second and fourth). However, the IDs fghij and fguij differ by exactly one
# character, the third (h and u). Those must be the correct boxes.
#
# What letters are common between the two correct box IDs? (In the example
# above, this is found by removing the differing character from either ID,
# producing fgij.)

def common_letters(input_filename)
  ids = []

  File.readlines(input_filename).each do |line|
    line = line.strip

    ids.each do |id|
      diff_index = diff_by_one(id, line)
      if diff_index != -1
        return line[0...diff_index] + line[diff_index+1..-1]
      end
    end

    ids << line
  end
end

# Assumes same length
# Returns -1 if not found
# Otherwise returns index of the diff
def diff_by_one(str1, str2)
  num_diffs = 0
  diff_index = -1

  str1.split('').each_with_index do |char, index|
    if char != str2[index]
      num_diffs += 1
      diff_index = index

      return -1 if num_diffs > 1
    end
  end

  return diff_index
end

puts checksum('sample.txt')
puts checksum('input.txt')
puts common_letters('sample_part2.txt')
puts common_letters('input.txt')

# Guessed megsdwpulhrifkatfjotzxcbq, which is wrong
# megsdwpulhrifkatfjotzxcbtq

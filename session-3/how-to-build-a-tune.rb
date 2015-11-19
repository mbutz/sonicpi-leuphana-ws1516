# Simple example, how
# + to create functions and 
# + to play structure a song using function calls and sleeps.
# Uses some effects and a little 'randomness'' trick to get a
# more interesting hihat beat.

# Exercises:
#
# Try to create a bass line which fits into this piece.
# Try to modify the drum and introduce some variation over the bars.
# Try to add some sample sounds.
# Try to change the melody function using other scales and/or notes.

# Change this number and make the tune slower or faster
use_bpm 90

# Change this number to get a different random selection of notes.
# If you like the selection, leave the number and you will always
# get the same 'random' notes.
use_random_seed 2

# This is our first 'function', a peace of code which will be
# evaluated once you click 'run' but only plays when it's called 
# (see at the bottom of this file). One function of a 'function' 
# is to organize the code in a more lucid way.

# The function defines the two melodies. One in quarters, one in eighths.
# 'in_thread' makes sure both parts play together.
define :pentatonic_melodies do
  # pentatonic melody no. 1
  in_thread do
    8.times do
      play scale(:a4, :minor_pentatonic).choose
      sleep 1
    end
  end
  # pentatonic melody no. 2 (halftime)
  in_thread do
    16.times do
      sleep 0.25
      play scale(:a5, :minor_pentatonic, num_octaves: 2).choose, amp: 0.2
      sleep 0.25
    end
  end
end

# The next function sets up the kick and snare drum. The 'in_thread'
# makes sure that the kick/snare will play together with the next
# function preparing the hihat...
define :drums do
   in_thread do
    2.times do
      sample :drum_bass_soft, amp: 1.3
      sleep 0.25
      sample :drum_bass_soft
      sleep 0.75
      with_fx :reverb, room: 0.5 do
        sample :drum_snare_hard, amp: 1.5
      end
      sleep 1
      sample :drum_bass_soft, amp: 1.3
      sleep 0.25
      sample :drum_bass_soft
      sleep 0.75
      with_fx :reverb, room: 0.5 do
        sample :drum_snare_hard, amp: 1.5
      end
      sleep 1
     end
  end
end

# This function defines the hihat. It has a little trick using a random
# number to set accents. Here the 'in_thead' guarantees that the
# 8 beat pause is not a rest beween the 4 parts of the piece but
# a pause which stitches the parts together seemlessly. 
# Exercise:
# If you remove the 'sleep 8'-bits, one part will lay over each other.
# Try to remove the diffent 'in_thread's, the sleep-commands between
# the parts and try to figure out why is happening what is happening.
define :hihat do
  in_thread do
    2.times do
      16.times do
        # This is quite an interesting way to introduce random accents:
        # Calculate a random number inbetween 0 and 100.
        # See, if this number is smaller than 25. What actually happens:
        # Play the loud cymbal with a probability of 25%.
        if (rrand(0,100)) < 25 
          sample :drum_cymbal_closed, amp: 1.2
        else
          sample :drum_cymbal_closed, amp: 0.3
        end
        sleep 0.25
      end
    end
  end
end

# Play the song
puts "Playing bar 1 - 8 ..."
with_fx :reverb, room: 0.3 do
  # Here comes a 'function call' to the 'pentatonic_melodies'-function. 
  # Just imagine that by calling the function the above code is inserted 
  # here. The function name thus is a placeholder for the code above. 
  # But this is not the only thing you can do with a function...
  pentatonic_melodies
end

sleep 8

puts "Playing bar 9 - 16 ..."
with_fx :reverb, room: 0.3 do
  pentatonic_melodies
end
drums
hihat

sleep 8

puts "Playing bar 17 - 24 ..."
with_fx :reverb, room: 0.3 do
  pentatonic_melodies
end
drums
hihat

sleep 8

puts "Playing bar 25 - 32 ..."
with_fx :reverb, room: 0.3 do
  pentatonic_melodies
end









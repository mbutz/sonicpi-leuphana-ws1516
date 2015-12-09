# Sequencing Drum in Sonic Pi - Solution No. 2

use_debug true
use_bpm 100

load_samples [:drum_bass_hard, :drum_bass_soft, :drum_snare_hard, :drum_snare_soft, :drum_cymbal_closed]

# Return note duration based on the defined rythmic pattern
# This functions is needs a list as a parameter (ptn); it will
# check whether this contains 1, 2, 4, 8, 16 or 32 values and
# return a sleep time; if the list contains other than the mentioned
# number of values it returns an error message.
define :get_dur do |ptn|
  if ptn.count == 1
    d = 4
  elsif ptn.count == 2
    d = 2
  elsif ptn.count == 4
    d = 1
  elsif ptn.count == 8
    d = 0.5
  elsif ptn.count == 16
    d = 0.25
  elsif ptn.count == 32
    d = 0.125
  else
    puts "NOTE: No idea what rythmic pattern you mean!"
  end
  return d
end

# This function plays a sample repeatedly with given parameters:
# smpl  = name of the sample
# amp   = volume
# rate  = rate (velocity and pitch)
# pan   = direction concerning the stereo panorama
# start = start time (whole sample runs from 0 = start until
#         1 = the sample length; thus 0.5 means, the sample
#         start after 50% of its length)
# fin   = end time of sample
# ptn   = rhythmic pattern for sample repetition
#
# Note: the function is not bullit proof; it only works if you
# provide all parameters even if you do not want to change the
# default values; this is because it does make things easier
# to understand. More elegant it would be (but also more complicated)
# if we you'd only have to provide e.g. the parameter for amp if you
# intended to deviate from the default value.
# Also we could provide all the parameters in a list ... but let's
# leave it like this to keep an easy abstraction level.

define :play_sample do | smpl, amp, rate, pan, start, fin, ptn |

  # Work out the sleep time
  # You see: You can call a function to do some work from
  # within another function; the return value of "get_dur" is
  # handed over to the variable d
  d = get_dur ptn

  # "ptn.each do" part of a native ruby block (ruby being the programming
  # language, Sonic Pi is being made of). It is also a function or rather
  # method which is 'called on' a list called ptn. It does similar things
  # as e.g. the "tick" method in that it goes through each value of the list.
  # It does this by implementing a counter "i" for each value of the list.
  ptn.each do |i|
    # If the list "ptn" at the number i is not 0, then play the sample
    # with the given parameters.
    if i != 0
      sample smpl, amp: amp, rate: rate, pan: pan, start: start, finish: fin
    end
    # Then sleep for the time specified by the variable "d".
    sleep d
  end
end

# Patterns for Bass and Snare

# You could define a rhythmic pattern as a list assigned to
# a variable just as we did in sequencing-drums-01.rb.
# Only this would be a local variable; you could not transfer
# it from one buffer to another. But as long as you keep your
# variables in one and the same file/buffer it is okay to do so.
#
# Following is an example how you can transfer variables between
# files/buffers. Just wrap them with a function; once you eval this
# code (= press run in Sonic Pi), you can use them in any buffer.

define :get_bass_on_ptn do
  bass_on_ptn_1    = [1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0]
end
define :get_bass_of_ptn do
  bass_of_ptn_1    = [0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0]
end
define :get_snre_on_ptn do
  snre_on_ptn_1    = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]
end
define :get_snre_of_ptn do
  snre_of_ptn_1    = [0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0]
end

# Patterns for Hihat

define :get_hiht_on_ptn do
  hiht_on_ptn      = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]
end
define :get_hiht_of_ptn do
  hiht_of_ptn      = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
end
define :get_hiht_lo_ptn do
  hiht_lo_ptn      = [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
end
define :get_hiht_hi_ptn do
  hiht_hi_ptn      = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
end

# Sequence for Bass and Snare

#
# Here we define our 'instruments' and the overall structure e.g.
# for one bar. We call the function "play_sample" with our defined
# parameters. Thus we can e.g. control the amplitude or the rate
# of the sample.
#
# Try to experiment with changing the rate in different patterns
# You can also replace the rate value by an expression such as
# rrand(0.5, 1.5) to make it change every time it is called.

define :mod_bass_snare do
  in_thread do
    4.times do
      play_sample :drum_bass_hard, 1.0, 0.75, -0.2, 0, 1, get_bass_on_ptn
      get_bass_on_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_bass_hard, 0.75, 0.5, -0.2, 0, 1, get_bass_of_ptn
      get_bass_of_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_snare_hard, 0.75, 1.275, -0.1, 0, 1, get_snre_on_ptn
      get_snre_on_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_snare_hard, 1, 1.3, -0.1, 0, 1, get_snre_of_ptn
      get_snre_of_ptn
    end
  end
end

# Sequence for Hihat

define :mod_hihat do
  in_thread do
    4.times do
      play_sample :drum_cymbal_closed, 0.75, 1, -0.5, 0, 0.4, get_hiht_on_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_cymbal_closed, 0.75, 1.3, -0.5, 0, 0.3, get_hiht_of_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_cymbal_closed, 1, 1, -0.4, 0.0, 0.6, get_hiht_lo_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_cymbal_closed, 1, 1, -0.4, 0.0, 0.6, get_hiht_hi_ptn
    end
  end
end


mod_bass_snare
mod_hihat

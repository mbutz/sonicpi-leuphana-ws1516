# Sequencing Drum in Sonic Pi - Solution No. 1 (using 'tick')

use_debug false
use_bpm 100
set_sched_ahead_time! 1

load_samples [:drum_bass_hard, :drum_bass_soft, :drum_snare_hard, :drum_snare_soft, :drum_cymbal_closed]

#
# Set up lists for the rhythmic patterns; every number signifies a
# (potential) duration, 0 is a rest and 1 is a hit
# If a list contains 4 values these are quarter notes (8 = eighths
# and 16 = sextenths)
# Every list is linked to one sample and its parameters; thus the
# lists are named according to whether they are on or off-beat-
# patterns (for the off-beat the amplitude of the sample is lower than
# for the on-beats)

# bass patterns
bass_pattern_on  = [ 1,0,0,0, 0,0,0,1, 0,0,0,0, 0,0,0,0 ]
bass_pattern_of  = [ 0,1,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0 ]

# snare patterns
snare_pattern_on = [ 0,1,0,1 ]
snare_pattern_of = [ 0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,1,1 ]

# hihat pattern
hihat_pattern_on = [ 1,0,1,0, 1,0,0,1, 0,1,0,1, 1,0,0,1 ]
hihat_pattern_of = [ 0,1,0,1, 0,1,1,0, 1,0,1,0, 0,1,1,0 ]
hihat_pattern_op = [ 0,0,0,0, 0,0,0,1 ]


# Uncomment if you would like to make a function which
# you can call repeatingly; one call of this code represents
# one bar; so if you call this function with "4.times do" you
# will get a pattern of 4 bars

define :drums do

# Play the Bass
in_thread do
  16.times do
    # "tick" is a handy function (also called "method") build in
    # Sonic Pi; it generates a counter which increments every time
    # it is called (1,2,3 and so forth); if you apply "tick" to a list
    # within a loop, it will walk through the list; thus the first time
    # we call it here it is raised from 0 to 1; at the sextenth repetition
    # the value of tick is 15; the result is that this line checks 16 times
    # whether the current value of the list "bass_pattern_on" is greater
    # greater than 0; if it is the sample will be play and then sleep for
    # 0.25 seconds, if not the code just sleeps and we have a rest.
    sample :drum_bass_hard if bass_pattern_on.tick > 0
    # Sleep times have to be adjusted according to the number of
    # values in your rhythm pattern: if your pattern contains 16 values
    # the sleep time is 4 (quarter notes) / 16 or 1 quarter note / 4 = 0.25
    sleep 0.25
  end
end

in_thread do
  16.times do
    sample :drum_bass_soft, amp: 0.5 if bass_pattern_of.tick > 0
    sleep 0.25
  end
end

# Play the Snare

in_thread do
  4.times do
    sample :drum_snare_hard if snare_pattern_on.tick > 0
    sleep 1
  end
end

in_thread do
  16.times do
    sample :drum_snare_soft, amp: 0.5 if snare_pattern_of.tick > 0
    sleep 0.25
  end
end

# Play the Hihatbass_pattern_of  = [ 0,1,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0 ]

in_thread do
  16.times do
    sample :drum_cymbal_closed, amp: 0.75 if hihat_pattern_on.tick > 0
    sleep 0.25
  end
end

in_thread do
  16.times do
    sample :drum_cymbal_closed, amp: 0.375 if hihat_pattern_of.tick > 0
    sleep 0.25
  end
end

in_thread do
  8.times do
    # Here we 'close' the open hihat by clipping the sample after
    # 17.5 % of its runtime
    sample :drum_cymbal_open, amp: 0.5, finish: 0.175 if hihat_pattern_op.tick > 0
    sleep 0.5
  end
end

# Uncomment if you would like to make a function which
# you can call repeatingly; one call of this code represents
# one bar; so if you call this function with "4.times do" you
# will get a pattern of 4 bars

end #:drums

# You can pack parts of or all drum elements into functions
# Then it'll be easier to use it a a module within a song
comment do
  4.times do
    drums
    sleep 4
  end
end
















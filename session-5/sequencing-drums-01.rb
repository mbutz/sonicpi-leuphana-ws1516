# Sequencing Drum in Sonic Pi - Solution No. 1 (using 'tick')
# TODO: Comment in detail

use_debug false
use_bpm 100

load_samples [:drum_bass_hard, :drum_bass_soft, :drum_snare_hard, :drum_snare_soft, :drum_cymbal_closed]

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


#define :drums do

# Play the Bass
in_thread do
  16.times do
    sample :drum_bass_hard if bass_pattern_on.tick > 0
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

# Play the Hihat
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
    sample :drum_cymbal_open, amp: 0.5, finish: 0.175 if hihat_pattern_op.tick > 0
    sleep 0.5
  end
end

#end #:drums



# You can pack parts of or all drum elements into functions
# Then it'll be easier to use it a a module within a song
comment do
  4.times do
    drums
    sleep 4
  end
end


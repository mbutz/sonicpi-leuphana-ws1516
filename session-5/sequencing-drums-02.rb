# Sequencing Drum in Sonic Pi - Solution No. 2
# TODO: Comment in detail

use_debug true
use_bpm 100

load_samples [:drum_bass_hard, :drum_bass_soft, :drum_snare_hard, :drum_snare_soft, :drum_cymbal_closed]

# Return note duration based on the defined rythmic pattern
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


define :play_sample do | smpl, amp, rate, pan, start, fin, ptn |
  # take orders, what and how to play

  # work out time measure
  d = get_dur ptn

  ptn.each do |i|
    if i != 0
      sample smpl, amp: amp, rate: rate, pan: pan, start: start, finish: fin
    end
    sleep d
  end
end

# Patterns for Bass and Snare

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

define :mod_bass_snare do
  in_thread do
    4.times do
      play_sample :drum_bass_hard, 1.0, 0.75, -0.2, 0, 1, get_bass_on_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_bass_hard, 0.75, 0.5, -0.2, 0, 1, get_bass_of_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_snare_hard, 0.75, 1.275, -0.1, 0, 1, get_snre_on_ptn
    end
  end
  in_thread do
    4.times do
      play_sample :drum_snare_hard, 1, 1.3, -0.1, 0, 1, get_snre_of_ptn
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

# -*- coding: utf-8 -*-
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 1. Termin
# Part II - Adding the Drums

use_bpm 110               # set timing for the whole file
use_debug false           # out only important things to reduce load
# set_sched_ahead_time! 2 # maybe we need to give SP time to prepare

########################################
# We need some drums!
########################################

# Play some drum samples
comment do
  use_bpm 60
  12.times do
    list_of_drum_samples = [:drum_heavy_kick,
                            :drum_bass_soft,
                            :drum_bass_hard,
                            :drum_snare_soft,
                            :drum_snare_hard,
                            :drum_cymbal_soft,
                            :drum_cymbal_hard,
                            :drum_cymbal_open,
                            :drum_cymbal_closed,
                            :drum_cymbal_pedal]

    sample list_of_drum_samples.tick
    sleep 1
  end
end

comment do
  sample :drum_cymbal_open #, rate: 1, start: 0, finish: 0.15
end

comment do
  sample :ambi_choir, rate: 1, start: 0, finish: 1
  sleep 1
  sample :guit_e_fifths, rate: 1.3
end

# Create a drum pattern like so:

#        | 1 e + e | 2 e + e | 3 e + e | 4 e + e |
# bass:  | x x - - | - - - x | - x x - | - - - x |
# snare: | - - - - | x - - - | - - - - | x - - - |
# hihat: | x x x X | x x x X | x x x X | x x x X |

comment do
  4.times do
    sample :drum_bass_soft
    sleep 0.25              # 16th * 1
    sample :drum_bass_soft
    sleep 0.75              # 16th * 3
    sample :elec_hi_snare
    sleep 0.75              # 16th * 3
    sample :drum_bass_soft
    sleep 0.5               # 16th * 2
    sample :drum_bass_soft
    sleep 0.25              # 16th * 1
    sample :drum_bass_soft
    sleep 0.5               # 16th * 2
    sample :elec_hi_snare
    sleep 0.75              # 16th * 3
    sample :drum_bass_soft
    sleep 0.25              # 16th * 1
  end
end

# hihat
comment do
  4.times do
    3.times do              # 16th * 3 hits, reduced volume
      sample :drum_cymbal_closed, amp: 0.5
      sleep 0.25            # 16th * 1
    end
    1.times do              # 16th * 1 hit, normal volume => accentuated
      sample :drum_cymbal_closed
      sleep 0.25
    end
  end
end

# Combine bass drum, snare and hihat
comment do
  in_thread do
    1.times do
      sample :drum_bass_soft
      sleep 0.25
      sample :drum_bass_soft
      sleep 0.75
      sample :elec_hi_snare
      sleep 0.75
      sample :drum_bass_soft
      sleep 0.5
      sample :drum_bass_soft
      sleep 0.25
      sample :drum_bass_soft
      sleep 0.5
      sample :elec_hi_snare
      sleep 0.75
      sample :drum_bass_soft
      sleep 0.25
    end
  end

  in_thread do
    4.times do
      3.times do
        sample :drum_cymbal_closed, amp: 0.5
        sleep 0.25
      end
      1.times do
        sample :drum_cymbal_closed
        sleep 0.25
      end
    end
  end
end

########################################
# Playing it all together!
########################################

uncomment do

  # The Bass Line

  # Set up our bass line
  bassline = [:b2,:b3,:e2,:e2,    # Bar 1
              :r,:r,:e3,:g2,
              :r,:e2,:g3,:e2,
              :r,:g3,:e2,:g2,
              :r,:e3,:e2,:g3,     # Bar 2
              :e2,:r,:g2,:r,
              :e2,:g3,:e2,:g2,
              :r,:d2,:e2,:g2,
              :a2,:r,:e2,:a2,     # Bar 3
              :r,:e3,:a3,:a2,
              :gs2,:r,:r,:e2,
              :gs2,:gs3,:e2,:gs3,
              :r,:e2,:e3,:gs3,    # Bar 4
              :e2,:r,:gs3,:e2,
              :gs2,:r,:e3,:gs2,
              :r,:e2,:a2,:as2]

  # Now play it
  in_thread do
    with_bpm 110 do
      with_synth :fm do
        use_synth_defaults amp: 0.5, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 65
        play_pattern_timed bassline, [8.0 / 32 * 1] # here we use the var 'baseline'
      end
    end
  end

  # The Chords

  in_thread do
    with_synth :hollow do
      use_synth_defaults amp: 3, attack: 0.1, sustain: 1, release: 5, noise: 4
      with_fx :reverb, room: 0.5 do
        play_pattern_timed [[:b3,:d4,:fs4,:a4,:b4,:fs5],
                            [:a3,:d4,:g4,:a4,:g5],
        [:a3,:e4,:a4,:b4,:e5],[:gs3,:e4,:gs4,:b4,:e5]],
          [(0.5 * 3), (0.5 * 13), (0.5 * 3),(0.5 * 13)]
      end
    end
  end

  # The Drums

  in_thread do
    (1*4).times do
      sample :drum_bass_soft
      sleep 0.25
      sample :drum_bass_soft
      sleep 0.75
      with_fx :reverb, room: 0.5 do
        sample :elec_hi_snare, amp: 2.5
      end
      sleep 0.75
      sample :drum_bass_soft
      sleep 0.5
      sample :drum_bass_soft
      sleep 0.25
      sample :drum_bass_soft
      sleep 0.5
      with_fx :reverb, room: 0.5 do
        sample :elec_hi_snare, amp: 2.5
      end
      sleep 0.75
      sample :drum_bass_soft
      sleep 0.25
    end
  end

  in_thread do
    (4*4).times do
      3.times do
        sample :drum_cymbal_closed, amp: 0.5
        sleep 0.25
      end
      1.times do
        sample :drum_cymbal_closed
        sleep 0.25
      end
    end
  end

end #comment

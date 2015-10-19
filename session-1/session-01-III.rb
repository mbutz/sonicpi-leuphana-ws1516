# -*- coding: utf-8 -*-
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 1. Termin
# Part III - Adding a 'Brass' Section and some 'Flitter'

use_bpm 110               # set timing for the whole file
use_debug false           # out only important things to reduce load
# set_sched_ahead_time! 2 # maybe we need to give SP time to prepare

########################################
# The 'Brass' Section
########################################
comment do

  use_synth :fm
  use_synth_defaults amp: 1, attack: 0, sustain: 0, release: 0.2

  phrase_a = [:r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:b4,
              :d5,:fs5,:d5,:r,
              :fs5,:r,:fs5,:d5,
              :r,:r,:b4,:r,
              :a4,:b4,:r,:r,
              :a5,:r,:a5,:fs5]
  phrase_b = [:r,:r,:d5,:r,
              :a4,:b4,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:b4,:r,
              :d5,:r,:e5,:fs5]
  phrase_c = [:r,:r,:d5,:r,
              :a4,:b4,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:b5,:r,
              :gs5,:r,:e5,:d5]


  play_pattern_timed phrase_a, [0.25]
  play_pattern_timed phrase_b, [0.25]
  play_pattern_timed phrase_a, [0.25]
  play_pattern_timed phrase_c, [0.25]
end

########################################
# The 'Flitter'
########################################
comment do

  # Define a pool of notes per chord
  b_chord = [:b5,:d6,:fs6,:a6,:b6,:d7,:fs7,:a7]
  g_chord = [:g5,:a5,:d6,:g6,:a6,:d7,:g7,:a7]
  a_chord = [:a5,:b5,:e6,:g6,:a6,:b6,:e7,:g7,:a7]
  e_chord = [:e5,:gs5,:b5,:e6,:gs6,:b6,:e7,:gs7,:b7]

  # Choose one at a time and play them in a row
  comment do
    with_synth :fm do
      use_synth_defaults amp: 0.5, attack: 0.1, sustain: 0, release: 0.1
      8.times do
        play b_chord.choose
        sleep 4.0/16  # after any repetition sleep for one 16th
      end
    end
  end

  # Play Flitter with Bass Line
  uncomment do

    in_thread do
      with_synth :pretty_bell do
        use_synth_defaults amp: 0.1, attack: 0.1, sustain: 0.2, release: 0
        with_random_seed rrand(4,8) do
          with_fx :reverb, room: 1 do
            2.times do                 #      Bar 1
              6.times do               # play |xxxx xx-- ---- ----|
                play b_chord.choose
                sleep 4.0/16 * 1
              end                      #      Bar 1 + whole 2nd Bar
              26.times do              # play |---- --xx xxxx xxxx|
                play g_chord.choose
                sleep 4.0/16 * 1
              end
              6.times do               #      Bar 3
                play a_chord.choose    # play |xxxx xx-- ---- ----|
                sleep 4.0/16 * 1
              end                      #      Bar 3 + whole 4th Bar
              26.times do              # play |---- --xx xxxx xxxx|
                play e_chord.choose
                sleep 4.0/16 * 1
              end
            end
          end
        end
      end
    end

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

    in_thread do
      with_synth :fm do
        use_synth_defaults amp: 0.5, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 65
        2.times do
          play_pattern_timed bassline, [8.0 / 32 * 1] # here we use the var 'baseline'
        end
      end
    end


  end #comment

end #comment

########################################
# Playing it all together!
########################################
uncomment do

  # The Chords

  in_thread do
    with_synth :hollow do
      use_synth_defaults amp: 3, attack: 0.1, sustain: 1, release: 5, noise: 4
      with_fx :reverb, room: 0.5 do
        2.times do
          play_pattern_timed [[:b3,:d4,:fs4,:a4,:b4,:fs5],
                              [:a3,:d4,:g4,:a4,:g5],
          [:a3,:e4,:a4,:b4,:e5],[:gs3,:e4,:gs4,:b4,:e5]],
            [(0.5 * 3), (0.5 * 13), (0.5 * 3),(0.5 * 13)]
        end
      end
    end
  end

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

  in_thread do
    with_synth :fm do
      use_synth_defaults amp: 0.5, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 65
      2.times do
        play_pattern_timed bassline, [8.0 / 32 * 1] # here we use the var 'baseline'
      end
    end
  end

  # The Drums
  in_thread do
    (1*8).times do
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
    (4*8).times do
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

  # The Brass Section
  phrase_a = [:r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:b4,
              :d5,:fs5,:d5,:r,
              :fs5,:r,:fs5,:d5,
              :r,:r,:b4,:r,
              :a4,:b4,:r,:r,
              :a5,:r,:a5,:fs5]
  phrase_b = [:r,:r,:d5,:r,
              :a4,:b4,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:b4,:r,
              :d5,:r,:e5,:fs5]
  phrase_c = [:r,:r,:d5,:r,
              :a4,:b4,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:r,:r,
              :r,:r,:b5,:r,
              :gs5,:r,:e5,:d5]

  in_thread do
    with_synth :subpulse do
      use_synth_defaults amp: 0.9, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 100, pan: -0.5
      with_fx :reverb, room: 0.4 do
        play_pattern_timed phrase_a, [0.25]
        play_pattern_timed phrase_b, [0.25]
        play_pattern_timed phrase_a, [0.25]
        play_pattern_timed phrase_c, [0.25]
      end
    end
  end

  # The Flitter

  b_chord = [:b5,:d6,:fs6,:a6,:b6,:d7,:fs7,:a7]
  g_chord = [:g5,:a5,:d6,:g6,:a6,:d7,:g7,:a7]
  a_chord = [:a5,:b5,:e6,:g6,:a6,:b6,:e7,:g7,:a7]
  e_chord = [:e5,:gs5,:b5,:e6,:gs6,:b6,:e7,:gs7,:b7]

  in_thread do
    with_synth :pretty_bell do
      use_synth_defaults amp: 0.1, attack: 0.1, sustain: 0.2, release: 0
      with_random_seed rrand(4,8) do
        with_fx :reverb, room: 1 do
          2.times do
            6.times do
              play b_chord.choose
              sleep 4.0/16 * 1
            end
            26.times do
              play g_chord.choose
              sleep 4.0/16 * 1
            end
            6.times do
              play a_chord.choose
              sleep 4.0/16 * 1
            end
            26.times do
              play e_chord.choose
              sleep 4.0/16 * 1
            end
          end
        end
      end
    end
  end
end #comment

# -*- coding: utf-8 -*-
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 1. Termin
# Part IV - Putting It All Together with 'live_looping'

use_bpm 110               # set timing for the whole file
use_debug true           # out only important things to reduce load
set_sched_ahead_time! 2   # maybe we need to give SP time to prepare

#########################################
# Metronome Helper Functions for synching
#########################################

# Count every beat
live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.5, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.5, rate: 2.0
  sleep 16
end

#########################################
# Set up the Sound Material
#########################################

# Set up our bass line
bassline = [:b2,:b3,:e2,:e2,:r,:r,:e3,:g2,:r,:e2,:g3,:e2,:r,:g3,:e2,:g2,      # Bar 1
            :r,:e3,:e2,:g3,:e2,:r,:g2,:r,:e2,:g3,:e2,:g2,:r,:d2,:e2,:g2,      # Bar 2
            :a2,:r,:e2,:a2,:r,:e3,:a3,:a2,:gs2,:r,:r,:e2,:gs2,:gs3,:e2,:gs3,  # Bar 3
            :r,:e2,:e3,:gs3,:e2,:r,:gs3,:e2,:gs2,:r,:e3,:gs2,:r,:e2,:a2,:as2] # Bar 4

# Set up the Brass Section
phrase_a = [:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:b4,:d5,:fs5,:d5,:r,
            :fs5,:r,:fs5,:d5,:r,:r,:b4,:r,:a4,:b4,:r,:r,:a5,:r,:a5,:fs5]
phrase_b = [:r,:r,:d5,:r,:a4,:b4,:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,
            :r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:b4,:r,:d5,:r,:e5,:fs5]
phrase_c = [:r,:r,:d5,:r,:a4,:b4,:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,
            :r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:b5,:r,:gs5,:r,:e5,:d5]

# Set up the Flitter
b_chord = [:b5,:d6,:fs6,:a6,:b6,:d7,:fs7,:a7]
g_chord = [:g5,:a5,:d6,:g6,:a6,:d7,:g7,:a7]
a_chord = [:a5,:b5,:e6,:g6,:a6,:b6,:e7,:g7,:a7]
e_chord = [:e5,:gs5,:b5,:e6,:gs6,:b6,:e7,:gs7,:b7]

# Set up the 2nd brass section
# Helper function for various durations and crescendi/decrescendi
# notes and rests
n = [[:a4],[:d5],[:d5],[:cs5],[:a4],[:b4],[:fs4],[:a4,:e5],[:e4,:gs4,:e5],[:d3,:e4,:d4,:e5],[:e4,:e5,:d5]]
  # duration for notes and rest; fade in/out
  # if fade needed use subarray [ note, 1 = fade-in, 0 = fade-out ]
  d = [[6,1],0.5,0.5,0.5,0.5,1,0.5,[2,1],[2.5,0],1,1]
  ratio = 0.9

  # This function plays note lengths and rests according to the given value
  define :play_synth do | notes, durations |
    notes.zip(durations).each do | n, d |
      if n != :r # check if note or rest
        if d.is_a?(Array) # check if fade is needed
          if d[1] == 1 # fade in
            play n, amp: 0.5, attack: d[0] * (ratio * 1/3), sustain: d[0] * (ratio * 2/3), release: d[0] * (1-ratio)
            sleep d[0]
          else # fade out
            play n, amp: 0.5, attack: d[0] * (1-ratio), sustain: 0, release: d[0] * ratio
            sleep d[0]
          end
        else
          play n, sustain: d * ratio
          sleep d
        end
      else
        sleep d
      end
    end
  end
 
#########################################
# Clumsy Mixer
#########################################
# 1 starts, 0 stops the loops

chords    = 0
brass1    = 0
brass2    = 0
bass      = 0
drums     = 0
hihat1    = 0
hihat2    = 0
flittr    = 0

chords_lv = 1 # 3
brass1_lv = 0.9 # 0.9
brass2_lv = 0.3 # 0.3
flittr_lv = 0.0 # 0.3

#########################################
# Love Loops for Playing
#########################################

uncomment do

  # The Chords
  live_loop :chords, autocue: false do
    stop if chords < 1
    sync :every_four_bars # reaches over 4 bars so we want it to wait
    with_synth :hollow do
      use_synth_defaults amp: chords_lv, attack: 0.1, sustain: 1, release: 5, noise: 4
      with_fx :reverb, room: 0.5 do
        play_pattern_timed [[:b3,:d4,:fs4,:a4,:b4,:fs5],
                            [:a3,:d4,:g4,:a4,:g5],
        [:a3,:e4,:a4,:b4,:e5],[:gs3,:e4,:gs4,:b4,:e5]],
          [(0.5 * 3), (0.5 * 13), (0.5 * 3),(0.5 * 13)]
      end
    end
  end
end

# The Bass Line
live_loop :bass, autocue: false do
  stop if bass < 1
  sync :every_four_bars # reaches over 4 bars so we want it to wait
  with_synth :fm do
    use_synth_defaults amp: 0.5, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 65
    play_pattern_timed bassline, [8.0 / 32 * 1]
  end
end

# The Drums

# Bass Drum and Snare
live_loop :bass_snare, autocue: false do
  stop if drums < 1
  sync :every_two_bars # a one bar pattern; played twice to match the bass line
  2.times do
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

# Hihat2
live_loop :hihat1, autocue: false do
  stop if hihat1 < 1
  sync :every_two_bars # a one quarter pattern; played 4 times x2 for 2 bars
  (4*2).times do
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.5, finish: 1
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.35, finish: 0.1
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.15, finish: 0.2
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.35, finish: 0.1
    #sleep 0.25
  end
end

# Hihat2
live_loop :hihat2, autocue: false do
  stop if hihat2 < 1
  sync :every_two_bars # a one quarter pattern; played 4 times x2 for 2 bars
  (4*2).times do
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.75
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
  end
end

live_loop :brass1, autocue: false do
  stop if brass1 < 1
  sync :every_four_bars
  with_synth :sine do
    use_synth_defaults amp: brass1_lv, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 100, pan: -0.5
    with_fx :reverb, room: 0.75 do
      play_pattern_timed phrase_a, [0.25]
      play_pattern_timed phrase_b, [0.25]
      play_pattern_timed phrase_a, [0.25]
      play_pattern_timed phrase_c, [0.25]
    end
  end
end

live_loop :brass2, autocue: false do
  stop if brass2 < 1
  sync :every_four_bars
  with_synth :subpulse do
    use_synth_defaults amp: brass2_lv, attack: 0, sustain: 0, release: 0.15
    with_fx :reverb, room: 0.75 do
      #with_transpose +12 do
        play_synth n, d
      #end
    end
  end
end

# The Flitter
live_loop :flitter, autocue: false do
  stop if flittr < 1
  sync :every_four_bars
  with_synth :pretty_bell do
    use_synth_defaults amp: flittr_lv, attack: 0.1, sustain: 0.2, release: 0
    with_random_seed 11865 do
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

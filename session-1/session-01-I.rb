# -*- coding: utf-8 -*-
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 1. Termin
# Part I - Notes and Chords

set_sched_ahead_time! 0

########################################
# First Notes
########################################

# Play some notes in a row:

comment do
  play 71
  sleep 1
  play 83
end

# Play some notes simultaneously
comment do
  play 59
  play 62
  play 66
  play 69
  play 71
  play 78

  sleep 1

  play 50
  play 62
  play 67
  play 69
  play 79
end

# Shape the sound (ADSR envelope)
uncomment do
  play 60 #, amp: 1, attack: 0, sustain: 0, release: 0, pan: 0
end

# Use names instead of midi numbers
comment do
  play :b3  # b-minor7
  play :d4
  play :fs4
  play :a4
  play :b4
  play :fs5
  sleep 1
  play :a3  # Gadd9
  play :d4
  play :g4
  play :a4
  play :g5
  sleep 1
  play :a3  # Asus9
  play :e4
  play :a4
  play :b4
  play :e5
  sleep 1
  play :gs3 # G#/E-major
  play :e4
  play :gs4
  play :b4
  play :e5
end

# Use the names and give play a list
comment do
  play_pattern_timed [:b3,:d4,:fs4,:a4,:b4,:fs5], 0.075
  sleep 1
  play_pattern_timed [:a3,:d4,:g4,:a4,:g5], 0.075
  sleep 1
  play_pattern_timed [:a3,:e4,:a4,:b4,:e5], 0.075
  sleep 1
  play_pattern_timed [:gs3,:e4,:gs4,:b4,:e5], 0.075
end

# Give the chords a more rythmic character
#        |  Bar 1           |  Bar 2           |  Bar 3           |  Bar 4           |
#        |  1 + 2 + 3 + 4 + |  1 + 2 + 3 + 4 + |  1 + 2 + 3 + 4 + |  1 + 2 + 3 + 4 + |
# Chords |  ^     ^         |                  |  ^     ^         |                  |
#        |  3/8   13/8                            3/8   13/8
#        |  8 * 8th per bar = 0.5 bpm
comment do
  with_bpm 110 do
    # with_synth :saw do
    # use_synth_defaults amp: 0.6, attack: 0.1, sustain: 0.5, release: 3
    play_pattern_timed [[:b3,:d4,:fs4,:a4,:b4,:fs5],
                        [:a3,:d4,:g4,:a4,:g5],
    [:a3,:e4,:a4,:b4,:e5],[:gs3,:e4,:gs4,:b4,:e5]],
      [(0.5 * 3), (0.5 * 13), (0.5 * 3)]
    # end
  end
end

########################################
# What about a bass line?
########################################

# 4 notes for 4 bars
comment do
  with_bpm 110 do
    play_pattern_timed [:b2,:e2,:a2,:gs2], [4]
  end
end

# This does really sound like a reasonably decent bass line, does it?
# ADSR envelope:
# manipulate volume (amp), start-up-time (attack), duration (sustain) and finish (release)
comment do
  with_bpm 110 do
    with_synth :fm do
      # use_synth_defaults attack: 0, sustain: 0.1, release: 0.1, cutoff: 70
      use_synth_defaults amp: 1, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 65
      play_pattern_timed [:b2,:b3,:b2,:b3,:e2,:e3,:e2,:e3,:a2,:a3,:a2,:a3,:gs2,:gs3,:gs2,:gs3], [1]
    end
  end
end

# Supply a tiny bit more sophisted bass line
# and set a rhythm in 16ths
comment do
  # define the notes
  # write a list and store it into a variable called 'baseline'
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

  # play the line
  with_bpm 110 do
    with_synth :fm do
      # use_synth_defaults attack: 0, sustain: 0.1, release: 0.1, cutoff: 70
      use_synth_defaults amp: 1, attack: 0.0, sustain: 0.15, release: 0.01, cutoff: 65
      play_pattern_timed bassline, [8.0 / 32 * 1] # here we use the var 'baseline'
    end
  end

end #comment

########################################
# Playing chords and bass at one time
########################################
comment do

  # Let's make a general bpm declaration;
  # this can be noted at top of the file
  use_bpm 110

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

  # the chords

  in_thread do
    with_synth :hollow do
      use_synth_defaults amp: 4, attack: 0.1, sustain: 1, release: 5, noise: 4
      # with_fx :reverb, room: 0.5 do
        play_pattern_timed [[:b3,:d4,:fs4,:a4,:b4,:fs5],
                            [:a3,:d4,:g4,:a4,:g5],
        [:a3,:e4,:a4,:b4,:e5],[:gs3,:e4,:gs4,:b4,:e5]],
          [(0.5 * 3), (0.5 * 13), (0.5 * 3),(0.5 * 13)]
      #end
    end
  end

end #comment

# coding: utf-8
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 3. Termin
# Elements of Musical Theory

use_bpm 120

# The Material of Music
############################################################

comment do

  # A continious range of possible frequencies

  up = play :c1, sustain: 15, note_slide: 15
  control up, note: :c7
  sleep 16
  down = play :c7, sustain: 15, note_slide: 15
  control down, note: :c2

end

comment do

  # In western Music mostly we use descrete notes
  # Semitones and the chromatic scale

  play_pattern [60,61,62,63,64,65,66,67,68,69,70,71,72]

end

# Scales
############################################################

comment do

  # The C-Major Scale
  
  define :play_with_amp do | list |
    list.each do |i|
      control (play i[0], amp: i[2])
      sleep i[1]
    end
  end

  play_with_amp [[:c,1,1],[:cs,1,0.1],[:d,1,1],[:ds,1,0.1],[:e,1,1],[:f,1,1],
                 [:fs,1,0.1],[:g,1,1],[:gs,1,0.1],[:a,1,1],[:bb,1,0.1],[:b,1,1],[:c5,1,1]]
  
  sleep 1
  play_pattern [60,62,64,65,67,69,71,72]

end #comment

uncomment do
  
  # A scale usually consists of half and whole (or two half) tone steps.
  # For the major scale applies the following structure:
  # c - 1 - d - 1 - e  - 1/2 f - 1 - g - 1 - a - 1 -  b - 1/2 -  c

  play_pattern_timed scale(:c, :major), 1
  # sleep 2

  # The differentiating character of scales thus depends on
  # 1. How many tones the scale has (usually 7)
  # 2. The distribution of half and whole tone steps

  # A minor scale could e.g. look like this:
  # c - 1 - d - 1/2 - eb - 1 - f - 1 - g - 1/2 - ab - 1 - bb - 1 - c

  #play_pattern_timed scale(:c, :aeolian), 1
  #sleep 2

end #comment

  # To make things even more complicated:
# There are several major and minor scales and some where it is not
# quite clear whether they are major or minor.

with_bpm 160 do

  comment do

    # Some examples for major scales:

    play_pattern_timed scale(:c, :major), 0.75
    sleep 4

    play_pattern_timed scale(:c, :lydian), 0.75
    sleep 4

    play_pattern_timed scale(:c, :mixolydian), 0.75
    sleep 4

  end #comment

  comment do

    # Some examples for minor scales:

    play_pattern_timed scale(:c, :dorian), 0.75
    sleep 4

    play_pattern_timed scale(:c, :phrygian), 0.75
    sleep 4

    play_pattern_timed scale(:c, :aeolian), 0.75
    sleep 4

  end #comment

  # A scale must not have 7 tones. A wide range of 
  # music is based on pentatonic scales, scales with 5 notes.

  comment do

    #play_pattern_timed scale(:c, :major_pentatonic), 0.75
    sleep 2

    play_pattern_timed scale(:c, :minor_pentatonic), 0.75
    sleep 2

  end #comment

end

comment do

  # With these you can't do much 'wrong'; e.g.:

  48.times do
    play scale(:c, :minor_pentatonic, num_octaves: 2).choose, release: 2
    sleep 0.25
  end

end


# Intervalls
############################################################

comment do

# English      Notation within chord symbols   Deutsch 
# Unison                                       Prime             
# Minor Second                         b9      kl. Sekunde
# Major Second                          9      gr. Sekunde
# Minor Third                          b3      kl. Terz
# Major Third                           3      gr. Terz
# Perfect Fourth                       11      Quarte
# Augmented Fourth                    #11/b5   übermäß. Quarte
# Diminished Fifth                     b5      vermind. Quinte
# Perfect Fifth                         5      Quinte
# Augmented Fifth                      #5      übermäß. Quinte
# Minor Sixth                         b13      kl. Sechste
# Major Sixth                          13      gr. Sechste
# Minor Seventh                        b7      kl. Septime
# Major Seventh                         7      gr. Septime
# Octave                                       Oktave
# Diminished Ninth                     b9      kl. None
# Ninth                                 9      gr. None

  puts "Second (2)"
  4.times do
    play_pattern_timed [:c, :d], 1
  end

  sleep 5

  puts "Minor Third (b3)"
  4.times do
    play_pattern_timed [:c, :eb], 1
  end

  sleep 2
  
  puts "Major Third (3)"
  4.times do
    play_pattern_timed [:c, :e], 1
  end

  sleep 5

  puts "Fourth (11)"
  4.times do
    play_pattern_timed [:c, :f], 1
  end

  sleep 2
  
  puts "Fifth (5)"
  4.times do
    play_pattern_timed [:c, :g], 1
  end

  sleep 5

    puts "Minor Seventh (b7)"
  4.times do
    play_pattern_timed [:c, :bb], 1
  end

  sleep 2
  
  puts "Major Seventh (7)"
  4.times do
    play_pattern_timed [:c, :b], 1
  end

  sleep 2
  
  puts "Octave"
  4.times do
    play_pattern_timed [:c4, :c5], 1
  end

  sleep 2
  
  puts "Ninth (9)"
  4.times do
    play_pattern_timed [:c4, :d5], 1
  end

  
end #comment

comment do 

  # The above Intervalls ordered according to consonance and dissonance

  puts "Octave"
  4.times do
    play [:c4, :c5]
    sleep 1
  end

  sleep 4
  
  puts "Fifth (5)"
  4.times do
    play [:c, :g]
    sleep 1
  end

  sleep 4
  
  puts "Fourth (11)"
  4.times do
    play [:c, :f]
    sleep 1
  end

  sleep 8
  
  puts "Minor Third (b3)"
  4.times do
    play [:c, :eb]
    sleep 1
  end

  sleep 4
  
  puts "Major Third (3)"
  4.times do
    play [:c, :e]
    sleep 1
  end

  sleep 8
  
  puts "Second (2)"
  4.times do
    play [:c, :d]
    sleep 1
  end

  sleep 4

  puts "Ninth (9)"
  4.times do
    play [:c4, :d5]
    sleep 1
  end

  sleep 4

  puts "Minor Seventh (b7)"
  4.times do
    play [:c, :bb]
    sleep 1
  end

  sleep 4
  
  puts "Major Seventh (7)"
  4.times do
    play [:c, :b]
    sleep 1
  end

  sleep 8
  
  puts "Tritone or diminished Fifth (b5)"
  4.times do
    play [:c, :gb]
    sleep 1
  end
  
end

comment do
  # Tension and Resolution
  # This is one of the base principles in all Western Music
  # V => I, or the resolution from the dominant to the tonic
  # by means of a voice leading from dissonance to consonance
  # (G) f \ e 
  # (C) b / c

  play [:f, :b], sustain: 1, release: 1
  sleep 4
  play [:e, :c5], sustain: 1, release: 3
  sleep 4
  play [:f], sustain: 1, release: 1
  sleep 4
  play [:e], sustain: 1, release: 1
  sleep 4
  play [:b], sustain: 1, release: 1
  sleep 4
  play [:c5], sustain: 1, release: 1
  sleep 4
  play [:f, :b], sustain: 1, release: 1
  sleep 4
  play [:e, :c5], sustain: 1, release: 3
  sleep 6

  # Played with full chords and bass

  play :g2, sustain: 2, release: 1
  play invert_chord(chord_degree(5, :c3, :major, 4), 2), sustain: 2, release: 1
  sleep 3
  play :c2, sustain: 2, release: 3
  play invert_chord(chord_degree(1, :c4, :major, 3), 1), sustain: 2, release: 3

end #comment

comment do
  
  # Chords from intervalls

  # A fifth
  play_pattern_timed [:c, :g], 1
  sleep 2
  play [:c, :g], sustain: 2, release: 1
  sleep 6

  # Add a note inbetween the fifth, now we have a major third with a 
  # minor third build upon it:
  # C Major
  play_pattern_timed [:c, :e, :g], 1
  sleep 2
  play chord(:c, :major), sustain: 2, release: 1
  sleep 6

  # A minor third and a major third
  # C minor
  play_pattern_timed [:c, :eb, :g], 1
  sleep 2
  play chord(:c, :minor), sustain: 2, release: 1
  sleep 6

end

comment do

  # We can manipulate the fifth
  # C diminished
  play_pattern_timed [:c, :eb, :gb], 1
  sleep 2
  play chord(:c, :diminished), sustain: 2, release: 1
  sleep 6

  # C diminished
  play_pattern_timed [:c, :e, :gs], 1
  sleep 2
  play chord(:c, :augmented), sustain: 2, release: 1
  sleep 6
  
end

comment do

  # We can add another third upon our structure
  # C major 7
  play_pattern_timed [:c, :e, :g, :b], 1
  sleep 2
  play chord(:c, :M7), sustain: 2, release: 1
  sleep 6

  # C minor 7
  play_pattern_timed [:c, :eb, :g, :bb], 1
  sleep 2
  play chord(:c, :m7), sustain: 2, release: 1
  sleep 6
  
end

comment do

  # And more ...
  # C major 7
  play_pattern_timed [:c, :e, :g, :b, :d5], 1
  sleep 2
  play [:c, :e, :g, :b, :d5], sustain: 2, release: 1
  sleep 6

  # C minor 7
  play_pattern_timed [:c, :eb, :g, :bb, :d5], 1
  sleep 2
  play [:c, :eb, :g, :bb, :d5], sustain: 2, release: 1
  sleep 6
  
end

comment do

  # We can leave out the first third (which tells us whether we 
  # have a major or minor chord) and create a undecided mode.

  # C 4sus7
  play_pattern_timed [:c, :f, :g, :bb], 1
  sleep 2
  play chord(:c, '7sus4'), sustain: 2, release: 1

  sleep 6

end

comment do

  # In terms of classical music theory classical this would always be considered as 
  # the 'suspension of the quart' having to be resolved into a following major triad.

  # With resolution
  use_synth :fm
  play chord(:c5, '7sus4'), sustain: 3, release: 1
  sleep 3
  play chord(:c5, :dom7), sustain: 3, release: 1
  sleep 3
  play invert_chord(chord(:f4), 2), sustain: 2, release: 2
  
end

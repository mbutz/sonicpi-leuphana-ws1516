# coding: utf-8
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 3. Termin
# Elements of Musical Theory

use_bpm 120

# The Material of Musik
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

comment do
  
  # A scale usually consists of half and whole (or two half) tone steps.
  # For the major scale applies the following structure:
  # c - 1 - d - 1 - e  - 1/2 f - 1 - g - 1 - a - 1 -  b - 1/2 -  c

  play_pattern_timed scale(:c, :major), 1
  sleep 2

  # The differentiating character of scales thus depends on
  # 1. How many tones the scale has (usually 7)
  # 2. The distribution of half and whole tone steps

  # A minor scale could e.g. look like this:
  # c - 1 - d - 1/2 - eb - 1 - f - 1 - g - 1/2 - ab - 1 - bb - 1 - c

  play_pattern_timed scale(:c, :aeolian), 1
  sleep 2

end #comment

  # To make things even more complicated:
# There are several major and minor scales and some where it is not
# quite clear whether they are major or minor.

with_bpm 160 do

  comment do

    # Some examples for major scales:

    play_pattern_timed scale(:c, :major), 0.75
    sleep 2

    play_pattern_timed scale(:c, :lydian), 0.75
    sleep 2

    play_pattern_timed scale(:c, :mixolydian), 0.75
    sleep 2

  end #comment

  comment do

    # Some examples for minor scales:

    play_pattern_timed scale(:c, :dorian), 0.75
    sleep 2

    play_pattern_timed scale(:c, :phrygian), 0.75
    sleep 2

    play_pattern_timed scale(:c, :aeolian), 0.75
    sleep 2

  end #comment

  # A scale must not have 7 tones. A wide range of 
  # music is based on pentatonic scales, scales with 5 notes.

  comment do

    play_pattern_timed scale(:c, :major_pentatonic), 0.75
    sleep 2

    play_pattern_timed scale(:c, :minor_pentatonic), 0.75
    sleep 2

  end #comment

end

comment do

  # With these you can't do much 'wrong'; e.g.:

  48.times do
    play scale(:c, :major_pentatonic, num_octaves: 2).choose
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
# Major Seventh                         7      gr. Semtime
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
  
  puts "Tritone or diminished Fith (b5)"
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

  play [:f, :b], sustain: 1, release: 1
  sleep 2
  play [:e, :c5], sustain: 1, release: 3
  sleep 4
  play [:f]
  sleep 2
  play [:e]
  sleep 2
  play [:b]
  sleep 2
  play [:c5]
  sleep 4
  play [:f, :b], sustain: 1, release: 1
  sleep 2
  play [:e, :c5], sustain: 1, release: 3
  sleep 6

  # Played with full chords and bass

  play :g2, sustain: 2, release: 1
  play invert_chord(chord_degree(5, :c3, :major, 4), 2), sustain: 2, release: 1
  sleep 3
  play :c2, sustain: 2, release: 3
  play invert_chord(chord_degree(1, :c4, :major, 3), 1), sustain: 2, release: 3

end #comment

# Chords
############################################################

comment do
  # Intervalls are the corner stones of chords; especially the
  # third; to call a bunch of tones a third there must be at
  # least one third (or its inversion: a sixth). Usually chords
  # are build of a succession of thirds.

  # A succession of fiths:
  
  play [:c4, :g4], sustain: 2, release: 1
  sleep 2
  play [:f4, :c5], sustain: 2, release: 1
  sleep 2
  play [:g4, :d5], sustain: 2, release: 1

end

comment do

  # Add a note between these two notes and you will get
  # two thirds - one build over the other.
  
  play chord(:c, :major), sustain: 2, release: 1
  sleep 2
  play chord(:f, :major), sustain: 2, release: 1
  sleep 2
  play chord(:g, :major), sustain: 2, release: 1

  sleep 6

  play invert_chord(chord(:c, :major), 1), sustain: 2, release: 1
  sleep 2
  play invert_chord(chord(:f, :major), 0), sustain: 2, release: 1
  sleep 2
  play invert_chord(chord(:g3, :major), 2), sustain: 2, release: 1
  
end

comment do
  # The above played chords have the structure:
  # Bass tone - major third - minor third
  # This makes all of them major chords.
  # You can also choose:
  # # Bass tone - minor third - major third
  # This makes all of them minor chords.
  
  play chord(:c, :minor), sustain: 2, release: 1
  sleep 2
  play chord(:f, :minor), sustain: 2, release: 1
  sleep 2
  play chord(:g, :minor), sustain: 2, release: 1

  sleep 6

  play invert_chord(chord(:c, :minor), 1), sustain: 2, release: 1
  sleep 2
  play invert_chord(chord(:f, :minor), 0), sustain: 2, release: 1
  sleep 2
  play invert_chord(chord(:g3, :minor), 2), sustain: 2, release: 1
  
end

uncomment do

  # A chord does 1. not necessarily have to have two thirds and 2. can
  # have more than three notes. These are the reasons, why you'll find
  # so many chord types in Sonic Pi:

    play chord(:C, '1')
    sleep 1
    play chord(:C, '5')
    sleep 1
    play chord(:C, '+5')
    sleep 1
    play chord(:C, 'm+5')
    sleep 1
    play chord(:C, :sus2)
    sleep 1
    play chord(:C, :sus4)
    sleep 1
    play chord(:C, '6')
    sleep 1
    play chord(:C, :m6)
    sleep 1
    play chord(:C, '7sus2')
    sleep 1
    play chord(:C, '7sus4')
    sleep 1
    play chord(:C, '7-5')
    sleep 1
    play chord(:C, 'm7-5')
    sleep 1
    play chord(:C, '7+5')
    sleep 1
    play chord(:C, 'm7+5')
    sleep 1
    play chord(:C, '9')
    sleep 1
    play chord(:C, :m9)
    sleep 1
    play chord(:C, 'm7+9')
    sleep 1
    play chord(:C, :maj9)
    sleep 1
    play chord(:C, '9sus4')
    sleep 1
    play chord(:C, '6*9')
    sleep 1
    play chord(:C, 'm6*9')
    sleep 1
    play chord(:C, '7-9')
    sleep 1
    play chord(:C, 'm7-9')
    sleep 1
    play chord(:C, '7-10')
    sleep 1
    play chord(:C, '9+5')
    sleep 1
    play chord(:C, 'm9+5')
    sleep 1
    play chord(:C, '7+5-9')
    sleep 1
    play chord(:C, 'm7+5-9')
    sleep 1
    play chord(:C, '11')
    sleep 1
    play chord(:C, :m11)
    sleep 1
    play chord(:C, :maj11)
    sleep 1
    play chord(:C, '11+')
    sleep 1
    play chord(:C, 'm11+')
    sleep 1
    play chord(:C, '13')
    sleep 1
    play chord(:C, :m13)
    sleep 1
    play chord(:C, :major)
    sleep 1
    play chord(:C, :M)
    sleep 1
    play chord(:C, :minor)
    sleep 1
    play chord(:C, :m)
    sleep 1
    play chord(:C, :major7)
    sleep 1
    play chord(:C, :dom7)
    sleep 1
    play chord(:C, '7')
    sleep 1
    play chord(:C, :M7)
    sleep 1
    play chord(:C, :minor7)
    sleep 1
    play chord(:C, :m7)
    sleep 1
    play chord(:C, :augmented)
    sleep 1
    play chord(:C, :a)
    sleep 1
    play chord(:C, :diminished)
    sleep 1
    play chord(:C, :dim)
    sleep 1
    play chord(:C, :i)
    sleep 1
    play chord(:C, :diminished7)
    sleep 1
    play chord(:C, :dim7)
    sleep 1
    play chord(:C, :i7)
    sleep 1

  
end

with_bpm 120 do

  use_synth :fm
  use_synth_defaults amp: 1, divisor: 0.05, depth: 20, attack: 0, sustain: 0, release: 1
  
  degrees = (ring 1,2,3,4,5,6,7,8)
  
  comment do

    # On every note of our C-Major scale you can build a chord using
    # only the material of this scale. That's called 'diatonic'.
    # It gives you:
    # C-Major, D-Minor, E-Minor, F-Major, G-Major, A-Minor, B-diminished 

    # A side note: 
    # We 'tick' through our ring 'degrees'; tick increments with every
    # loop run so our list of dregrees will be 'ticked' through.
    # 'chord_degree' takes four arguments: dgree, tonic, scale, number of notes.

    # Arpeggiate the chord notes
    8.times do
      play_pattern_timed chord_degree(degrees.tick, :c, :major, 3), 0.25
      sleep 1
    end
    
    sleep 2

    # Play real Chords
    8.times do
      play chord_degree(degrees.tick, :c, :major, 3), release: 1.75
      sleep 2
    end

  end # comment

  # Use triads for the following example
  num_of_notes = 3

  comment do

    # Now let's sort our chords in a particular way
    # GO ON FROM HERE

    play chord_degree(6, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(3, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(2, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(5, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(1, :c, :major, num_of_notes), release: 1.5
    sleep 4

    # Chord: a   e   d   G   C 
    # -----------------------------------------------
    #        e \ b \ a / d \ g
    #        c \ g \ f / b \ e
    #        a \ e / d / g \ c

    # Once more with arpeggiated notes:
    play_pattern_timed chord_degree(6, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 1
    play_pattern_timed chord_degree(3, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 1
    play_pattern_timed chord_degree(2, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 1
    play_pattern_timed chord_degree(5, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 1
    play_pattern_timed chord_degree(1, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 1

  end

  comment do

    # Let's invert some of the chords to make the melodic flow more smoothly'
    # 'Inversion' means move the base chord tone to the top; with a triad you
    # can do this two times until the chord has its original shape again.
    # What's happening here is, that you optimise the melodic flow of the notes;
    # You create 'voicings' and move the notes more smoothly than without inversions.
    
    # Chord: a   e   d   G   C 
    # -----------------------------------------------
    #        e - e \ d - d \ c
    #        c \ b \ a / b \ g
    #        a \ g \ f / g \ e

    play invert_chord(chord_degree(6, :c, :major, num_of_notes), 0), release: 1.5
    sleep 2
    play invert_chord(chord_degree(3, :c, :major, num_of_notes), 1), release: 1.5
    sleep 2
    play invert_chord(chord_degree(2, :c, :major, num_of_notes), 1), release: 1.5
    sleep 2
    play invert_chord(chord_degree(5, :c, :major, num_of_notes), 0), release: 1.5
    sleep 2
    play invert_chord(chord_degree(1, :c, :major, num_of_notes), 1), release: 1.5
    sleep 4

    # Once more with arpeggiated notes:
    play_pattern_timed invert_chord(chord_degree(6, :c, :major, num_of_notes), 0), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(3, :c, :major, num_of_notes), 1), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(2, :c, :major, num_of_notes), 1), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(5, :c, :major, num_of_notes), 0), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(1, :c, :major, num_of_notes), 1), 0.3, release: 1.0
    sleep 2
  end #comment

  # Now we use chords with four notes (fequently used e.g. in Jazz) for the same cadenza
  num_of_notes = 4

  comment do

    play chord_degree(6, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(3, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(2, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(5, :c, :major, num_of_notes), release: 1.5
    sleep 2
    play chord_degree(1, :c, :major, num_of_notes), release: 1.5
    sleep 4

    # Once more with arpeggiated notes:
    play_pattern_timed chord_degree(6, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 2
    play_pattern_timed chord_degree(3, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 2
    play_pattern_timed chord_degree(2, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 2
    play_pattern_timed chord_degree(5, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 2
    play_pattern_timed chord_degree(1, :c, :major, num_of_notes), 0.3, release: 1.0
    sleep 2

  end #comment

  comment do

    play invert_chord(chord_degree(6, :c3, :major, num_of_notes), 3), release: 1.5
    sleep 2
    play invert_chord(chord_degree(3, :c, :major, num_of_notes), 1), release: 1.5
    sleep 2
    play invert_chord(chord_degree(2, :c, :major, num_of_notes), 1), release: 1.5
    sleep 2
    play invert_chord(chord_degree(5, :c3, :major, num_of_notes), 3), release: 1.5
    sleep 2
    play invert_chord(chord_degree(1, :c, :major, num_of_notes), 1), release: 1.5
    sleep 4

    # Once more with arpeggiated notes:
    play_pattern_timed invert_chord(chord_degree(6, :c3, :major, num_of_notes), 3), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(3, :c, :major, num_of_notes), 1), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(2, :c, :major, num_of_notes), 1), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(5, :c3, :major, num_of_notes), 3), 0.3, release: 1.0
    sleep 2
    play_pattern_timed invert_chord(chord_degree(1, :c, :major, num_of_notes), 1), 0.3, release: 1.0
    sleep 2

  end #comment

end #with_bpm


# TODO
# Intervalle und Stufen
#   Alle Intervalle vom Grundton aus
#   Ein bischen mit Quinten spielen?
#   Akkorde mit unterschiedlichen Ergänzungen
#   7, #11, 9, sus4, 7/#9
# Harmonisierung (Amerkica: Melodie, Akkorde drunter, andere Akkorde)

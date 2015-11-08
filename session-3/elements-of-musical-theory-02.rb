# coding: utf-8
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 3. Termin
# Elements of Musical Theory - Part II

use_bpm 120

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

    play chord(:C, '1'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '+5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm+5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :sus2), sustain: 2, release: 1
    sleep 3
    play chord(:C, :sus4), sustain: 2, release: 1
    sleep 3
    play chord(:C, '6'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :m6), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7sus2'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7sus4'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7-5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm7-5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7+5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm7+5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :m9), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm7+9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :maj9), sustain: 2, release: 1
    sleep 3
    play chord(:C, '9sus4'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '6*9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm6*9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7-9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm7-9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7-10'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '9+5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm9+5'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7+5-9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm7+5-9'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '11'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :m11), sustain: 2, release: 1
    sleep 3
    play chord(:C, :maj11), sustain: 2, release: 1
    sleep 3
    play chord(:C, '11+'), sustain: 2, release: 1
    sleep 3
    play chord(:C, 'm11+'), sustain: 2, release: 1
    sleep 3
    play chord(:C, '13'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :m13), sustain: 2, release: 1
    sleep 3
    play chord(:C, :major), sustain: 2, release: 1
    sleep 3
    play chord(:C, :M), sustain: 2, release: 1
    sleep 3
    play chord(:C, :minor), sustain: 2, release: 1
    sleep 3
    play chord(:C, :m), sustain: 2, release: 1
    sleep 3
    play chord(:C, :major7), sustain: 2, release: 1
    sleep 3
    play chord(:C, :dom7), sustain: 2, release: 1
    sleep 3
    play chord(:C, '7'), sustain: 2, release: 1
    sleep 3
    play chord(:C, :M7), sustain: 2, release: 1
    sleep 3
    play chord(:C, :minor7), sustain: 2, release: 1
    sleep 3
    play chord(:C, :m7), sustain: 2, release: 1
    sleep 3
    play chord(:C, :augmented), sustain: 2, release: 1
    sleep 3
    play chord(:C, :a), sustain: 2, release: 1
    sleep 3
    play chord(:C, :diminished), sustain: 2, release: 1
    sleep 3
    play chord(:C, :dim), sustain: 2, release: 1
    sleep 3
    play chord(:C, :i), sustain: 2, release: 1
    sleep 3
    play chord(:C, :diminished7), sustain: 2, release: 1
    sleep 3
    play chord(:C, :dim7), sustain: 2, release: 1
    sleep 3
    play chord(:C, :i7), sustain: 2, release: 1
    sleep 3

  
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

# coding: utf-8
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 2. Termin

############################################################
# First Steps
############################################################

# What you can do if you don't know where to start
############################################################

# 1. Work with the following expressions and create something:

comment do

  play 60
  sleep 1

  in_thread
  # some code here ...
end

comment do
#use_synth :sine
#use_synth_defaults, amp: 1 # more parameters

end

# 2. Work with the inbuild examples and the documentation of Sonic Pi
#
# Please follow this rule: Do not copy and paste. Type everything.

# 3. Play with the inbuild Sample Collection

# use:

comment do

  sample [sample_name]

  # and the different parameter such as
  # rate, start, finish, beat_stretch, pitch_stretch.
  # Refer to the documentation to see how these work.

  # Combine samples, play them together or in succession and
  # experiment with the timing.
  
end

# 4. Start trying to realise an idea of you own.
#
# Break the idea up into simple and small steps
# Try to make these happen.
# Leave aside for now any steps which seem to difficult at the moment.
# Ask and/or try to find a solution in the examples or the documentation.

# Finding Help
############################################################

# If you find an expression you don't know, look it up in the manual.
# Open the help files with Alt-i (or click on 'Help')
# For easy access position the cursor on the expressen and type Ctrl-i.

# Comment/uncomment
############################################################

# You can 'comment' code which you don't need right now but you do not
# want to delete with

comment do
  # code will not run
end

# You can 'uncomment' with 'uncomment' (meaning: if you press 'run' code
# will 'run' or in other words 'will be evaluated by Sonic Pi'). 

comment do
  # code will run
end

# Play and Sleep
############################################################

# You play a note and sleep a duration.
# You can call a note by different names
# e.g.
# midi numbers
# See: https://upload.wikimedia.org/wikipedia/commons/2/27/NoteNamesFrequenciesAndMidiNumbers_v2.svg
# international names such as c4 => :c4
# or tonal degrees such as C major,
# meaning e.g. the 1st, 2nd, 3rd a.s.o note of C major =>
# degree(:i, :c4, :major) or
# degree(1, :c4, :major)

# and set a duration in different ways:
# 1 (1 second or beat), 1.0/4

comment do
  play :g4
  sleep 0.25
  play 67                     # = g4
  sleep 0.25
  play degree(5, :c4, :major) # = g4
  sleep 0.25
  play :c5
  sleep 0.25
  play :c5
  sleep 0.25
  play :c5
  sleep 0.25
  play :a4
  sleep 0.25 * 2              # = 0.5
  play :f4
  sleep 1.0 / 2               # = 0.5
  play :c4
  sleep 4.0 / 8               # = 0.5
end

# There are some reasons to calculate the duration rather than
# hard wiring it. A rather obvious one:

comment do

  4.times do
    sample :loop_amen, rate: 2
    sleep sample_duration(:loop_amen, rate: 2)
    # sleep 1
  end
end

# Augmented and diminished notes:
# :cs4 = C s(harp), 4th octave or "ein gestrichenes Cis"
# :db4 = C b (flat), 4th octave or "ein gestrichenes Des"

# Other Play Functions
############################################################

# Give a list of notes, use the beats-per-minute currently set
comment do

  with_bpm 120 do
    play_pattern [:g4,:g4,:g4,:c5,:c5,:c5,:a4,:f4,:c4]
  end

end

# More conveniently in this case with timings
comment do
  
  with_bpm 60 do # reset the previous timing
    play_pattern_timed [:g4,:g4,:g4,:c5,:c5,:c5,:a4,:f4,:c4],
                       [0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5]
  end

end

# You can set more parameters for play, play_pattern, play_pattern_timed
comment do

  play_pattern_timed [:g4,:g4,:g4,:c5,:c5,:c5,:a4,:f4,:c4],
                     [0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5],
                     amp: 2, attack: 0.1, sustain: 0, release: 0.1

end

# You can structure your code and avoid repeating commands
comment do
  
  3.times do
    play :g4
    sleep 0.25
  end
  3.times do
    play :c5
    sleep 0.25
  end
  play_pattern_timed [:a4,:f4,:c4], 0.5
  
end

# You can use variables to shorten and structure more.
# Beware: In this example the use of variables is slightly exaggerated
# for the purpose of demonstration.
# You don't have to put everything in vars but bear in mind: you can.
comment do

  rest_short = 0.25
  rest_long = rest_short * 2

  n1 = :g4
  n2 = :c5
  n3 = [:a4,:f4,:c4]
  
  3.times do
    play n1
    sleep rest_short
  end
  3.times do
    play n2
    sleep rest_short
  end
  play_pattern_timed n3, rest_long
  
end

# Just a preview: There are loads of functions which make
# repetition, distribution and sequencing easier (and more abstract)
# See e.g. 'knit'
comment do

  the_start = (knit :g4, 3, :c5, 3)
  the_end = [:a4,:f4,:c4]

  play_pattern_timed the_start, 0.25
  play_pattern_timed the_end, 0.5

end


# Playing Chords
############################################################

comment do

  play_chord [:c4,:e4,:g4]
  sleep 0.5
  play chord(:c4, :major)
  sleep 0.5
  play invert_chord(chord(:c4, :major), 1)
  sleep 0.5
  play invert_chord(chord(:c4, :major), 2)
  sleep 0.5
  play invert_chord(chord(:c5, :major), 0)

  # look up all chord names with:
  puts "These are the chords available in Sonic Pi:"
  puts chord_names
  
end

# Playing Things at the Same Time
############################################################

uncomment do
  # Brother, wake up!
  notes = [:c4,:d4,:e4,:c4,
           :c4,:d4,:e4,:c4,
           :e4,:f4,:g4,
           :e4,:f4,:g4,
           :g4,:a4,:g4,:f4,:e4,:c4,
           :g4,:a4,:g4,:f4,:e4,:c4,
           :c4,:g3,:c4,
           :c4,:g3,:c4]
  durations = [1,1,1,1,
               1,1,1,1,
               1,1,2,
               1,1,2,
               0.5,0.5,0.5,0.5,1,1,
               0.5,0.5,0.5,0.5,1,1,
               1,1,2,
               1,1,2]
  with_bpm 160 do
    play_pattern_timed notes, durations
  end

  # Now play the canon
  with_bpm 160 do
    in_thread do
      with_transpose +12 do
        play_pattern_timed notes, durations
      end
    end
    in_thread do
      sleep 8
      play_pattern_timed notes, durations
    end
  end

end #comment




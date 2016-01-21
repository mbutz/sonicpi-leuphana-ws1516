# Examples for use of stretch

# use_bpm 120
use_bpm 90
use_debug true

sample_path = "/home/marty/projects_marty/leuphana-local/sonic-pi/mb/samples/"

load_samples ["#{sample_path}madcrew.wav"]

use_sample_pack_as "#{sample_path}", :my
# sample aufrufen: sample :my__madcrew

# Mixer #################################################################

# master_vol = (ramp *range(0, 1, 0.05))
master_vol = (line 0, 1, inclusive: true, steps: 50).ramp
# we have to 'ramp' the master_vol because it should stay on the last value

# Suspend blending for testing purposes
# master_vol = (ring 1)

# As some loops are are 16 beats long, they will need a faster blend 
# because tick takes some time
master_16 = (line 0, 1, inclusive: true, steps: 6).ramp
#master_16 = (ring 1)

master_drums = (line 0, 1, inclusive: true, steps: 16).ramp
# master_drums = (ring 1)

upstairs_vol =  0.75
bass_vol = 0.5
fat_bass_vol = 4
hat_vol = 1
hat_acc_vol = 1
bbeat_vol = 5
amen_vol = 0.35

carpet_vol = 0.25

# Metronom Loops #########################################################

live_loop :metro do
  sleep 0.25
end

# Set up beat marker for :one_bar
beat_marker = (ring 1, 0.75, 0.75, 0.75)

live_loop :one_bar do

  #stop

  sync :metro
  # sample :elec_pop, amp: beat_marker.tick - 0.5, rate: beat_marker.look
  sleep 1
end

live_loop :four_bars do
  sync :metro
  sleep 16
end

# Hihats #################################################################

live_loop :hat do
  
  #stop  

  sync :metro
  with_fx :slicer, mix: 1, phase: 0.25, pulse_width: 0.1 do
    with_fx :hpf, cutoff: 130 do
      with_synth :noise do
        play :c1, decay: 1, pan: -0.5, amp: hat_vol * master_vol.tick
      end
    end
  end
end

live_loop :hat_acc do
  
  #stop  
  
  sync :metro
  if (spread 3, 8).tick then # makes a pattern like 3-3-2 
    with_synth :pnoise do
      with_fx :rhpf, cutoff: 123, res: 0.75 do
        play :c1, attack: 0.0, decay: 0.02, release: 0.05, pan: 0.5, 
        amp: hat_acc_vol * master_vol.look
      end
    end
  end
end

# Bass #####################################################################

# Big fat bass

fat_bass_line = (ring :a1, :r, :g1, :g1, :c2, :r, :d2, :d2, 
                 :a1, :r, :c2, :r, :a1, :r, :d2, :d2, :r)
fat_bass_durations = (ring 3, 0.75, 0.25, 4, 3, 0.75, 0.25, 2.25, 
                      0.1, 0.15, 0.1, 0.15, 0.1, 0.15, 0.3, 0.1, 0.35)

fat_bass_bpf_val = (ring 50, 75, 110) # filter makes bass change sound any four bars 
fat_bass_bpf_vol = (ring  0.75, 1.5, 6) # correct the volume according to filter setting

live_loop :fat_bass do

  stop
  sync :four_bars

  use_synth :fm
  use_synth_defaults divisor: 1, depth: 2, attack: 0, sustain: 0, release: 0.5, cutoff: 120, 
  amp: fat_bass_vol * master_16.tick * fat_bass_bpf_vol.look
  with_fx :bpf, centre: fat_bass_bpf_val.look do
    play_pattern_timed fat_bass_line, fat_bass_durations
  end

end

# Bass Clarinet

bass_line = (scale :d1, :minor_pentatonic).shuffle +
  (scale :d1, :minor_pentatonic).shuffle + 
  (scale :a1, :minor_pentatonic).shuffle + 
  (scale :g1, :minor_pentatonic).shuffle

#use_random_seed 0.75

bass_rhythm_bar = (ring 1, 1, 0.5, 0.5, 0.75, 0.25) # makes 4 quarters or one bar on the whole
bass_rhythm = (bass_rhythm_bar * 4).shuffle # 4 bars randomly arranged
bass_sound = (line 0, 12, steps: 6) # (ring 0.0, 2.0, 4.0, 6.0, 8.0, 10.0) for fm depth:
# Modifies the depth of the carrier wave used to modify fundamental frequency. 

live_loop :bass do
  
  stop

  sync :metro
  # gets a signal from :metro every 0.25 beats, then starts to run
  # if :metro goes slower, :bass will also
  # additionally sleep command also shapes the timing:
  # remove sleep and :bass will exactly reproduce timing of :metro
  # if current sleep value is shorter than :metro signal it will have no effect
  # as :bass is first waiting for :metro signal; if sleep value is longer :bass 
  # waits according to the sleep command and thus shapes the regular bassline rhythm
  # according to values in bass_rhythm

  use_synth :fm
  use_synth_defaults divisor: 0.5, depth: bass_sound.look, attack: 0.05, sustain: 0, release: 0.2, 
  amp: bass_vol * master_vol.tick
  # use_synth_defaults divisor: 0.5, amp: 0.75 + bass_vol * master_vol.tick
  with_fx :gverb, room: 150, spread: 1, mix: 0.5 do
    # gverb: Similar to reverb but with a more spacious feel
    # room: size of the room
    # spread: Amount of stereo spread the reverb has over the left and right channels.
    play bass_line.look # look makes notes play in a row
  end

  sleep bass_rhythm.look # remove seep to get an rhythmically even shaped bassline
  # you might also want to adjust the bass release (see above) with release: bass_rhythm.look

  comment do
    use_synth :beep
    use_synth_defaults amp: 3
    play bass2_line.look
    sleep bass2_rhythm.look
  end  

end

# Drum Samples ##########################################################

# Here comes a sample downloaded from freesound.org

# fx slicer: Modulates the amplitude of the input signal with a specific control wave and phase duration

bbeat_slicer_phase = (ring 0.25, 0.25, 0.25, 2)
# slicer phase: duration in beats of the slices; effect
# effect: with slicer you can create half time rhythms or a simulated break

bbeat_slicer_pulse = (knit 0.25, 2, 0.75, 2) # creates a ring: 2 * 0.25 + 2 * 0.5
# slicer pulse: The width of the pulse wave as a value between 0 and 1. Different values will 
# change the timbre of the sound
# effect: low values like 0.1 thins out the sound like someone was clapping on his knees

live_loop :bbeat do

  stop

  sync :four_bars
  with_fx :reverb, mix: 0.25, room: 0.4 do
    2.times do
      with_fx :slicer, phase: bbeat_slicer_phase.tick, pulse_width: bbeat_slicer_pulse.look do
        sample :my__madcrew, pitch_stretch: 8, window_size: 0.5, pitch_dis: 0.001, time_dis: 0.001, 
        amp: bbeat_vol * master_drums.look
        sleep sample_duration(:my__madcrew, pitch_stretch: 8)
      end
    end
  end
end

# And this is the old fashioned amen break

amen_beat_stretch = (ring 4, 4, 4, 2, 2)

live_loop :amen do
  
  stop
  sync :four_bars

  with_fx :reverb, room: 1, mix: 0.3 do
    #with_fx :krush, gain: 0 do
      # Krush: makes it noisy
      5.times do
        sample :loop_amen, beat_stretch: amen_beat_stretch.tick, amp: amen_vol * master_drums.look
        # Calling tick an amen_beat_stretch because look is 0 in t0,25, he beginning and at the first look
        # Thus the beat_stretch in the first run does not represent the values in the ring:
        # SP counts first value 4 two times 
        sleep sample_duration(:loop_amen, beat_stretch: amen_beat_stretch.look)
      end
    #end
  end
end


# Synth Playing Chords ##########################################################

#carpet_repeat = (knit 1, 4, 2, 1) # how often to play the sequence 
carpet_repeat = (ring 1, 1, 1, 2)

#carpet_pause = (knit 4, 4, 2, 1) # how long to wait after each chord
carpet_pause = (ring 4, 4, 4, 2)

# carpet_attack = (knit 0.05, 4, 0.5, 1) # attack of the sound
carpet_attack = (ring 0.25, 0.25, 0.25, 1)

#carpet_release = (knit 6, 4, 0.75, 1) # release of the sound
carpet_release = (ring 6, 6, 6, 0.25)

live_loop :carpet do

  stop
  
  sync :four_bars

  use_synth :fm
  use_synth_defaults divisor: 0.05, depth: 20, attack: 0, sustain: 0, release: 1, amp: carpet_vol * master_16.tick

  # Set the values here, so that SP does only one lookup
  repeat = carpet_repeat.look
  pause = carpet_pause.look
  a = carpet_attack.look
  r = carpet_release.look

  repeat.times do
    with_fx :gverb, room: 150 do
      #with_fx :echo, phase: 4, decay: 10, mix: 0.5 do
        play play_pattern_timed invert_chord(chord(:a, :minor), 0), 0, attack: a, release: r
        sleep pause
        play play_pattern_timed invert_chord(chord(:c5, :major), 0), 0, attack: a, release: r
        sleep pause
        play play_pattern_timed invert_chord(chord(:g, :major), 0), 0, attack: a, release: r
        sleep pause
        play play_pattern_timed invert_chord(chord(:d, :minor), 0), 0, attack: a, release: r
        sleep pause
      #end
    end
  end

end #:carpet

# Synth going up ##############################################################

# notes = (ring :d3, :e3, :g3, :a3, :b3, :e4, :g4, :a4, :b4, :d4, :d5, :e5)
notes = (ring :g2, :a2, :d3, :e3, :g3, :a3, :d4, :e4, :a4, :g4)
# notes = (chord :a, '7sus4')
echo_mix_val = (ring 0, 0.4, 0.8, 1)
reverb_mix_val = (ring 0, 0.1, 0.2, 0.3, 0.4)
delay_val = (ring 0, 2, 4, 8, 16)
transpose_val = (stretch [0, 12], 12)

live_loop :upstairs do
  
  stop
  
  sync :metro
  use_synth :fm
  use_synth_defaults depth: 1, divisor: 0.125, attack: 0, release: 0.2, amp: master_vol.look * upstairs_vol
  with_transpose transpose_val.look do
    with_fx :reverb, room: 1, mix: reverb_mix_val.look do  
      with_fx :echo, phase: 0.75, delay: delay_val.look, mix: echo_mix_val.look do
        play notes.tick
      end
    end
  end
  sleep [0.5, 0.5, 2, 1, 0.5, 0.5, 0.5].choose
  #sleep 0.5
  #sleep 1

end #upstairs

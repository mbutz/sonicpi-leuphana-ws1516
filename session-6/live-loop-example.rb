# Example for Live Loops

use_debug false
use_bpm 140
set_sched_ahead_time! 0

ratio = 1

bass_1     = [:a1, :r, :g1,
              :g1,
              :c2, :r, :d2,
              :d2]
bass_dur_1 = [3, 0.75, 0.25,
              4,
              3, 0.75, 0.25,
              4]

bass_2     = [:a1, :a2, :e2, :g2, :d2,
              :g1, :g1, :r, :g2, :a2, :d2,
              :c2, :b1, :c2, :c2, :b1, :a1, :g1,
              :f1, :d1, :f1, :r, :d2, :d1, :d1]

bass_dur_2 = [0.5, 2, 0.5, 0.5, 0.5,
              0.5, 0.5, 0.5, 1.5, 0.5, 0.5,
              0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5,
              0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5]

# This function plays note lengths and rests according to the given value
define :play_synth do |notes,durations|
  notes.zip(durations).each do |n,d|
    if n != :r
      play n, release: d * ratio
    end
    sleep d
  end
end


# Metronom Sound

define :one do
  in_thread do
    sample :elec_pop, amp: 1, rate: 1
    sleep 4
  end
end

# Loops for timing

live_loop :bar1 do
  sample :elec_pop, amp: 1, rate: 1
  sleep 4
end

# This is for synchronizing every 2 bars
live_loop :bar2 do
  sync :bar1
  sleep 8
end

# This is for synchronizing every 4 bars
live_loop :bar4 do
  sync :bar2
  sleep 16
end

# Making Music

# Bass Phrases
use_synth :fm
use_synth_defaults divisor: 1, depth: 2, attack: 0, sustain: 0, release: 1, amp: 2

b1 = 0

live_loop :bass1 do
  stop if b1 == 0
  ratio = 1.3
  sync :bar4
  with_fx :bpf, centre: 30, res: 0.25 do
    play_synth bass_1, bass_dur_1
  end
end

live_loop :bass2 do
  #stop
  ratio = 1.8
  sync :bar4
  with_fx :bpf, centre: 30, res: 0.25 do
    play_synth bass_2, bass_dur_2
  end
end

# Drums

live_loop :amen do
  # stop
  sync :bar2
  tempo = dice(3)
  with_fx :reverb, room: 1, mix: 0.25 do
    if tempo == 1
      sample :loop_amen, beat_stretch: 8, amp: 0.25
      sleep sample_duration(:loop_amen, beat_stretch: 8)
    elsif
      2.times do
        sample :loop_amen, beat_stretch: 4, amp: 0.25
        sleep sample_duration(:loop_amen, beat_stretch: 4)
      end
    end
  end
end

live_loop :breakbeat do
  #stop
  sync :bar4
  2.times do
    sample :loop_breakbeat, beat_stretch: 8, amp: 2
    sleep sample_duration(:loop_breakbeat, beat_stretch: 8)
  end
end

# Keyboard

live_loop :bush do
  #stop
  sync :bar2
  use_synth :beep
  use_synth_defaults amp: 0.5

  # "repeat"
  # how many times is the chord sequence repeated;
  # higher values make especially sense if the chords have short attack and release
  repeat = 4

  # "pause"
  # pause after any chord; try 0.5, 1, 1.75, 2, 4 or any other value;
  # 4 syncs with the bass => one chord per bar;
  # or take a random value: choose([0.5,1,2,4])
  pause = 1.75

  # attack time
  a = 0.1

  # release time
  # long release (and attack) times together wich high decay values in the echo
  # create continious and overlapping sounds
  # short attack and release times and sort values for "pause" produce a percussive pattern
  r = 1
  
  repeat.times do
    with_fx :reverb, room: 1 do
      with_fx :echo, phase: 4, decay: 10, mix: 0.5 do
        play play_pattern_timed invert_chord(chord(:a, :minor), 0), 0, attack: a, release: r, amp: 0.5
        sleep pause
        play play_pattern_timed invert_chord(chord(:c5, :major), 0), 0, attack: a, release: r
        sleep pause
        play play_pattern_timed invert_chord(chord(:g, :major), 0), 0, attack: a, release: r, amp: 0.5
        sleep pause
        play play_pattern_timed invert_chord(chord(:d, :minor), 0), 0, attack: a, release: r
        sleep pause
      end
    end
  end
end











































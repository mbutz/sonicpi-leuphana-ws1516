# https://gist.github.com/darinwilson/a3e5909db339838a67fe
#########################################
## Sonic Pi Drum Machine
## coded by Darin Wilson
##

use_bpm 95
set_sched_ahead_time! 1

in_thread(name: :drum_machine) do

  # choose your kit here (can be :acoustic, :acoustic_soft, :electro, :toy)
  use_kit :acoustic

  # program your pattern here - each item in the list represents 1/4 of a beat
  # for each item, enter a number between 0 and 9 (0=silent,9=loudest)
  hat   [5, 0, 5, 0,  5, 0, 5, 0,  5, 0, 5, 0,  5, 0, 5, 0]
  kick  [9, 0, 9, 0,  0, 0, 0, 0,  9, 0, 0, 3,  0, 0, 0, 0]
  snare [0, 0, 0, 0,  9, 0, 0, 2,  0, 1, 0, 0,  9, 0, 0, 1]

end



##################################################################
##
## The gory details - you don't need to change anything down here,
## unless you're curious :)
##

drum_kits = {
  acoustic: {
    hat:   :drum_cymbal_closed,
    kick:  :drum_bass_hard,
    snare: :drum_snare_hard
  },
  acoustic_soft: {
    hat:   :drum_cymbal_closed,
    kick:  :drum_bass_soft,
    snare: :drum_snare_soft
  },
  electro: {
    hat:   :elec_triangle,
    kick:  :elec_soft_kick,
    snare: :elec_hi_snare
  },
  toy: {
    hat:   :elec_tick,
    kick:  :elec_hollow_kick,
    snare: :elec_pop
  }
}
current_drum_kit = drum_kits[:acoustic]


define :use_kit do |kit_name|
  current_drum_kit = drum_kits[kit_name]
end

live_loop :pulse do
  sleep 4
end

define :run_pattern do |name, pattern|
  live_loop name do
    sync :pulse
    pattern.each do |p|
      sample current_drum_kit[name], amp: p/9.0
      sleep 0.25
    end
  end
end

define :hat do |pattern|
  run_pattern :hat, pattern
end

define :kick do |pattern|
  run_pattern :kick, pattern
end

define :snare do |pattern|
  run_pattern :snare, pattern
end

# AFX 1.9
# Due to a size restriction in Sonic Pi, there are 3 numbered files:
# afx-1-9-b1.rb -> first buffer
# afx-1-9-b2.rb -> second buffer
# afx-1-9-b3.rb -> third buffer
# Evaluate them in this order.
#
# 1st buffer: set up some helper functions and define rhythmic/melodic patterns

use_debug false
use_bpm 128

# Helper Functions

# Return note duration based on the defined rythmic pattern
define :get_dur do |ptn|
  if ptn.count == 1
    d = 4
  elsif ptn.count == 2
    d = 2
  elsif ptn.count == 4
    d = 1
  elsif ptn.count == 8
    d = 0.5
  elsif ptn.count == 16
    d = 0.25
  elsif ptn.count == 32
    d = 0.125
  else
    puts "NOTE: No idea what rythmic pattern you mean!"
  end
  return d
end

define :play_sample do |spec, ptn|
  # take orders, what and how to play

  # work out time measure
  d = get_dur ptn

  ptn.each do |i|
    if i != 0
      sample spec[0], amp: spec[1], rate: spec[2], pan: spec[3], start: spec[4], finish: spec[5]
    end
    sleep d
  end
end

# example param: [:-,:-,:-,:-,[:to,1,0.5,0.5,:g5,:fs5],:-,[:to,1,1,1,:f5,:e5],:-]
# n[0], keyword for slide
# n[1], slide time
# n[2], sustain
# n[3], release
# n[4], base note
# n[5], note to slide to
define :play_synth do |notes|
  t = get_dur notes
  notes.each do |n|
    if n[0] == :to
      control (play n[4], note_slide: n[1], sustain: n[2], release: n[3]), amp: 3, note: n[5]
    elsif n != :-
        play n
    end
    sleep t
  end
end

uncomment do
  # TEST the sliding melody code
  pattern = [[:to,3,2,2,:g4,:c5]]
  use_synth :fm
  use_synth_defaults amp: 1, attack: 0.3, sustain: 0.2, release: 0.2, pan: 0, divisor: 20, depth: 0.0
  in_thread do
    with_fx :reverb, room: 0.9 do
      play_synth pattern
    end
  end
end

# rhythmic patterns (ptn)
#                   1 e + e 2 e + e 3 e + e 4 e + e

define :get_cbsa_on_ptn_a do
  cbsa_on_ptn_a    = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]
end
define :get_cbsa_of_ptn_a do
  cbsa_of_ptn_a    = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
end
define :get_cbsa_on_ptn_b do
  cbsa_on_ptn_b    = [1,0,1,1,0,0,1,0,1,0,0,1,1,0,1,0]
end
define :get_cbsa_of_ptn_b do
  cbsa_of_ptn_b    = [0,1,0,0,1,1,0,1,0,1,1,0,0,1,0,1]
end

define :get_bass_on_ptn_1 do
  bass_on_ptn_1    = [1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0]
end
define :get_bass_of_ptn_1 do
  bass_of_ptn_1    = [0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0]
end
define :get_snre_on_ptn_1 do
  snre_on_ptn_1    = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]
end
define :get_snre_of_ptn_1 do
  snre_of_ptn_1    = [0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0]
end

define :get_bass_ptn_2a do
  bass_ptn_2a      = [1,0,1,0,1,0,0,0,0,0,1,0,0,0,0,0]
end
define :get_bass_ptn_2b do
  bass_ptn_2b      = [1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0]
end
define :get_snre_ptn_2 do
  snre_ptn_2       = [0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0]
end

define :get_hiht_on_ptn do
  hiht_on_ptn      = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]
end
define :get_hiht_of_ptn do
  hiht_of_ptn      = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
end
define :get_hiht_lo_ptn do
  hiht_lo_ptn      = [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
end
define :get_hiht_hi_ptn do
  hiht_hi_ptn      = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
end

define :get_snre_hr_ptn_a do
  snre_hr_ptn_a    = [0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0]
end
define :get_snre_hr_ptn_b do
  snre_hr_ptn_b    = [0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0]
end

define :get_cong_low_ptn do
  cong_low_ptn     = [1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0]
end
define :get_cong_mdm_ptn do
  cong_mdm_ptn     = [0,0,0,0,0,0,1,0,0,1,0,1,0,0,1,0]
end
define :get_cong_hih_ptn do
  cong_hih_ptn     = [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0]
end

# lines for synths
define :get_bodn_fg_ptn do
  bodn_fg_ptn  = [[:e4,:a3],:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-]
end
define :get_bodn_bg_ptn do
  bodn_bg_ptn  = [[:e3,:a2],:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-]
end
define :get_bodn_pk_ptn do
  bodn_pk_ptn  = [[:e5,:a4],:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-]
end

define :get_frog_ptn do
  frog_ptn      = [:-,:-,:-,:-,:-,:g1,:-,:-,:-,:-,:-,:-,:-,:-,:-,:-]
end

define :get_bnce_ptn_b1 do
  bnce_ptn_b1   = [[:e3,:a4],[:e3,:a4],:-,:-,
                   :-,:-,[:e3,:a4],:-,
                   :-,[:e3,:a4],:-,:-,
                   [:e3,:a4],:-,[:e3,:a4],:-]
end
define :get_bnce_ptn_b2 do
  bnce_ptn_b2   = [[:a4,:d5],[:a4,:d5],:-,:-,
                   :-,:-,[:a4,:d5],:-,
                   :-,[:a4,:d5],:-,:-,
                   [:a4,:d5],:-,[:a4,:d5],:-]
end
define :get_bnce_ptn_b3 do
  bnce_ptn_b3   = [[:g4,:b4],[:g4,:b4],:-,:-,
                   :-,:-,[:g4,:b4],:-,
                   :-,[:g4,:b4],:-,:-,
                   [:g4,:b4],:-,[:g4,:b4],:-]
end
define :get_bnce_ptn_b4 do
  bnce_ptn_b4   = [[:d4,:fs4],:-,[:d4,:fs4],:-,
                   :-,:-,:-,[:d4,:fs4],
                   :-,:-,[:d4,:fs4],:-,
                   :-,[:d4,:fs4],:-,[:d4,:fs4]]
end

define :get_flute_ptn_a do
  flute_ptn_a   = [:-,:-,:-,:-,[:to,1,0.5,0.5,:g5,:fs5],:-,[:to,1,1,1,:f5,:e5],:-]
end
define :get_flute_ptn_b do
  flute_ptn_b   = [:-,:-,:-,:-,[:to,1,0.5,0.5,:g4,:fs4],:-,:-,:-]
end
define :get_flute_ptn_v do
  flute_ptn_v   = [[:-,[:to,1,0.5,0.5,:g5,:fs5],:-,:-,:-,:-,:-,:-],
                   [:-,:-,:-,[:to,1,0.5,0.5,:b4,:a4],:-,:-,:-,:-],
                   [:-,[:to,1,0.5,0.5,:e5,:fs5],:-,:-,[:to,1,0.5,0.5,:a5,:b5],:-,:-,:-],
                   [:-,:-,:-,:-,:-,:-,:-,[:to,1,0.5,0.5,:g4,:e4]],
                   [:-,:-,:-,:-,[:to,1,0.5,0.5,:g5,:fs5],:-,[:to,1,1,1,:f5,:e5],:-],
                   [:-,:-,:-,:-,[:to,1,0.5,0.5,:g4,:fs4],:-,:-,:-]]
end

define :get_tune_ptn_b1 do
  tune_ptn_b1   = [:a5,:-,:-,:-,
                   :b5,:-,:d6,:-,
                   :e6,:-,:-,:-,
                   :-,:-,:a5,:-]
end
define :get_tune_ptn_b2 do
  tune_ptn_b2    = [:b5,:a5,:-,:-,
                    :b5,:-,:d6,:-,
                    :-,:e6,:-,:-,
                    :a5,:-,:-,:-]
end
define :get_tune_ptn_b3 do
  tune_ptn_b3    = [:g5,:-,:-,:-,
                    :a5,:-,:-,:-,
                    :b5,:-,:-,:-,
                    :-,:-,:-,:-]
end
define :get_tune_ptn_b4 do
  tune_ptn_b4    = [:a5,:-,:g5,:-,
                    :-,:-,:-,:a5,
                    :-,:-,:b5,:-,
                    :a5,:-,:-,:-]
end
























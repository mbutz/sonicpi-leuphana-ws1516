# AFX 1.9
# 3rd buffer: play the tune

set_sched_ahead_time! 4
use_debug  false

path = "/home/marty/projects/leuphana-ws1516/session-4/afx/"
load_samples [:loop_compus, :elec_wood, :drum_bass_hard, :drum_snare_hard, :drum_snare_hard, :drum_cymbal_closed, :elec_snare, :drum_tom_hi_soft, "#{path}tambourine.wav"]
use_sample_pack_as path, :afx

use_bpm 128

puts "01"
mod_shaker
mod_bordun
sleep 16

puts "02"
mod_shaker
mod_bordun
sleep 16

puts "03"
mod_shaker
mod_bordun
mod_frog
sleep 16

puts "04"
mod_shaker
mod_bordun
mod_frog
sleep 16

puts "05"
mod_drums_1
mod_hiht
mod_bordun
mod_frog
sleep 16

puts "06"
mod_drums_1
mod_hiht
mod_bordun
mod_frog
mod_flute
sleep 16

puts "07"
mod_drums_1
mod_hiht
mod_bordun
mod_frog
mod_congas
sleep 16

puts "08"
mod_drums_1
mod_hiht
mod_bordun
mod_frog
mod_flute_rand
sleep 16

puts "09" # frog leaves
mod_drums_1
mod_hiht
mod_bordun
mod_flute_rand
mod_congas
sleep 16

puts "10" # congas leave
mod_drums_1
mod_hiht
mod_bordun
sleep 16

puts "11"
mod_bouncer
mod_bouncer_init
sleep 16

puts "12"
mod_bouncer
mod_drums_1
mod_hiht
mod_flute_rand
sleep 16

puts "13" # bordun in again
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
mod_flute_rand
sleep 16

puts "14"
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
mod_flute_rand
sleep 16

puts "15" # hammer snare in
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
mod_flute_rand
mod_snre_hr
sleep 16

puts "16" # drums out, shaker in
mod_bouncer
mod_shaker
mod_bordun
mod_flute_rand
sleep 16

puts "17" # drums 2 in
mod_bouncer
mod_drums_2
mod_hiht
mod_bordun
mod_snre_hr
sleep 16

puts "18"
mod_bouncer
mod_drums_2
mod_hiht
mod_bordun
mod_snre_hr
sleep 16

puts "19: Missing Break"
mod_drums_2
mod_hiht
mod_snre_hr
mod_frog
sleep 16

puts "Mark the Break"
sleep 2

puts "20"
mod_drums_1
mod_hiht
mod_snre_hr
mod_congas
mod_frog
sleep 16

puts "21: Missing blend: 1.3 to 2.2+"
mod_drums_2
mod_hiht
mod_snre_hr
mod_frog
sleep 16

puts "22"
mod_drums_1
mod_hiht
mod_flute_rand
mod_congas
mod_bordun
mod_frog
sleep 16

puts "24"
mod_bouncer
mod_drums_1
mod_hiht
mod_congas
mod_bordun
sleep 16

puts "25"
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
sleep 16

puts "26"
mod_tune
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
sleep 16

puts "27"
mod_tune
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
mod_snre_hr
sleep 16

puts "28"
mod_tune_octave
mod_bouncer
mod_shaker
mod_bordun
mod_flute
sleep 16

puts "29"
mod_tune_octave
mod_bouncer
mod_shaker
mod_bordun
mod_flute
sleep 16

puts "30"
mod_shaker
mod_bordun
sleep 16

puts "31: Stop and Reverb"
mod_bordun
sleep 16

puts "32"
mod_tune
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
mod_flute
sleep 16

puts "33"
mod_tune_octave
mod_bouncer
mod_drums_1
mod_hiht
mod_bordun
mod_flute
sleep 16

puts "34"
mod_shaker
mod_bordun
sleep 16

puts "35"
mod_bordun
sleep 16






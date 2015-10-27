# Synth: bnoise (brown(ian) noise, falls of in power by 6 dB per octave)
# Defaults: attack: 0; decay: 0; release: 1; attack_level: 1; sustain_level: 1; env_curve: 2, cuttoff: 110, res: 0

use_bpm 180
use_synth :bnoise

# Play example 1 to 5 selectively
ex = 6

pool =  [degree(1, :c5, :mixolydian),
         degree(5, :c4, :mixolydian),
         degree(3, :c4, :mixolydian),
         degree(1, :c4, :mixolydian),
         degree(4, :c4, :mixolydian),
         degree(7, :c4, :mixolydian),
         degree(5, :c4, :mixolydian),
         degree(2, :c5, :mixolydian)]

# Example 1
# Default bnoise
live_loop :bnoise_default do
  if ex != 1
    stop
  end
  play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
end

#
# Percussion
#

# Example 2
# Short attack but high attack_level; sounds like fast steps in the snow
live_loop :bnoise_perc1 do
  if ex != 2
    stop
  end
  use_synth_defaults attack: 0.05, attack_level: 3, sustain: 0, release: 0.0
  play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
end

# Example 3
# like blowing air into a microphone
live_loop :bnoise_perc2 do
  if ex != 3
    stop
  end
  use_synth_defaults attack: 0.3, sustain: 0.0, release: 0.3
  play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
  sleep 1
end

#
# A (not very realistic) seawave
#
live_loop :bnoise_wave do
  if ex != 4
    stop
  end
  use_synth_defaults attack: 4, sustain: 0, release: 9
  play 60
  sleep 20
end

#
# Cutoff And Resonance
#

# Example 5
# Sounds like a starting helicopter
live_loop :bnoise_cut_res1 do
  if ex != 5
    stop
  end
  use_synth_defaults amp: 1, attack: 0.15, attack_level: 1, decay: 0, sustain: 0, sustain_level: 0, release: 0, cutoff: 70, res: 0.5
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
  sleep 1
end

# Example 5
# Very high resonance creates a whistling noise, attack also very short
live_loop :bnoise_cut_res1 do
  if ex != 6
    stop
  end
  use_synth_defaults amp: 1, attack: 0.03, decay: 0, sustain: 0.3, sustain_level: 0, release: 0.5, cutoff: 100, res: 0.99
  play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
  sleep 1
end

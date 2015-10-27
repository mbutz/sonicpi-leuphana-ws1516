# Synth: blade (simple string synth based on filtered saw waves and a variable vibrato)
# Defaults: attack: 0.2; decay: 0; release: 0.85; attack_level: 1; sustain_level: 1; env_curve: 2
# Additional Defaults: vibrato_depth: 0.15, vibrato_onset: 0.1, vibrato_rate: 6

# The default vibrato comes into play when the sound is longer (longer attack, sustain or release)

use_bpm 180
use_synth :blade

# Play example 1 to 5 selectively
ex = 5

pool =  [degree(1, :c5, :mixolydian),
         degree(5, :c4, :mixolydian),
         degree(3, :c4, :mixolydian),
         degree(1, :c4, :mixolydian),
         degree(4, :c4, :mixolydian),
         degree(7, :c4, :mixolydian),
         degree(5, :c4, :mixolydian),
         degree(2, :c5, :mixolydian)]

# Example 1
# Default blade
live_loop :blade_default do
  if ex != 1
    stop
  end
  play pool[0, 4]
  sleep 1
  play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
end

# Example 2
# Manipulating the envelope: sound texture
  use_synth_defaults attack: 0.5, sustain: 1, release: 0.5
  live_loop :blade_env1 do
    if ex != 2
      stop
    end
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
  end

# Example 3
# Manipulating the envelope: decay, attack and sustain-level
# Almost like a violin, sharp fall (decay) from high attack_level to low sustain_level
live_loop :blade_env2 do
  if ex != 3
    stop
  end
  use_synth_defaults attack: 2, attack_level: 2, decay: 0.5, sustain: 0.5, sustain_level: 0.1, release: 0.3
  play_pattern_timed(pool, [4, 4, 4, 4, 4, 4, 4, 4])
  sleep 4
end

#
# Vibrato
#

# Example 4
# Manipulating the vibrato
# Almost like a violin, sharp fall (decay) from high attack_level to low sustain_level
live_loop :blade_vib do
  if ex != 4
    stop
  end
  use_synth_defaults attack: 1, attack_level: 2, decay: 0, sustain: 2, sustain_level: 2, release: 1.5, vibrato_depth: 0.15, vibrato_rate: 6, vibrato_onset: 0, vibrato_delay: 0
  play_pattern_timed(pool, [4, 4, 4, 4, 4, 4, 4, 4])
  sleep 4
end


#
# Cutoff
#

# Example 5
# Manipulating the cutoff
#
live_loop :blade_vib do
  if ex != 5
    stop
  end
  use_synth_defaults amp: 5, attack: 0.2, attack_level: 1, decay: 0, sustain: 0, sustain_level: 1, release: 0.85, cutoff: 60
  with_transpose -24 do
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1, 4])
  end
  sleep 1
end

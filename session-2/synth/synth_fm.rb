# coding: utf-8
# Synth: A sine wave with a fundamental frequency which is modulated at audio rate by
# another sine wave with a specific modulation, division and depth.
# Defaults: attack: 0; decay: 0; release: 1.0; attack_level: 1; sustain_level: 1; env_curve: 2;
# Additional Defaults: cutoff: 100; divisor: 2; depth: 1
# More Explanation from:
# www.indiana.edu/~emusic/fm/fm.htm
# below audio-rate = approximately 20 Hz = sub-audio rate = vibrato (change in pitch vs. tremolo, change in volume)
# audio rate = > 20 Hz
# "When the rate of the modulating oscillator is tuned above 20 Hz, or at
# an audio rate, very interesting things happen to the sound. Additional
# frequencies called sidebands appear symmetrically around the carrier
# frequency. Those above the carrier frequency are called upper sidebands
# and below, lower sidebands. In essence, as will be seen below, some of
# the energy of the carrier frequency is being stolen to create these
# additional frequencies.
# Yamaha DX7 (1983)

use_bpm 180
use_synth :fm

pool =  [degree(1, :c5, :mixolydian),
         degree(5, :c4, :mixolydian),
         degree(3, :c4, :mixolydian),
         degree(1, :c4, :mixolydian),
         degree(4, :c4, :mixolydian),
         degree(7, :c4, :mixolydian),
         degree(5, :c4, :mixolydian)]

# Play example 1 to 5 selectively
# 1  = default
# 2  = Glas, Glocke
# 3  = Fender Rhodes
# 31 = mit Reverb
# 4  = Rhodes mit Attack, Glasharfe
# 5  = Holzartiger, Xylophon
# 6  = leicht Clavinett-artig
# 7  = mit langem Attack, Akkordeon-artig
# 8  = Metallic bass, transpose necessary
# 9  = ohne Depth = Beep, Depth > 0 z.B. 5 - 20 metallischer, danach noisy 
# Divisor > 1
# 10 = Sehr noisy
# 11 = Leichter Wahwah-Effekt, je größer Depth, desto quäkiger, heller
# 12 = # Interessant, hier mit Depth zwischen 0.1 bis ca. 4.0 zu spielen
# 13 = Divisor: 2 = 1 Oktave tiefer (als 1), 3 = Quart + Oktave tiefer, 4 = 2 Okaven
#      tiefer, 5 = gr. Terz + Oktave tiefer
#      use_transpose => interessante Sounds ohne wg. Divisior verursachte Transposition
# 14 = Spaciger Sound (strukturierter Lärm)
# 15 = Rhythmus mit Störgeräuschen
# 16 = Interessante Effekt mit hohem Divisor (z.B. 40) und geringem Depth-Wert (0.2)
# 17 = Pfeifende Glissandi (mit ein bisschen Attack)
# 18 = Pfeifende Glissandi, tief
# 19 = Urwald
ex = 19


# Example 1
# Default fm
live_loop :fm_default do
  if ex != 1
    stop
  end
  play pool[0, 4]
  sleep 1
  play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 4])
end

####################################################
# Divisor >= 1
# If depth = 0 no modulation
####################################################

# The more you raise the depth
# divisor
# 0.1 => bell like, metallic, the more you raise depth (1 ... 10 ... 50) the thinner and bell/glass-like
# the sound gets; with depth ~90 interesting side bands, like from a Xylophon

# Example 2
#
live_loop :fm_glass do
  if ex != 2
    stop
  end
  use_synth_defaults divisor: 0.1, depth: 20, attack: 0, sustain: 0, release: 0.5
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 3
#
live_loop :fm_rhodes do
  if ex != 3
    stop
  end
  use_synth_defaults divisor: 0.05, depth: 20, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 31
#
live_loop :fm_rhodes_fx do
  if ex != 31
    stop
  end
  use_synth_defaults amp: 4, divisor: 0.05, depth: 20, attack: 0, sustain: 0, release: 1
  with_fx :reverb, room: 0.4 do
    with_fx :flanger, depth: 7 do
      play pool[0, 4]
      sleep 2
      play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
    end
  end
end

# Example 4
#
live_loop :fm_rhodes_with_attack do
  if ex != 4
    stop
  end
  use_synth_defaults divisor: 0.05, depth: 17, attack: 0.3, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 5
#
live_loop :fm_xylo do
  if ex != 5
    stop
  end
  use_synth_defaults divisor: 0.05 , depth: 80, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 6
#
live_loop :fm_clavi do
  if ex != 6
    stop
  end
  use_synth_defaults divisor: 0.33 , depth: 20, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Divisor ruhig mit Nachkommazahlen ausprobieren: damit kann man die auftretenden
# Verstimmungen korrigieren

# Example 7
# Change divisor with more decimal places to show interesting detuning effects e.g. 0.55
# More depth as 20 shows vibrato effect
live_loop :fm_akk do
  if ex != 7
    stop
  end
  use_synth_defaults divisor: 0.5 , depth: 20, attack: 2, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 8
# Play with depth up to around 10 to lighten the sound up
# transpose is used to work against the detuning (either +7, -5, -17 etc.)
live_loop :fm_metalic_bass do
  if ex != 8
    stop
  end
  use_synth_defaults divisor: 0.6 , depth: 7, attack: 0, sustain: 0, release: 1
  with_transpose -17 do # this
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 9
# Depth = 0 => wie Beep
# Depth >0 z.B. 5 - 10 mehr Metall
live_loop :fm_modulator_one do
  if ex != 9
    stop
  end
  use_synth_defaults divisor: 1.0, depth: 30, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

####################################################
# Divisor < 1
# If depth = 0 no modulation
####################################################

# Example 10
# 
# 
live_loop :fm_very_noisy do
  if ex != 10
    stop
  end
  use_synth_defaults divisor: 1.7, depth: 80, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 11
# Wahwah 
live_loop :fm_whawah do
  if ex != 11
    stop
  end
  use_synth_defaults divisor: 2, depth: 3, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end


# Example 12
# Interessant, hier mit Depth zwischen 0.1 bis ca. 4.0 zu spielen
live_loop :fm_play_with_depth do
  if ex != 12
    stop
  end
  use_synth_defaults divisor: 4, depth: 0.4, attack: 0, sustain: 0, release: 1
  play pool[0, 4]
  sleep 2
  play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
end

# Example 13
# Divisor: 2 = 1 Oktave tiefer (als 1), 3 = Quart + Oktave tiefer, 4 = 2 Okaven
#          tiefer, 5 = gr. Terz + Oktave tiefer
# use_transpose => interessante Sounds ohne die damit einhergehende Transposition 
live_loop :fm_play_with_divisor do
  if ex != 13
    stop
  end
  use_synth_defaults divisor: 8, depth: 0.4, attack: 0, sustain: 0, release: 1
  with_transpose +24 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 14
# Interessante spaciger Sound
live_loop :fm_spacy do
  if ex != 14
    stop
  end
  use_synth_defaults divisor: 16, depth: 4, attack: 0, sustain: 0, release: 1
  with_transpose +0 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 15
# Rhythmus mit Störgeräuschen
live_loop :fm_noisy_rythm do
  if ex != 15
    stop
  end
  use_synth_defaults divisor: 20, depth: 120, attack: 0, sustain: 0, release: 1
  with_transpose +0 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 16
# Interessante Effekt mit hohem Divisor (z.B. 40) und geringem Depth-Wert (0.2)
live_loop :fm_strange_sounds do
  if ex != 16
    stop
  end
  use_synth_defaults divisor: 40, depth: 0.2, attack: 0, sustain: 0, release: 1
  with_transpose +0 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 17
# Pfeifende Glissandi (mit ein bisschen Attack)
live_loop :fm_kontakte do
  if ex != 17
    stop
  end
  use_synth_defaults divisor: 70, depth: 0.5, attack: 0.5, sustain: 0, release: 1
  with_transpose +0 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 18
# 
live_loop :fm_kontakte_tief do
  if ex != 18
    stop
  end
  use_synth_defaults divisor: 70, depth: 0.5, attack: 0.5, sustain: 0, release: 1
  with_transpose -24 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end

# Example 19
# Urwald
live_loop :fm_ do
  if ex != 19
    stop
  end
  use_synth_defaults divisor: 30, depth: 0.5, attack: 1, sustain: 1, release: 1
  with_transpose 0 do
    play pool[0, 4]
    sleep 2
    play_pattern_timed(pool, [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 2])
  end
end


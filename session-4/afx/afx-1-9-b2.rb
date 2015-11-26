# AFX 1.9
# 2nd buffer: define song modules and instruments

use_debug false

path = "/home/marty/projects/leuphana-ws1516/session-4/afx/"
load_samples [:loop_compus, :elec_wood, :drum_bass_hard, :drum_snare_hard, :drum_snare_hard, :drum_cymbal_closed, :elec_snare, :drum_tom_hi_soft, "#{path}tambourine.wav"]
use_sample_pack_as path, :afx



define :mod_shaker do

  in_thread do
    2.times do
      play_sample [:afx__tambourine, 3, 1, 0, 0, 1], get_cbsa_on_ptn_a
      play_sample [:afx__tambourine, 3, 1, 0, 0, 1], get_cbsa_on_ptn_b
    end
  end
  in_thread do
    2.times do
      play_sample [:afx__tambourine, 2, 0.95, 0, 0, 1], get_cbsa_of_ptn_a
      play_sample [:afx__tambourine, 2, 0.95, 0, 0, 1], get_cbsa_of_ptn_b
    end
  end
end

define :mod_bordun do
  in_thread do
    use_synth :tri
    use_synth_defaults amp: 1, cutoff: 0, attack: 0.8, sustain: 3, release: 4, pan: 0.2, depth: 20
    2.times do
      with_fx :panslicer, phase: 1, pulse_width: 0.05, wave: 3 do
        with_fx :flanger, phase: 10, wave: 3 do
          play_synth get_bodn_fg_ptn
        end
      end
      sleep 4
    end
  end
  in_thread do
    use_synth :tri
    use_synth_defaults amp: 0.75, attack: 3, sustain: 2, release: 3, pan: -0.2, depth: 10
    2.times do
      with_fx :panslicer, phase: 1, pulse_width: 0.05, wave: 3 do
        with_fx :flanger, phase: 10, wave: 3 do
          play_synth get_bodn_bg_ptn
        end
      end
      sleep 4
    end
  end
  in_thread do
    use_synth :tri
    use_synth_defaults amp: 0.75, cutoff: 0, attack: 0.3, sustain: 3, release: 5, pan: 0.2, depth: 0
    2.times do
      with_fx :panslicer, phase: 1, pulse_width: 0.05, wave: 3 do
        with_fx :flanger, phase: 10, wave: 3 do
          play_synth get_bodn_pk_ptn
        end
      end
      sleep 4
    end
  end
end

define :mod_frog do
  use_synth :tb303
  use_synth_defaults amp: 6, attack: 0.3, sustain: 0.4, release: 0.2, pan: rrand(-0.4, 0.1), res: 0.1
  in_thread do
    with_fx :wobble do
      with_fx :reverb, room: 0.4 do
        4.times do
          play_synth get_frog_ptn
        end
      end
    end
  end
end

define :mod_drums_1 do
  in_thread do
    4.times do
      play_sample [:drum_bass_hard, 1.0, 0.7, -0.2, 0, 1], get_bass_on_ptn_1
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_bass_hard, 0.75, 0.7, -0.2, 0, 1], get_bass_of_ptn_1
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_snare_hard, 0.75, 1.275, -0.1, 0, 1], get_snre_on_ptn_1
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_snare_hard, 1, 1.3, -0.1, 0, 1], get_snre_of_ptn_1
    end
  end
end

define :mod_drums_2 do
  in_thread do
    play_sample [:drum_bass_hard, 1, 0.7, -0.2, 0, 1], get_bass_ptn_2a
    play_sample [:drum_bass_hard, 1, 0.7, -0.2, 0, 1], get_bass_ptn_2b
    play_sample [:drum_bass_hard, 1, 0.7, -0.2, 0, 1], get_bass_ptn_2a
    play_sample [:drum_bass_hard, 1, 0.7, -0.2, 0, 1], get_bass_ptn_2b
  end
  in_thread do
    play_sample [:drum_snare_hard, 0.75, 1.275, -0.1, 0, 1], get_snre_ptn_2
    play_sample [:drum_snare_hard, 0.75, 1.275, -0.1, 0, 1], get_snre_ptn_2
    play_sample [:drum_snare_hard, 0.75, 1.275, -0.1, 0, 1], get_snre_ptn_2
  end
end

define :mod_hiht do
  in_thread do
    4.times do
      play_sample [:drum_cymbal_closed, 0.75, 1, -0.5, 0, 0.4, 1], get_hiht_on_ptn
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_cymbal_closed, 0.75, 1.3, -0.5, 0, 0.3], get_hiht_of_ptn
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_cymbal_closed, 1, 1, -0.4, 0.0, 0.6], get_hiht_lo_ptn
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_cymbal_closed, 1, 1, -0.4, 0.0, 0.6], get_hiht_hi_ptn
    end
  end
end

define :mod_snre_hr do
  in_thread do
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_a
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_a
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_a
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_a
  end
  in_thread do
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_b
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_b
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_b
    play_sample [:elec_snare, 0.5, 0.5, -0.1, 0, 0.4], get_snre_hr_ptn_b
  end  
end

define :mod_congas do
  in_thread do
    4.times do
      play_sample [:drum_tom_hi_soft, 2, 1.05, -0.8, 0.1, 1], get_cong_low_ptn
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_tom_hi_soft, 3, 1.17, -0.2, 0.1, 1], get_cong_mdm_ptn
    end
  end
  in_thread do
    4.times do
      play_sample [:drum_tom_hi_soft, 3, 1.23, 0.6, 0.1, 1], get_cong_hih_ptn
    end
  end
end

define :mod_flute do
  use_synth :fm
  use_synth_defaults amp: 1, attack: 0.3, sustain: 0.2, release: 0.2, pan: 1, divisor: 20, depth: 0.0
  in_thread do
    with_fx :reverb, room: 0.9 do
      play_synth get_flute_ptn_a
    end
  end
  in_thread do
    sleep 8
    with_fx :reverb, room: 0.9 do
      play_synth get_flute_ptn_b
    end
  end
end

define :mod_flute_rand do
  use_synth :fm
  use_synth_defaults amp: 1, attack: 0.3, sustain: 0.2, release: 0.2, pan: 1, divisor: 20, depth: 0.0
  in_thread do
    with_fx :reverb, room: 0.9 do
      use_random_seed rand_i(23)
      play_synth choose(get_flute_ptn_v)
    end
  end
  in_thread do
    sleep 4
    with_fx :reverb, room: 0.9 do
      use_random_seed rand_i(33)
      play_synth choose(get_flute_ptn_v)
    end
  end
    in_thread do
    sleep 8
    with_fx :reverb, room: 0.9 do
      use_random_seed rand_i(33)
      play_synth choose(get_flute_ptn_v)
    end
    end
      in_thread do
    sleep 12
    with_fx :reverb, room: 0.9 do
      use_random_seed rand_i(71)
      play_synth choose(get_flute_ptn_v)
    end
  end
end

define :mod_bouncer do
  use_synth :fm
  use_synth_defaults amp: 5, attack: 0, sustain: 0.2, release: 0.1, pan: 0.2, depth: 0.5
  in_thread do
    with_fx :reverb, room: 0.9 do
      play_synth get_bnce_ptn_b1
      play_synth get_bnce_ptn_b2
      play_synth get_bnce_ptn_b3
      play_synth get_bnce_ptn_b4
    end
  end
end

define :mod_bouncer_init do
  use_synth :cnoise
  use_synth_defaults amp: 0.3, attack: 0.1, sustain: 0.2, release: 1, pan: 0.2
  in_thread do
    with_fx :reverb, room: 0.9 do
      play_synth get_bnce_ptn_b1
      play_synth get_bnce_ptn_b2
      play_synth get_bnce_ptn_b3
      play_synth get_bnce_ptn_b4
    end
  end
end

define :mod_tune do
  use_synth :mod_fm
  use_synth_defaults amp: 4, attack: 0, sustain: 0.1, release: 0.2, pan: -0.3, mod_phase: 0.25, mod_range: 0.2, divisor: 2, depth: 0.2
  in_thread do
    with_fx :reverb, room: 0.5 do
      play_synth get_tune_ptn_b1
      play_synth get_tune_ptn_b2
      play_synth get_tune_ptn_b3
      play_synth get_tune_ptn_b4
    end
  end
end

define :mod_tune_octave do
  use_synth :mod_fm
  use_synth_defaults amp: 4, attack: 0, sustain: 0.1, release: 0.2, pan: -0.3, mod_phase: 0.25, mod_range: 0.2, divisor: 2, depth: 0.2
  in_thread do
    with_fx :reverb, room: 0.5 do
      with_transpose +12 do
        play_synth get_tune_ptn_b1
        play_synth get_tune_ptn_b2
        play_synth get_tune_ptn_b3
        play_synth get_tune_ptn_b4
      end
    end
  end
end

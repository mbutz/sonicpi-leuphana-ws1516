# Effects in Sonic Pi

use_bpm 180
use_synth :fm
use_synth_defaults attack: 0,  sustain: 1, release: 0.5

pool =  [degree(1, :ds5, :mixolydian),
         degree(5, :ds4, :mixolydian),
         degree(3, :ds4, :mixolydian),
         degree(1, :ds4, :mixolydian),
         degree(4, :ds4, :mixolydian),
         degree(7, :ds4, :mixolydian),
         degree(5, :ds4, :mixolydian)]

# 01. Band Eq
# 02. Bitcrusher
# 03. BPF
# 04. Compressor
# 05. Distortion
# 06. Echo
# 07. Flanger
# 08. HPF
# 09. Ixi Techno
# 10. Krush
# 11. Level
# 12. LPF
# 13. NBPF
# 14. NHPF
# 15. NLPF
# 16. Normaliser
# 17. NRBPF
# 18. NRHPF
# 19. NRLPF
# 20. Pan
# 21. Panslicer
# 22. Pitch Shift
# 23. RBPF
# 24. Reverb
# 25. RHPF
# 26. Ring Mod
# 27. RLPF
# 28. Slicer
# 29. Wobble

ex = 21

live_loop :fm_bitcrusher do
  with_fx :bitcrusher do
    if ex != 2
      stop
    end
    
    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
   
  end
end

# Band Pass Filter
live_loop :fm_band_pass_filter, centre: 100, res: 0.6 do
  with_fx :bpf do
    if ex != 3
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
       
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# Compressor
live_loop :fm_compressor do
  with_fx :compressor do
    if ex != 4
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# Distortion
live_loop :distortion do
  with_fx :distortion do
    if ex != 5
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# Echo
live_loop :echo do
  with_fx :echo, phase: 2 do
    if ex != 6
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# Flanger
live_loop :flanger do
  with_fx :flanger do
    if ex != 7
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 08
live_loop :high_pass_filter do
  with_fx :hpf, cutoff_min: 100, cutoff_max: 200 do
    if ex != 8
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 09
live_loop :ixi_techno do
  with_fx :ixi_techno do
    if ex != 9
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 10
live_loop :krush do
  with_fx :krush do
    if ex != 10
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 11
live_loop :krush do
  with_fx :krush do
    if ex != 10
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 13
live_loop :low_pass_filter do
  with_fx :lpf, cutoff: 75 do
    if ex != 13
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 17
live_loop :normalised_resonant_bpf do
  with_fx :nrbpf, centre: 100, res: 0.2 do
    if ex != 17
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 17
live_loop :normalised_resonant_bpf do
  with_fx :nrbpf, centre: 100, res: 0.2 do
    if ex != 17
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end

# 21
live_loop :panslicer do
  with_fx :panslicer, phase: 2, pan_min: -0.2, pan_max: 0.2, pulse_width: 0.75 do
    if ex != 21
      stop
    end

    sample :ambi_piano, rate: 0.79
    sleep sample_duration(:ambi_piano)
    
    play pool[0, 4]
    sleep 1
    play_pattern_timed(pool, [1, 1, 1, 1, 1, 1, 1])
  end
end









# Synth: Beep (pure sine wave)
# Defaults: attack: 0; decay: 0; release: 1; attack_level: 1; sustain_level: 1; env_curve: 2

  use_synth :pretty_bell
  use_synth_defaults amp: 1,  attack: 0.5, sustain: 1, release: 1, cutoff: 100


# live_loop :pp do
#   # play_pattern [67,77,69]
#   play_pattern_timed [67,77,69],[0.4]
# end

# sleep 0.4

# live_loop :b do
#   play_pattern_timed [:c4, :bb3],[0.8]
# end

define :echoes do |num, tonics, co=80, res=0.9, amp=1|
  num.times do
    play chord(tonics.choose, :minor).choose, res: res, cutoff: rrand(co - 40, co + 20), amp: 0.5 * amp, attack: 0, release: rrand(0.5, 1.5), pan: rrand(-0.7, 0.7)
    sleep [0.25, 0.5, 0.5, 0.5, 1, 1].choose
  end
end

#echoes(5, [:e1, :e2, :e3])
#sleep 3
#echoes(5, [:b1, :b2, :e1, :e2, :b3, :e3])
#sleep 3
#echoes(1, [:b1, :b2, :e1, :e2, :b3, :e3], 85,  0.98)

# play chord(:a3, :m7)
# sleep 1
# play chord(:d4, "7sus2")
# sleep 1
# play chord(:d4, "7sus4") 






# coding: utf-8
# "Ästhetik, Regel, Klang. Musikprogrammierung mit Sonic Pi" - 3. Termin
# Elements of Musical Theory

use_bpm 120

# The Material of Western Music - Semitones
############################################################
comment do

    play_pattern [60,61,62,63,64,65,66,67,68,69,70,71,72]

end

# Scales
############################################################
uncomment do
  
  define :play_with_amp do | list |
    list.each do |i|
      control (play i[0], amp: i[2])
      sleep i[1]
    end
  end

  play_with_amp [[:c,1,1],[:cs,1,0.1],[:d,1,1],[:ds,1,0.1],[:e,1,1],[:f,1,1],
                 [:fs,1,0.1],[:g,1,1],[:gs,1,0.1],[:a,1,1],[:bb,1,0.1],[:b,1,1],[:c5,1,1]]
  
  sleep 1
  play_pattern [60,62,64,65,67,69,71,72]

 
end #comment


# 
#  musician.rb
#  fingers
#  
#  Created by Frederic Cormier on 2008-12-08.
#  Copyright 2008 __MyCompanyName__. All rights reserved.
# 

require 'instrument'

class Musician
    def initialize(instrument_def,instrument_name)
        @instrument = Instrument::Fretboard.new(instrument_def, instrument_name)
        
    end
    
    def play_chord( root, octave, type, inversion, options ={})
        chord       = Tones::Chord(root, octave, type, inversion)
        @stickyfy   = options[:stickyfy]||= false
        @guitarify  = options[:guitarify]||= false
    end
end
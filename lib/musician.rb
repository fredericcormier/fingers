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
    
    def play_chord( root, octave, type, inversion = Tones::NONE, options ={})
        chord       = Tones::Chord.new(root, octave, type, inversion)
        solution    = Marshal.load(Marshal.dump(@instrument.strings))		#make a fresh copy
        solution.each do |s|
            puts s.class
        	s.notes.map! {|e| e = chord.notes.include?(e) ? e : Note.new('X',0) } 
    	end
        # @stickyfy   = options[:stickyfy]||= false
        # @guitarify  = options[:guitarify]||= false
    end
end

eddie = Musician.new(GUITAR, 'guigui')
puts eddie.play_chord('c', 4, :major)
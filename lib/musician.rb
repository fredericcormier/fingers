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
        board       = Marshal.load(Marshal.dump(@instrument.strings))		#make a fresh copy
        place_notes(board, chord)
       
        # @stickyfy   = options[:stickyfy]||= false
        # @guitarify  = options[:guitarify]||= false
    end
   
   #erases the notes that don't match the request
    def place_notes(fb, run)
    #for each instrument string, for each note if that note is included in the run (Chord or Scale)
    #keep that note, else replace with a 'X'0
         fb.each do |s|                                                  
            s.notes.map! { |e| e = run.notes.include?(e) ? e : Note.new('X', 0)  }
        end
    end
    
    private :place_notes
end

eddie = Musician.new(GUITAR, 'guigui')
puts eddie.play_chord('c', 4, :major)
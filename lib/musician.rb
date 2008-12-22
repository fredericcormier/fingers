# 
#  musician.rb
#  fingers
#  
#  Created by Frederic Cormier on 2008-12-08.
#  Copyright 2008 __MyCompanyName__. All rights reserved.
# 

require 'instrument'
require "ascii_printer"
class ArrayOfNotesRequired    < ArgumentError; end


class Musician
    E__M = {
        :no_array_rep =>    "Array of Notes required"
    }
    def initialize(instrument_def,instrument_name)
        @instrument = Instrument::Fretboard.new(instrument_def, instrument_name) 
    end
    
    # play(request) accept any request in the form of  an Array of Notes:
    # - Chords
    # - Scales
    # - Notes
    # It duplicates a set of strings in the @onboard instance variable then check if each note is included in the request?
    # === Usage
    #   eddie = Musician.new(GUITAR, 'fender')
    #   eddie.play(Chord.new('c', 4, :minor))
    #   eddie.play(Note.new('c', 5))
    def play request
        # raise error if it's not an Array of Notes
        raise ArrayOfNotesRequired  unless request.to_a.all? { |e| e.class == Note  }
        #delete previous requests
        @onboard = nil      
        #  duplicates a set of strings then check if each note is included in the request?
        @onboard = Marshal.load(Marshal.dump(@instrument.strings))		#make a fresh copy
        @onboard.each do |s|
            # Mark as ('X',0) if the note is not valid
            s.to_a.map! { |e| e = request.to_a.include?(e) ? e : Note.new('X', 0)  } 
        end 
        render :style => :ascii, :name => request.name
    end
    
    def render(options = {})
        options[:name]||= nil
        case options[:style]
        when :ascii
            puts options[:name] unless options[:name] == nil
            ASCIIPrinter.new(@onboard)
         when :html   
        end
    end
end


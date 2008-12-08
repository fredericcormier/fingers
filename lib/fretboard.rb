require "tones"
require "idef"
include Tones
include InstrumentDef

# a istring (or instrument string) is simply a repeating chromatic scale
# note that we copy the chromatic scale in the string array
class IString < Tones::ChromaticScale

	attr_reader :this_string, :length

	def initialize(root,octave, length)
		super(root, octave)
		@this_string =  Array.new()
		@length = length
		@length.times { |i| @this_string << @chromatic_scale[i] }
	end
	#return this string's note at fret number x
	def note_at_fret(fretNum)
		@this_string[fretNum]	
	end
	#like the method name says
	def can_play_note?( note, octave)			
		@this_string.include?  Note.new(note, octave)
	end

	def to_s
		sout =""
		@this_string.each { |e| sout << e.note.to_s << e.octave.to_s<<" "}
		sout
	end
end	

# A Instrument is an Array of "numOfStrings" strings.
# we first load the tuning by setting the notes at fret "0"
# then we create new IStrings("chromatic scale")
class Fretboard
	attr_reader :numOfStrings, :setOfStrings, :name, :tuning

	def initialize(instrumentDef,name)					
		@numOfStrings = instrumentDef.length		
		@setOfStrings = Array.new(0)
		@tuning       = Array.new(0)
		@name         = name

		@numOfStrings.times { |i| @tuning << instrumentDef[i][0] }
		@numOfStrings.times { |t| @setOfStrings<<IString.new(instrumentDef[t][0],instrumentDef[t][1],instrumentDef[t][2])} 
	end

end




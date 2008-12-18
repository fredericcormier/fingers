#
#  Created by Frederic Cormier on 2008-06-02.
# 

module Tones

    
 #logger things--------------------- 
 BEGIN {
 	require 'Logger'

    path_to_logfile = File.join(File.expand_path(File.dirname(__FILE__)),'..','zings', 'log.txt')
    $logger = Logger.new(path_to_logfile)
    $logger.level = Logger::DEBUG
 #End logger -----------------
} 
    #exceptions
    class NoteError     		< ArgumentError; end
    class OctaveError   		< ArgumentError; end
	class ChordInversionError	< ArgumentError; end
	class ArrayOutOfBoundsError < ArgumentError; end

	# E__M stands for ERROR_MESSAGES
	 E__M = {
		:note_error					=> 'Notes must be in the range of C .. B',
		:octave_error				=> 'Octave must be between -1 and 9',
		:chord_inversion_error		=> 'This inversion does not apply to that chord',
		:array_out_of_bounds_error  => 'Array out of bounds, no such index'
	}
    
	NOTE_SHARP  = %w[C C# D D# E F F# G G# A A# B ]
	NOTE_FLAT 	= %w[C Db D Eb E F Gb G Ab A Bb B ]
	
	
	# By default, we use the 'sharp' scale
	NOTES		= NOTE_SHARP
	
	# original Chromatic Scale Length (from c to b)
	ALL_NOTES_LENGTH = 12 
	
	# Chromatic Scale Length set to 3 octaves to deal with 14th, 17th and 21st degrees
	CHROM_SCALE_LENGTH = 36     
	                             
	# chord inversions                 
	NONE    = 0
	FIRST   = 1
	SECOND  = 2   
	THIRD   = 3
	FOURTH  = 4 
	FITH	= 5  

	TRIAD       =   [:major, :minor, :sus4, :diminished, :augmented ]
	
	QUAD        =   [:major_7, :minor_7, :dominant_7, :seventh_sus4, :major_6, :minor_6,
	                    :half_diminished_7,:diminished_7, :augmented_7, :minor_major ]
	                    
	QUINTUPLE   =   [:major_9, :minor_9, :major_6_9, :minor_6_9, :ninth ]
		
	SCALE_FORMULAS = {
	    :chromatic =>           [0,1,2,3,4,5,6,7,8,9,10,11,12],
		:major_scale => 	    [0,2,4,5,7,9,11,12],
		:natural_minor =>       [0,2,3,5,7,8,10,12],
		:harmonic_minor =>      [0,2,3,5,7,8,11,12],
		:melodic_minor =>       [0,2,3,5,7,9,11,12],
		:ionian =>              [0,2,4,5,7,9,11,12],
		:dorian  =>             [0,2,3,5,7,9,10,12],
		:phrygian =>            [0,1,3,5,7,8,10,12],
		:lydian =>              [0,2,4,6,7,9,11,12],
		:mixolydian =>          [0,2,4,5,7,9,10,12],
		:aeolian =>             [0,2,3,5,7,8,10,12],
		:locrian =>             [0,1,3,5,6,8,10,12],
		:gypsy_minor =>         [0,2,3,6,7,8,11,12],
		:whole_tone =>          [0,2,4,6,8,10,12],
		:major_pentatonic =>    [0,2,4,7,9,12],
		:minor_pentatonic =>    [0,3,5,7,10,12]

	}


	CHORD_FORMULAS ={   
		:major =>               [0,4,7],
		:major_6 =>             [0,4,7,9 ],
		:major_7 =>             [0,4,7,11],
		:major_9 =>             [0,4,7,11,14],
		:major_6_9=>            [0,4,7,9,14],
		:major_11 =>            [0,4,7,11,14,17],
		:major_13 =>            [0,4,7,11,14,17,21],
		:minor =>               [0,3,7],
		:minor_6 =>             [0,3,7,9],
		:minor_7 =>             [0,3,7,10],
		:minor_9 =>             [0,3,7,10,14],
		:minor_6_9 =>           [0,3,7,9,14],
		:minor_11 =>            [0,3,7,10,14,17],
		:minor_13 =>            [0,3,7,10,14,17,21],
		:dominant_7=>           [0,4,7,10],
		:ninth =>               [0,4,7,10,14],
		:eleventh =>            [0,4,7,10,14,17],
		:thirteenth =>          [0,4,7,10,14,17,21],
		:diminished =>          [0,3,6],
		:half_diminished_7 =>   [0,3,6,10],
		:diminished_7 =>        [0,3,6,9],
		:augmented =>           [0,4,8],
		:augmented_7 =>         [0,4,8,10],
		:sus4 =>                [0,5,7],
		:seventh_sus4 =>        [0,5,7,10],
		:minor_major =>         [0,3,7,11]
	}
	
	#  	Note				Hz		cpspch	MIDI
	PITCHES =			{
		'C-1'	 =>		[8.176,		3.00,	0],		'C#-1' 	 =>	      [8.662	,	3.01,	1],
		'D-1'    =>		[9.177	,	3.02,	2],		'D#-1' 	 =>	      [9.723	,	3.03,	3],
		'E-1'	 =>		[10.301	,	3.04,	4],		'F-1'	 =>	      [10.913	,	3.05,	5],
		'F#-1'	 =>		[11.562	,	3.06,	6],		'G-1'	 =>	      [12.250	,	3.07,	7],
		"G#-1"   =>		[12.978	,	3.08,	8],		"A-1"    =>	      [13.750	,	3.09,	9],
		"A#-1"   =>		[14.568	,	3.10,	10],	"B-1"    =>	       [15.434	,	3.11,	11],
		"C0"     =>		[16.352	,	4.00,	12],	"C#0"    =>	       [17.324	,	4.01,	13],
		"D0"     =>		[18.354	,	4.02,	14],	"D#0"    =>	       [19.445	,	4.03,	15],
		"E0"     =>		[20.602	,	4.04,	16],	"F0"     =>	       [21.827	,	4.05,	17],
		"F#0"    =>		[23.125	,	4.06,	18],	"G0"     =>	       [24.500	,	4.07,	19],
		"G#0"    =>		[25.957	,	4.08,	20],	"A0"     =>	       [27.500	,	4.09,	21],
		"A#0"    =>		[29.135	,	4.10,	22],	"B0"     =>	       [30.868	,	4.11,	23],
		"C1"     =>		[32.703	,	5.00,	24],	"C#1"    =>	       [34.648	,	5.01,	25],
		"D1"     =>		[36.708	,	5.02,	26],	"D#1"    =>	       [38.891	,	5.03,	27],
		"E1"     =>   	[41.203	,	5.04,	28],	"F1"     =>	       [43.654	,	5.05,	29],
		"F#1"  	 =>   	[46.249	,	5.06,	30],	"G1"     =>	       [48.999	,	5.07,	31],
		"G#1"    =>   	[51.913	,	5.08,	32],	"A1"     =>	       [55.000	,	5.09,	33],
		"A#1"    =>   	[58.270	,	5.10,	34],	"B1"     =>	       [61.735	,	5.11,	35],
		"C2"     =>   	[65.406	,	6.00,	36],	"C#2"    =>	       [69.296	,	6.01,	37],
		"D2"     =>   	[73.416	,	6.02,	38],	"D#2"    =>	       [77.782	,	6.03,	39],
		"E2"     =>   	[82.407	,	6.04,	40],	"F2"     =>	       [87.307	,	6.05,	41],
		"F#2"    =>   	[92.499	,	6.06,	42],	"G2"     =>	       [97.999	,	6.07,	43],
		"G#2"    =>   	[103.826,	6.08,	44],	"A2"     =>	       [110.000	,	6.09,	45],
		"A#2"    =>   	[116.541,	6.10,	46],	"B2"     =>	       [123.471	,	6.11,	47],
		"C3"     =>   	[130.813,	7.00,	48],	"C#3"    =>	       [138.591	,	7.01,	49],
		"D3"     =>   	[146.832,	7.02,	50],	"D#3"    =>	       [155.563	,	7.03,	51],
		"E3"     =>   	[164.814,	7.04,	52],	"F3"     =>	       [174.614	,	7.05,	53],
		"F#3"    =>   	[184.997,	7.06,	54],	"G3"     =>	       [195.998	,	7.07,	55],
		"G#3"    =>   	[207.652,	7.08,	56],	"A3"     =>	       [220.000	,	7.09,	57],
		"A#3"    =>   	[233.082,	7.10,	58],	"B3"     =>	       [246.942	,	7.11,	59],
		"C4"     =>   	[261.626,	8.00,	60],	"C#4"  	 =>	       [277.183	,	8.01,	61],
		"D4"     =>   	[293.665,	8.02,	62],	"D#4"    =>	       [311.127	,	8.03,	63],
		"E4"     =>   	[329.628,	8.04,	64],	"F4"     =>	       [349.228	,	8.05,	65],
		"F#4"    =>   	[369.994,	8.06,	66],	"G4"     =>	       [391.995	,	8.07,	67],
		"G#4"    =>   	[415.305,	8.08,	68],	"A4"     =>	       [440.000	,	8.09,	69],
		"A#4"    =>   	[466.164,	8.10,	70],	"B4"     =>	       [493.883	,	8.11,	71],
		"C5"     =>   	[523.251,	9.00,	72],	"C#5"    =>	       [554.365	,	9.01,	73],
		"D5"     =>   	[587.330,	9.02,	74],	"D#5"    =>	       [622.254	,	9.03,	75],
		"E5"     =>   	[659.255,	9.04,	76],	"F5"     =>	       [698.456	,	9.05,	77],
		"F#5"    =>   	[739.989,	9.06,	78],	"G5"     =>	       [783.991	,	9.07,	79],
		"G#5"    =>   	[830.609,	9.08,	80],	"A5"     =>	       [880.000	,	9.09,	81],
		"A#5"    =>   	[932.328,	9.10,	82],	"B5"     =>	       [987.767	,	9.11,	83],
		"C6"     =>   	[1046.502,	10.00,	84],	"C#6"    =>	       [1108.731,	10.01,	85],
		"D6"     =>   	[1174.659,	10.02,	86],	"D#6"    =>	       [1244.508,	10.03,	87],
		"E6"     =>   	[1318.510,	10.04,	88],	"F6"     =>	       [1396.913,	10.05,	89],
		"F#6"    =>   	[1479.978,	10.06,	90],	"G6"     =>	       [1567.982,	10.07,	91],
		"G#6"    =>   	[1661.219,	10.08,	92],	"A6"     =>	       [1760.000,	10.09,	93],
		"A#6"    =>   	[1864.655,	10.10,	94],	"B6"     =>	       [1975.533,	10.11,	95],
		"C7"     =>   	[2093.005,	11.00,	96],	"C#7"    =>	       [2217.461,	11.01,	97],
		"D7"     =>   	[2349.318,	11.02,	98],	"D#7"    =>	       [2489.016,	11.03,	99],
		"E7"     =>   	[2637.020,	11.04,	100],	"F7"     =>	       [2793.826,	11.05,	101],
		"F#7"    =>   	[2959.955,	11.06,	102],	"G7"     =>	       [3135.963,	11.07,	103],
		"G#7"    =>   	[3322.438,	11.08,	104],	"A7"     =>	       [3520.000,	11.09,	105],
		"A#7"    =>   	[3729.310,	11.10,	106],	"B7"     =>	       [3951.066,	11.11,	107],
		"C8"     =>   	[4186.009,	12.00,	108],	"C#8"    =>	       [4434.922,	12.01,	109],
		"D8"     =>   	[4698.636,	12.02,	110],	"D#8"    =>	       [4978.032,	12.03,	111],
		"E8"     =>   	[5274.041,	12.04,	112],	"F8"     =>	       [5587.652,	12.05,	113],
		"F#8"    =>   	[5919.911,	12.06,	114],	"G8"     =>	       [6271.927,	12.07,	115],
		"G#8"    =>   	[6644.875,	12.08,	116],	"A8"     =>	       [7040.000,	12.09,	117],
		"A#8"    =>   	[7458.620,	12.10,	118],	"B8"     =>	       [7902.133,	12.11,	119],
		"C9"     =>   	[8372.018,	13.00,	120],	"C#9"    =>	       [8869.844,	13.01,	121],
		"D9"     =>   	[9397.273,	13.02,	122],	"D#9"    =>	       [9956.063,	13.03,	123],
		"E9"     =>   	[10548.08,	13.04,	124],	"F9"     =>	       [11175.30,	13.05,	125],
		"F#9"    =>   	[11839.82,	13.06,	126],	"G9"     =>	       [12543.85,	13.07,	127]
	}
	
	# Class Note
	# 
	# 
	#
	#  == Converters
	# to_s, to_hz, to_MIDI
	#
	# Examples
	# 		puts csharp = Note.new( 'c#', 1) 				# => c# 1                 
	# 		puts "csharp succ is #{csharp.succ}" 			# => csharp succ is D 1             
	# 		puts c = csharp.prev   							# => C 1                           
	# 		puts "c's fith is #{c.at_interval(7)}"  		# => c's fith is G 1          
	# 		puts "c's prev is #{c.prev}"					# => c's prev is B 0                      
	# 		puts "A frequency is #{(Note.new 'a', 4).to_hz}"# => A frequency is 440.0
	
	
	class Note

		include Comparable

		attr_reader :note, 
		            :octave	,
		            :index		

		def initialize (n = 'C', o = 1)
			raise NoteError, 	E__M[:note_error] 	unless (NOTE_SHARP + NOTE_FLAT).include? n.capitalize
			raise OctaveError, 	E__M[:octave_error] unless (-1..9).member? o
			@note 	= n.capitalize
			@octave = o
			@index 	= NOTES.index(@note)
		end

		# from comparable
		def <=> (other)
			case (self.octave <=> other.octave)
			when -1 then return -1				
			when 1  then return 1
			when 0  then NOTES.index(self.note)<=>NOTES.index(other.note.capitalize)
			end
		end

		def succ 
			self.note == 'B'? Note.new('C', self.octave+1) : Note.new(NOTES[@index+1], self.octave)
		end

		def prev
			self.note == 'C'? Note.new('B', self.octave-1) : Note.new(NOTES[@index-1], self.octave)
		end

		def to_s
			"#{note} #{octave}"
		end

		def to_a
			[@note,@octave]
		end

		def [](i)
			case i
			when 0, -2: @note
			when 1, -1: @octave
			when :note, "note": @note
			when :octave, "octave": @octave
			else raise ArrayOutOfBoundsError, E__M[:array_out_of_bounds_error]
			end
		end
		# returns the note a interval
		# ex: c.at_interval(7) #=> g
		def at_interval(i)
			raise TypeError, "Integer expected" unless i.is_a? Fixnum
			note = self
			if i < 0 then
				i.abs.times { |forget| note = note.prev  }
			else
				i.times { |forget| note = note.succ  }
			end
			return note
		end
		
        #returns the interval between this note and an other
        def interval(other)
            i = 0
            case self <=> other
            when 0 then return 0
            when -1 then 
                ((other.index - self.index) + ((other.octave - self.octave) * 12))
            when 1 then
               -((self.index - other.index) + ((self.octave - other.octave) * 12))
            end    
        end
        
		alias + at_interval

		# returns the frequency of the note
		def to_hz
			PITCHES["#{self.note.upcase}#{self.octave.to_s}"][0]
		end

		# returns the midi note for this note
		def to_MIDI 
			PITCHES["#{self.note.upcase}#{self.octave.to_s}"][2] 
		end
	end 


	# Class ChromaticScale
	# Create a scale of 12 semitones comprised only of  nested halftones 
	# starting at root
	# this is the foundation scale for computing other scales as well as chords
	# you shouldn't use this Class directly


	class ChromaticScale
		include Comparable
		attr_reader     :chromatic_scale,    #contains all the semitones (Notes) of a scale 
		#starting at @root and @octave
		:root,               #root note                                    
		:octave              #root octave

		def initialize(root, octave)
			@root           = root.upcase                       #the root of this scale
			@octave         = octave
			@chromatic_scale = Array.new([])				   #array of Notes
			@chromatic_scale << Note.new(@root,@octave)
			(CHROM_SCALE_LENGTH-1).times { |t| @chromatic_scale << @chromatic_scale.last.succ }		
		end

		# Comparision is made simply by comparing the root note
		def <=> (other)
			return self.root <=> other.root
		end

		# returns each notes of the scale
		def each
			@chromatic_scale.each { |e| yield e  }	    
		end

		def to_s
			sout = ""
			@chromatic_scale.each {|n| sout << n.note.to_s<<' '<< n.octave.to_s<<', ' }
			sout
		end 
		
		def name
		    "#{@root} #{octave}" 
	    end
	end # of class

	# Class Chord
	# The chord is derived from it's chromatic scale on 
	# which we applied a possibly inverted formula
	#
	# Examples
	# 		cmaj = Tones::Chord 'c', 1, :major 								# => C1 E1 G1
	#		cmaj = Tones::Chord.new('c', 1, :major, Tones::SECOND)			# => G1 C2 E2	


	class Chord < ChromaticScale
		attr_reader :notes, :type, :inversion 

		def initialize(root, octave, type, inversion = Tones::NONE)   
			super(root, octave)               
			@type = type				
			self.invert!(inversion)
		end

		# the inversion is done on the formula before generating the actual scale
		# == WARNING ***************************************************************
		# do not access or chain a call to this as the method returns an array (the inverted formula)
		# Examples of use
		#  			c = Chord.new ('c', 1, :major)
		# 			c.invert!(Tones::SECOND)
		# 			c.do_whatever_you_want (now)
		# =begin
		#	TODO  turn this into a private method and write  public invert that returns a new chord
		#=end
		def invert! inv
			#error if tryng a 7th inversion on a 3 notes chord
			raise ChordInversionError , E__M[:chord_inversion_error]  unless inv <= (Tones::CHORD_FORMULAS[type].length )-1										
			@notes = Array.new  
			@inversion = inv  
			invform = CHORD_FORMULAS[@type].dup			#-------NOTE THE DUP-------	
			inversion.times do |t|
				head = invform.shift
				head += 12
				invform << head
			end
			invform.each { |e|  @notes.push(@chromatic_scale[e]) }		
		end

		# Return each element in turn
		def each
			@notes.each { |e| yield e  }
		end

		# Return a new Chord Object transposed
		def transpose semitone		
			transposed_note =Note.new(@root, @octave).at_interval(semitone)		
			Chord.new(transposed_note.note, transposed_note.octave, @type, @inversion)
		end
		
		alias + transpose
		
		def to_a
			@notes
		end
		
		def [](i)
		    raise ArrayOutOfBoundsError, E__M[:array_out_of_bounds_error] unless (0..((@notes.length )-1)).include? i
			@notes[i]
		end
		
		def to_s
			sout = ""
			@notes.each {|n| sout << n.note.to_s<< n.octave.to_s<<' '}
			sout
		end

		def name
			"#{@root}#{@octave} #{(@type).to_s.capitalize} inversion: #{@inversion}"
		end
	end #of Chord
	
    #
    #
    #
    #
    #
	class   Scale <  ChromaticScale

		attr_reader :notes, :mode

		private

		def initialize ( root, octave,  mode = :chromatic) 
			super(root, octave)
			@notes = Array.new()     
			@mode = mode         
			case @mode                                                   
			when :chromatic    
				@notes = @chromatic_scale  
			else 
				modalScaleFromKey!(@root, @octave, @mode)
			end 
		end

		def modalScaleFromKey!(root, octave, mode)
			formulas = SCALE_FORMULAS[mode]                                    
			formulas.each {|d| @notes<< @chromatic_scale[d]} 
		end

		public

		def each
			@notes.each { |e| yield e  }
		end
		
		def to_a
			@notes
		end

        def [](i)
            raise ArrayOutOfBoundsError, E__M[:array_out_of_bounds_error] unless (0..((@notes.length )-1)).include? i
            @notes[i]
        end
		
		def transpose semitone 
			transposed_note =Note.new(@root, @octave).at_interval(semitone)		
			Scale.new(transposed_note.note, transposed_note.octave, @mode)		
		end

        alias + transpose
        
		def to_s
			sout = ''
			@notes.each {|n| sout << n.note.to_s<< n.octave.to_s<<' ' }
			sout
		end 

		def name
			"#{@root}#{@octave} #{@mode}"
		end
	end #of Scale
end


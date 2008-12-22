require "tones"
require "idef"
include Tones
include InstrumentDef

module Instrument
    #===Note about tuning
    # The tuning used here is from the first (highest) string to lowest string
    # ex for standard guitar (first to last):
    #   Guitar:      E, B, G, D, A, E
    #for touch instruments, with inverted tunings, it's the Chapman Stick® standard that is used (first to last):
    #   Stick baritone: A, E, B, F#, C# / C, G, D, A, E
    class NoSuchFretError           < ArgumentError; end
    class StringOutOfBounds         < ArgumentError; end

    E__M = {
        :no_such_fret_error         => 'This string cannot play at that fret',
        :string_out_of_bounds       => 'No string at that index'
    }

    # a string (or instrument string) is simply a repeating chromatic scale.
    # note that we copy the chromatic scale in the string array.
    # a string can cover a range of 3 octaves Max (the chramatic scale length is set to 3 octaves),
    # which is much more than what a real string can handle
    #
    #==== Usage (although you shouldn't use this class directly)
    #
    # s = InstrumentDef::String.new('c', 4, 24)
    # s[0] => C 4   #index 0 is the open string
    class String < Tones::ChromaticScale

        attr_reader :notes, :length

        def initialize(root,octave, length)
            super(root, octave)
            @notes =  Array.new()
            @length = length
            @length.times { |i| @notes << @chromatic_scale[i] }
        end
        #return this string's note at fretNumber
        def [](fretNum)
            raise NoSuchFretError, E__M[:no_such_fret_error] unless (0..@length-1).include? fretNum
            @notes[fretNum]	
        end

        alias note_at_fret []

        #Is the note in the range of this string ?
        def can_play_note?(*args)
            a = args
            case a[0]
            when Tones::Note then
                @notes.include?(a[0])       
            when Object::String  then
                if a[1].class == Fixnum
                    @notes.include?(Note.new(a[0], a[1]))
                end
            else
                raise ArgumentError
            end 
        end
        def to_a
            @notes
        end
        
        def each
            @notes.each { |e| yield e  }
        end
        def to_s
            sout =""
            @notes.each { |e| sout << e.note.to_s << e.octave.to_s<<" "}
            sout
        end
        # name is inherited from ChromaticScale.name
    end	

    # An Instrument is an Array of "num_of_strings" strings.(thus an array of array).
    # We first load the tuning by setting the notes at fret "0"
    # then we create new Strings("chromatic scale") according to the tuning
    #
    # to access notes through the fretboard just do
    #=== Usage
    # guitar  = Instrument::Fretboard.new(GUITAR, 'my_beloved_guild')
    # puts guitar[1][3]  => D 4
    #
    #the first array access the string and the second the fret. the array are zero based so in this example we have:
    # guitar[1] this is the second string (b on guitar)
    # guitar[1][3] second string third fret (fret 0 is open string)
    class Fretboard
        attr_reader :num_of_strings, :strings, :name, :tuning

        def initialize(instrumentDef,name = "")                    
            @num_of_strings     = instrumentDef.length        
            @strings            = Array.new(0)
            @tuning             = Array.new(0)
            @name               = name

            @num_of_strings.times { |i| @tuning << instrumentDef[i][0] }
            @num_of_strings.times { |t| @strings<<Instrument::String.new(instrumentDef[t][0],instrumentDef[t][1],instrumentDef[t][2])} 
        end
        #access string at index
        def [](index)
            raise StringOutOfBounds, E__M[:string_out_of_bounds] unless (0..(@num_of_strings - 1)).member? index
            @strings[index]
        end
        def each
            @strings.each { |e| yield e  }
        end
    end

end
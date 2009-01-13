require "test/unit"

require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'Instrument')

include Instrument

class TestFretboard < Test::Unit::TestCase
    StickHere = "
    D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 G5 G#5 A5 A#5 B5 C6 C#6 
    A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 G5 G#5   
    E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 
    B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 G5 G#5 A5 A#5 
    F#2 G2 G#2 A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 
    C#2 D2 D#2 E2 F2 F#2 G2 G#2 A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 
    C1 C#1 D1 D#1 E1 F1 F#1 G1 G#1 A1 A#1 B1 C2 C#2 D2 D#2 E2 F2 F#2 G2 G#2 A2 A#2 B2 
    G1 G#1 A1 A#1 B1 C2 C#2 D2 D#2 E2 F2 F#2 G2 G#2 A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 
    D2 D#2 E2 F2 F#2 G2 G#2 A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 
    A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 
    E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 
    B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 G5 G#5 A5 A#5"
    Guitar = "
    E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 G5 G#5 A5 A#5 B5 C6 C#6 D6 D#6 
    B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 G5 G#5 A5 A#5 
    G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 D5 D#5 E5 F5 F#5 
    D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 A4 A#4 B4 C5 C#5 
    A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4 E4 F4 F#4 G4 G#4 
    E2 F2 F#2 G2 G#2 A2 A#2 B2 C3 C#3 D3 D#3 E3 F3 F#3 G3 G#3 A3 A#3 B3 C4 C#4 D4 D#4"
    def setup
        @estring = Instrument::String.new( 'e', 4, 24)
        @stick  = Instrument::Fretboard.new(STICK_RH, 'Stick')
        @guitar = Instrument::Fretboard.new(GUITAR, 'my_beloved_guild') 
    end
    def test_string
		b = Note.new('b', 5)
        assert_raise(NoSuchFretError) { @estring[24] }
        assert_nothing_raised(NoSuchFretError) { @estring[23]  }
        assert(@estring.can_play_note?('a', 5), "An  E 4 string can play a A5")
        assert(@estring.can_play_note?(Note.new('a',5)) , "this is true")
		assert(@estring.can_play_note?(b), "Failed passing Note")
        assert_nothing_raised(ArgumentError) {@estring.can_play_note?(Note.new('a', 5)) }
        assert_raise(ArgumentError) {@estring.can_play_note?(self)  }
        
        assert(@estring.name == "E 4", "Failure message.")
    end
    
    def test_fretboard   
        assert(@stick[0] == Instrument::String.new('d', 4, 24), "Strings should be equals") 
        assert(@stick[2] == Instrument::String.new('e', 3, 24), "Strings should be equals") 
        assert_raise(StringOutOfBounds ) { @stick[12] }
        assert(@stick[2][0] == Note.new('e', 3), "Accessing notes through fretboard and strings failed")
        assert(@guitar[5][3].note == 'G', 'Error accessing guitar note through Fretboard')
        assert_raise(NoSuchFretError) { @guitar[4][26]  }
        assert_raise(StringOutOfBounds) { @guitar[7] }
     
    end
end
require "test/unit"

require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'tones')

class TestTones < Test::Unit::TestCase

    
    include Tones   
    def setup
        
        @c1     = Note.new 'c', 1
        @b0     = Note.new 'b', 0
        @cmaj1   = Tones::Chord.new('c', 1, :major, Tones::SECOND)			# => G1 C2 E2
    end

    def test_notes
        assert( @c1.prev == @b0, "those should be the same notes")
        assert( @b0.succ == @c1, "those should be the same notes")
        assert(@c1.at_interval(7)== Note.new('g',1), "G is the fith of C.")
        assert((@c1 + 7) == Note.new('g', 1), "'+' is like at_interval")
        
        assert(Note.new('a',4).to_hz == 440, "A4 is 440 hz.")
        assert_raise(Tones::NoteError) {Note.new('z',1)}
        assert_raise(Tones::OctaveError) {Note.new('c#', -5)  }


    end
    
    def test_chords
        assert(@cmaj1.chord == [Note.new('g',1), Note.new('c', 2), Note.new('e', 2)], "Representation of chord is incorrect")
        
    end
end
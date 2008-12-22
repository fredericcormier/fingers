require "test/unit"

require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'musician')

class TestMusician < Test::Unit::TestCase
    def setup
        @eddie = Musician.new(GUITAR, 'guigui')
        
        
    end
    def test_musician
        # we can ask for chords
        assert_nothing_raised(ArrayOfNotesRequired ) { @eddie.play(Chord.new('c', 4, :minor)) }
        # we can ask for scales
        assert_nothing_raised(ArrayOfNotesRequired ) { @eddie.play(Scale.new('g', 3, :dorian)) }
        # and notes
        assert_nothing_raised(ArrayOfNotesRequired ) { @eddie.play(Note.new('c', 5))  }
        assert_raise(ArrayOfNotesRequired ) { @eddie.play 5 }
        
    end
end
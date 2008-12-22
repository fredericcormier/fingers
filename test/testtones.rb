require "test/unit"

require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'tones')

class TestTones < Test::Unit::TestCase
	include Tones   
	def setup
		@c1     		= Note.new 'c', 1
		@g1             = Note.new 'g', 1
		@b0     		= Note.new 'b', 0
		@cmaj1_inv2  	= Tones::Chord.new('c', 1, :major, Tones::SECOND)			# => G1 C2 E2
		@amaj			= Chord.new 'a', 1, :major
		@cmaj			= Chord.new 'c', 2, :major
		@fsharpMixo     = Scale.new 'f#', 2, :mixolydian
		@fsmString      = "F#2 G#2 A#2 B2 C#3 D#3 E3 F#3 "
	end

	def test_notes
	    assert(@c1.interval(@g1) == 7, "A fith apart")
	    assert(@c1.interval(Note.new('f#', 2))== 18, "a Flat fith and an octave")
	    assert(@c1.interval(@b0) == -1, 'One semitone')
	    assert(@c1.interval(Note.new('g', 0)) == -5, "Fouth below.")
		assert(@c1.prev == @b0, "those should be the same notes")
		assert(@b0.succ == @c1, "those should be the same notes")
		assert(@c1.at_interval(7)== Note.new('g',1), "G is the fith of C.")
		#check alias
		assert_equal(@c1 + 7, @c1.at_interval(7))
		assert((@c1 + 7) == Note.new('g', 1), "'+' is like at_interval")

		assert(Note.new('a',4).to_hz == 440, "A4 is 440 hz.")
		assert_raise(Tones::NoteError) {Note.new('z',1)}
		assert_raise(Tones::OctaveError) {Note.new('c#', -5)  }
		assert_raise(TypeError) { @c1 + 5.2 }
		assert_raise(TypeError) { @c1 + "Yes" }

		assert(@c1[0] == "C", "C at index 0")
		assert(@b0[:octave] == 0, "Octave is 0")
		assert_raise(ArrayOutOfBoundsError) {@b0[8]} 
		assert(@c1.to_a == [@c1], "to_a failed.")               # well! hummm!! ok!!! Sorry
	end

	def test_chords
		assert(@cmaj1_inv2.notes == [Note.new('g',1), Note.new('c', 2), Note.new('e', 2)], "Representation of chord is incorrect")
		assert_raise(Tones::ArrayOutOfBoundsError){@cmaj1_inv2[5]}
		assert( @cmaj1_inv2[2].note == 'E', "Chord Array like access is broken")
		assert_raise(Tones::ArrayOutOfBoundsError){@cmaj1_inv2[3]}
		assert(@amaj + 3 == @cmaj, "+ is an alias for transpose")
	
		#inversion. example: a Major chord is made of 3 notes so 2 inversions are possible
		assert_raise(Tones::ChordInversionError) { @cmaj.invert! 3  }
		assert_nothing_raised(Tones::ChordInversionError) { @cmaj.invert! 2 }
	end
	
	def test_scale
	    assert(@fsharpMixo.to_s == @fsmString, "Comparing strings failed")
	    assert(@fsharpMixo[2] == Note.new('a#', 2), "Array indexing fails on Scales")
	    assert_raise(ArrayOutOfBoundsError) {@fsharpMixo[15]}
	    assert_equal(Scale.new('c',2, :major_scale), Scale.new('c',2, :ionian))
	    assert_equal(Scale.new('c',2, :ionian).transpose(7), Scale.new('g', 2, :ionian))
	    assert_equal(Scale.new('c',2, :ionian)+ 7, Scale.new('g', 2, :ionian))	
	end
end
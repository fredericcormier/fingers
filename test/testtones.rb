require "test/unit"

require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'tones')

class TestTones < Test::Unit::TestCase


	include Tones   
	def setup

		@c1     		= Note.new 'c', 1
		@b0     		= Note.new 'b', 0
		@cmaj1_inv2  	= Tones::Chord.new('c', 1, :major, Tones::SECOND)			# => G1 C2 E2
		@amaj			= Chord.new 'a', 1, :major
		@cmaj			= Chord.new 'c', 2, :major
	end

	def test_notes
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
		assert_nil( @b0[8] )
		assert(@c1.to_a == ['C', 1], "to_a failed.")


	end

	def test_chords
		assert(@cmaj1_inv2.notes == [Note.new('g',1), Note.new('c', 2), Note.new('e', 2)], "Representation of chord is incorrect")
		assert_nil(@cmaj1_inv2[5])
		assert( @cmaj1_inv2[2].note == 'E', "Chord Array like access is broken")
		assert_nil(@cmaj1_inv2[3])

		assert(@amaj + 3 == @cmaj, "+ is an alias for transpose")
		
		#inversion. a Major chord is made of 3 notes so 2 inversions are possible
		assert_raise(Tones::ChordInversionError) { @cmaj.invert! 3  }
		assert_nothing_raised(Tones::ChordInversionError) { @cmaj.invert! 2 }
	end
end
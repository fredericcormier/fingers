require "test/unit"

require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'tones')

class TestTones < Test::Unit::TestCase
	include Tones   
	def setup
		@c1     		= Note.new C, 1
		@g1             = Note.new G, 1
		@b0     		= Note.new B, 0
		@cmaj1_inv2  	= Tones::Chord.new(C, 1, :major, Tones::SECOND)			# => G1 C2 E2
		@amaj			= Chord.new A, 1, :major
		@cmaj			= Chord.new C, 2, :major
		@fsharpMixo     = Scale.new Fs, 2, :mixolydian
		@fsmString      = "F#2 G#2 A#2 B2 C#3 D#3 E3 F#3 "
		@cflat          = Note.new Cb, 5                    # it's a B
	end

	def test_notes
	    assert(@c1.interval(@g1) == 7, "A fith apart")
	    assert(@c1.interval(Note.new(Fs, 2))== 18, "a Flat fith and an octave")
	    assert(@c1.interval(@b0) == -1, 'One semitone')
	    assert(@c1.interval(Note.new(G, 0)) == -5, "Fouth below.")
		assert(@c1.prev == @b0, "those should be the same notes")
		assert(@b0.succ == @c1, "those should be the same notes")
		assert(@c1.at_interval(7)== Note.new(G,1), "G is the fith of C.")
		#check alias
		assert_equal(@c1 + 7, @c1.at_interval(7))
		assert((@c1 + 7) == Note.new(G, 1), "'+' is like at_interval")

		assert(Note.new("a",4).to_hz == 440, "A4 is 440 hz.")
		assert_raise(Tones::NoteError) {Note.new('Z',1)}
		assert_raise(Tones::OctaveError) {Note.new(Cs, -5)  }
		assert_raise(TypeError) { @c1 + 5.2 }
		assert_raise(TypeError) { @c1 + "Yes" }
		#array access
		assert(@c1[0] == "C", "C at index 0")
		assert(@b0[:octave] == 0, "Octave is 0")
		assert_raise(ArrayOutOfBoundsError) {@b0[8]} 
		assert(@c1.to_a == [@c1], "to_a failed.")               # well! hummm!! ok!!! Sorry
		
		assert_equal(@c1[2], 0)
		assert_equal(Note.new( E, 3)[:value], 4)
		
		assert_equal(@cflat ,Note.new(B, 5))
		# test indexing
		assert_equal(@b0.value, 11)
		assert_equal(Note.new(E,2).index, 4)
	end
	
	def test_synonyms
		assert_equal(Note.new(Bs,3), Note.new(C,3))
		assert_nothing_raised(Exception) { Note.new(Es,2) }
		#low level
		#assert_equal(@c1.synonym, Note.new('b#', 1))
	end

	def test_chords
		assert(@cmaj1_inv2.notes == [Note.new(G,1), Note.new(C, 2), Note.new(E, 2)], "Representation of chord is incorrect")
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
	    assert(@fsharpMixo[2] == Note.new(As, 2), "Array indexing fails on Scales")
	    assert_raise(ArrayOutOfBoundsError) {@fsharpMixo[15]}
	    assert_equal(Scale.new(C,2, :major_scale), Scale.new(C,2, :ionian))
	    assert_equal(Scale.new(C,2, :ionian).transpose(7), Scale.new(G, 2, :ionian))
	    assert_equal(Scale.new(C,2, :ionian)+ 7, Scale.new(G, 2, :ionian))	
	end
end
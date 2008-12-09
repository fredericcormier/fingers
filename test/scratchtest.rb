require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'fretboard')

include Tones

puts c = Chord.new( "c", 1, :major)
puts c.invert!(SECOND)
c.invert!(FITH)

puts c

puts s = Tones::Scale.new( "F#",2, :mixolydian)
puts c13 = Tones::Chord.new( 'A',1, :major_13 )
puts c13.name
c13.invert! FITH
puts c13

puts
puts cmaj = Tones::Chord.new('c', 1, :major, Tones::SECOND)          # => G1 C2 E2






s = IString.new('c', 3, 24)
puts s
stick = Fretboard.new(InstrumentDef::STICK_12_CLASSIC,'')
puts
puts stick.setOfStrings

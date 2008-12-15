require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib', 'instrument')

include Tones
include Instrument

begin
puts c = Chord.new( "c", 1, :major)
puts c.invert!(SECOND)
c.invert!(FITH)
Note.new 'c', 15
rescue => e
    puts " Some Errors"
    puts e
    
end
puts c

s = Tones::Scale.new( "F#",2, :mixolydian)
puts s.name + ": "
puts s
puts c13 = Tones::Chord.new( 'A',1, :major_13 )
puts c13.name
c13.invert! FITH
puts c13

puts
puts cmaj = Tones::Chord.new('c', 1, :major, Tones::SECOND)          # => G1 C2 E2






s = Instrument::String.new('c', 3, 24)
puts s
stick = Fretboard.new(STICK,'')
puts stick.strings

3.times { |n| puts  }

guitar  = Instrument::Fretboard.new(GUITAR, 'my_beloved_guild')
puts guitar.strings
puts guitar[1][3]


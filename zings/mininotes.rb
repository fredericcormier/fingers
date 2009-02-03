class Note
	
	class Accidental
		def initialize(a)
			@a = a
			case @a
			when 'f' || 'b' then @weight = -1
			when 's' || '#' then @weight = 1
			when ''  || ' ' then @weight = 0
			end
			
		end
		
		
	end
	def initialize(note, accidental, octave)
		@note, @octave = note, octave
		@accidental = Accidental.new( accidental)
		
	end
	
	
end

n[:C, :s, 5]


note Cs 5
note Bb, 4
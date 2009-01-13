module Test
      C    =   Bs  = 'C'
      Cs   =   Db  = 'C#'
      D            = 'D'
      Ds   =   Eb  = 'D#'
      E    =   Fb  = 'E'
      F    =   Es  = 'F'
      Fs   =   Gb  = 'F#'
      G            = 'G'
      Gs   =   Ab  = 'G#'
      A            = 'A'
      As   =   Bb  = 'A#' 
      B    =   Cb  = 'B'
      NOTES = [C, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B]
    class Mininote 
        attr_reader :note, :octave
        	def initialize (n = C, o = 1)
    			raise "Unknown Notes" unless (NOTES).include? n
    			raise "Invalid octave" unless (-1..9).member? o
    			@note 	= n
    			@octave = o
    			@index 	= NOTES.index(@note)
    		end

    		# from comparable
    		def <=> (other)
    			case (self.octave <=> other.octave)
    			when -1 then return -1				
    			when 1  then return 1
    			when 0  then NOTES.index(self.note)<=>NOTES.index(other.note.capitalize)
    			end
    		end

    		def succ 
    			self.note == 'B'? Mininote.new('C', self.octave+1) : Mininote.new(NOTES[@index+1], self.octave)
    		end

    		def prev
    			self.note == 'C'? Mininote.new('B', self.octave-1) : Mininote.new(NOTES[@index-1], self.octave)
    		end

    		def to_s
    			"#{@note} #{@octave}"
    		end
  
    end
end

include Test

a = Mininote.new A, 5
puts a.succ



class NoteArray
  class WrapArray < Array
    def [] index
      super(index % self.length)
    end
  end  
def initialize
    @wa = WrapArray.new %w[A A# B C C# D D# E F F# G G#]
    def [] index
      @wa[index]
    end
  end
  
end





n = NoteArray.new
puts n[-11]

puts n[11]

puts n[57]


class WrapArray < Array
  def [] index
    super(index % self.length)
  end
end



Notes =  %w[A A# B C C# D D# E F F# G G#]
w = WrapArray.new(12) {|i| Notes[i]}
36.times { |i| puts w[i]  }
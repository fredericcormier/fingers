class ASCIIPrinter
    def initialize(inboard)
        sout = ""                          #skip a line
        inboard[1].notes.each_index { |i| sout<<i.to_s.center(4)<<" "  }
        puts sout
        inboard.each do |s|
            sout = ""
            s.notes.each do |n|
                if n.note =='X'
                    sout <<'----'.center(4) 
                    sout <<'|'
                else
                    sout <<"#{n.note}#{n.octave}".center(4)
                    sout <<'|'
                end 
            end 
            puts sout
        end
    end

end

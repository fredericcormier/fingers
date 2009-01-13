require 'benchmark'
require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'tones')

n = 1_000_000

Benchmark.bm(10) do |x|
 x.report("gsub") { n.times do
     "This     is  a test   string.".gsub(/ +/, ' ')
   end
 }
 x.report("gsub!") { n.times do
     "This     is  a test   string.".gsub!(/ +/, ' ')
   end
 }
 x.report("split.join") { n.times do
     "This     is  a test   string.".split.join(' ')
   end
 }
end


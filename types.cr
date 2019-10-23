def shout(x)
  x.to_s.upcase
end

foo = ENV["FOO"]? || 10

puts typeof(foo) #=> (Int32 | String)
puts typeof(shout(foo)) #=> returns a string

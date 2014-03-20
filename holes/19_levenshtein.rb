def d(str1, str2)
  first, second = [str1, str2].map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
  n = first.size
  m = second.size
  return m if n.zero?
  return n if m.zero?

  ma = [(0..first.size).to_a]
  (1..second.size).each {|j| ma << [j] + [0] * (first.size) }

  (1..second.size).each { |i|
    (1..first.size).each { |j|
      ma[i][j] = first[j-1] == second[i-1] ? ma[i-1][j-1] : [ma[i-1][j],ma[i][j-1],ma[i-1][j-1],].min + 1
    }
  }
  return ma.last.last
end

while l = gets do
  a, b = l.split
  puts d a.to_s, b.to_s
end

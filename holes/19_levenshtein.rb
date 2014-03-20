def d(x, y, m = nil)
  m ? dwm(x, y, m) : dom(x, y)
end

def dwm(str1, str2, max)
  s, t = [str1, str2].sort_by(&:length).map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
  n = s.size
  m = t.size
  big_int = n * m
  return m if n.zero?
  return n if m.zero?
  return 0 if s == t

  return max if (n - m).abs >= max

  d = (m + 1).times.map { |i| i < m || i < max + 1 ? i : big_int }
  x,e = nil

  n.times do |i|
    e = e.nil? ? i + 1 : big_int

    diag_index = t.length - s.length + i

    min = (0..i-max-1).max
    max = [m - 1, i + max].min

    (min..max).each do |j|
      return max if j == diag_index && d[j] >= max

      cost = s[i] == t[j] ? 0 : 1
      x = [d[j+1] + 1,e + 1,d[j] + cost].min
      d[j] = e
      e = x
    end
    d[m] = x
  end

  x > max ? max : x
end

def dom(str1, str2)
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

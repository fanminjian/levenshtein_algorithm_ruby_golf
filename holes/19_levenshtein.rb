def d(x, y, m = nil)
  m ? dwm(x, y, m) : dom(x, y)
end

def dwm(str1, str2, max)
  s, t = [str1, str2].sort_by(&:length).map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
  n = s.length
  m = t.length
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

    (min .. max).each do |j|
      return max if j == diag_index && d[j] >= max

      cost = s[i] == t[j] ? 0 : 1
      x = [
        d[j+1] + 1, # insertion
        e + 1,      # deletion
        d[j] + cost # substitution
      ].min

      d[j] = e
      e = x
    end
    d[m] = x
  end

  return x > max ? max : x
end

def dom(str1, str2)
  first, second = [str1, str2].map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
  n = first.length
  m = second.length
  return m if n.zero?
  return n if m.zero?

  matrix = [(0..first.length).to_a]
  (1..second.length).each {|j| matrix << [j] + [0] * (first.length) }

  (1..second.length).each { |i|
    (1..first.length).each { |j|
      first[j-1] == second[i-1] ? matrix[i][j] = matrix[i-1][j-1] : matrix[i][j] = [matrix[i-1][j],matrix[i][j-1],matrix[i-1][j-1],].min + 1
    }
  }
  return matrix.last.last
end

while line = gets do
  a, b = line.split
  puts d a.to_s, b.to_s
end

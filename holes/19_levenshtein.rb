module Text
module Levenshtein
  def distance(str1, str2, max_distance = nil)
    if max_distance
      distance_with_maximum(str1, str2, max_distance)
    else
      distance_without_maximum(str1, str2)
    end
  end
private
  def distance_with_maximum(str1, str2, max_distance) # :nodoc:
    s, t = [str1, str2].sort_by(&:length).
                        map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
    n = s.length
    m = t.length
    big_int = n * m
    return m if n.zero?
    return n if m.zero?
    return 0 if s == t

    if (n - m).abs >= max_distance
      return max_distance
    end

    d = (m + 1).times.map { |i|
      if i < m || i < max_distance + 1
        i
      else
        big_int
      end
    }
    x = nil
    e = nil

    n.times do |i|
      if e.nil?
        e = i + 1
      else
        e = big_int
      end

      diag_index = t.length - s.length + i

      min = [0, i - max_distance - 1].max
      max = [m - 1, i + max_distance].min

      (min .. max).each do |j|
        if j == diag_index && d[j] >= max_distance
          return max_distance
        end

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

    if x > max_distance
      return max_distance
    else
      return x
    end
  end

  def distance_without_maximum(str1, str2) # :nodoc:
    first, second = [str1, str2].map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
    n = first.length
    m = second.length
    return m if n.zero?
    return n if m.zero?

    matrix = [(0..first.length).to_a]
    (1..second.length).each do |j|
      matrix << [j] + [0] * (first.length)
    end
 
    (1..second.length).each do |i|
      (1..first.length).each do |j|
        if first[j-1] == second[i-1]
          matrix[i][j] = matrix[i-1][j-1]
        else
          matrix[i][j] = [
            matrix[i-1][j],
            matrix[i][j-1],
            matrix[i-1][j-1],
          ].min + 1
        end
      end
    end
    return matrix.last.last
  end

  extend self
end
end

while line = gets do
  word1, word2 = line.split
  puts Text::Levenshtein.distance word1.to_s, word2.to_s
end

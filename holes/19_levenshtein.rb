def d(o,p)f,s=[o,p].map{|s|s.unpack("U*")};q=[(0..f.size).to_a];(1..s.size).map{|j|q<<[j]+[0]*(f.size)};(1..s.size).map{|i|(1..f.size).map{|j|q[i][j]=f[j-1]==s[i-1] ? q[i-1][j-1]:[q[i-1][j],q[i][j-1],q[i-1][j-1],].min+1}};q.last.last;end;$<.map{|l|a,b=l.split;p d a,b}
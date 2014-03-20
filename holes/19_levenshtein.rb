$<.map{|l|f,s=l.split
u=f.size
w=s.size
q=[(0..u).to_a]
1.upto(w){|j|q<<[j]}
1.upto(w){|i|1.upto(u){|j|q[i][j]=f[j-1]==s[i-1] ? q[i-1][j-1]:[q[i-1][j],q[i][j-1],q[i-1][j-1],].min+1}}
p q[w][u]
}
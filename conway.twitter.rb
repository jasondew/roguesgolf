n=(0..3);g=[!1]*4;b=[g,g,[!1]+[1]*3,g]
4.times{b=n.map{|x|n.map{|y|l=[x-1,x+1,x].product([y-1,y+1,y])[0..7].select{|f,g|(r=b[f])&&r[g]}.size
l==3||b[x][y]&&l==2}}
b.map{|r|puts r.map{|c|c ??#:?.}*""}}

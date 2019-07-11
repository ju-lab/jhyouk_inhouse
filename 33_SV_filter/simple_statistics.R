# simple statistical test script

a <- matrix(data = c(4,26,1,39),nrow = 2,byrow = F)
a
fisher.test(a)

prop.test(4,26,conf.level = 0.95, correct = F)
prop.test(73/35,,conf.level = 0.95, correct = F,alternative = )
?fisher.test
1/39
3/17


b<- matrix(data=c(2,75,0,40),nrow=2,byrow=F)
b
fisher.test(b)

chisq.test(b)
6/39
22/99
108/60
42/60
5/12
50*0.22
1/138
36/2784

install.packages("TailRank")
library(gmodels)

library(TailRank)
a<-c(rep(0,17),rep(2,17),16)
summary(a)
ci(a,confidence=0.9)

x<-seq(from=1,to=1000,by = 1)
x
y<- dbb(3,x,5,100)
cumy <- cumsum(y)
?dbb

plot(x,cumy)
cumy[250]

6.6*10^-12*4000*10^6*3

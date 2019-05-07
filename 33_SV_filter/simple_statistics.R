# simple statistical test script

a <- matrix(data = c(4,26,1,39),nrow = 2,byrow = F)
a
fisher.test(a)

prop.test(4,26,conf.level = 0.95, correct = F)
prop.test(1,39,conf.level = 0.95, correct = F)
1/39
3/17


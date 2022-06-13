#1
prop.test(c(705-450, 1320-517), c(705, 1320))
#2
prop.test(c(1000-24, 1000-34, 1000-22, 1000-42), rep(1000, 4))
# 3
 puNorm = function(k, n = 50, m = 100, s = 16){
     upper = c()
     lower = c()
     estimator = c()
     for(i in 1:n){
         smpl = rnorm(k, mean = m, sd = s)
         x = mean(smpl)
         y = qt(0.975, df = k - 1) * sd(smpl) / sqrt(k - 1)
         upper[i] = x + y
         lower[i] = x - y
         estimator[i] = x
     }
     plotCI(1:n, estimator, ui = upper, li = lower, las = 1, ylim = c(m - 3* s, m + 3 * s), xaxt = 'n')
     axis(side = 1, at = 1:50)
     abline(h = m, lty = 2, col = 'red')
 }

puNorm(9)
puNorm(15)
puNorm(30)
puNorm(90)

#4
pol = c(23.5, 25, 24, 27, 29, 22.5, 28, 30.5, 31)
ger = c(22, 24.5, 23.5, 28, 32, 30.5, 29.5)
usa = c(28, 26.5, 24, 25.5, 23.5, 29, 30.5, 26, 26, 32.5)
nor = c(25, 26.5, 30, 27, 24.5, 25, 23, 30, 29.5)

frame = data.frame(Time = c(pol, ger, usa, nor), Flags = c(rep('Pol', length(pol)), rep('Ger', length(ger)), rep('USA', length(usa)), rep('Nor', length(nor))))

qplot(Flags, Time, data = frame, geom = 'boxplot', fill = Flags)
analiza = aov(Time~Flags, data = frame)
summary(analiza)
# Pr(>F) = 0.982 - nie ma podstaw by odrzucic hipoteze

#5

p1 = c(24, 56, 34, 25, 42, 20, 68, 53, 34)
p2 = c(35, 76, 56, 44, 38, 25, 51, 36, 72, 29, 33)
p3 = c(40, 51, 63, 39, 54, 49, 50, 62)
p4 = c(50, 80, 38, 48, 58, 74, 75, 49, 83)
p5 = c(40, 80, 44, 75, 64, 65, 37, 61, 38, 47, 55, 29)

df = data.frame(Value = c(p1, p2, p3, p4, p5), Flags = c(rep('p1', length(p1)), rep('p2', length(p2)), rep('p3', length(p3)), rep('p4', length(p4)), rep('p5', length(p5))))
qplot(Flags, Value, data = df, geom = 'boxplot', fill = Flags)
analiza = aov(Value~Flags, data = df)
summary(analiza)

pairwise.t.test(df$Value, df$Flags, p.adjust.method = p.adjust.methods)

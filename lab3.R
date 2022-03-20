# Zad 7
tv = abs(round(rnorm(80, 4, 1.5)))
pc = round(rnorm(80, 6, 2))
# a)
pie(table(tv))
pie(table(pc))

# i)
f_tv = factor(tv)
# ii)
labels = levels(f_tv)
weights = as.vector(table(f_tv))
# iii)
percentage = weights / sum(weights) * 100
# iv)
labels = paste(labels, '___', percentage)
# v)
labels = paste(labels, '%', sep = '')

pie(weights, label = labels, col = rainbow(10), main = "Title")

# Zad 8 

roundToSeq200 = function(x)
{
    res = round(x + 50, -2)
    if(res %% 200 != 0){
        res = res + 100
    }
    return(res)
}

data(rivers)
print(rivers)
hist(rivers)

# a)
hist(rivers, 40)
# b)
#hist(rivers, breaks = seq(0, roundToSeq200(max(rivers)), by = 200))
hist(rivers, breaks = seq(0, roundToSeq200(max(rivers)), by = 200), yaxt = "n")

axis(2, at = seq(0, 100, by = 10))
abline(h = seq(0, 100, by = 5))

# Zad 9
plot(density(rivers))
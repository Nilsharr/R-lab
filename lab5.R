menHeight = c(1.93, 1.86, 1.92, 1.82, 1.80, 1.76, 1.89, 1.74, 1.92, 1.72, 1.81, 1.89, 1.81, 1.81, 1.84, 1.86, 1.84,
1.75, 1.86, 1.79)
menWeight = c(92, 76, 90, 76, 78, 73, 84, 70, 86, 68, 74, 76, 72, 81, 80, 80, 78, 75, 75, 75)

womanHeight = c(1.75, 1.79, 1.75, 1.78, 1.75, 1.69, 1.64, 1.78, 1.73, 1.79, 1.74, 1.71, 1.75, 161, 1.72, 1.71, 1.73, 1.64,
1.63, 1.58, 1.83, 1.70, 1.59, 1.59, 1.64)
womanWeight = c(73, 76, 70, 70, 63, 63, 59, 67, 60, 66, 60, 60, 64, 62, 62, 61, 63, 58, 60, 52, 68, 64, 55, 58, 59)

plot(menHeight, menWeight, type = 'p')
plot(womanHeight, womanWeight, type = 'o')

# Współczynnik korelacji to miara statystyczna mówiąca jak mocno wpływają na siebie 2 dane. 
# Im wyższy współczynnik korelacji, tym większe prawdopodobieństwo, że 2 różne wartości, które obserwujemy, będą się zachowywały podobnie.
# Współczynnik korelacji przyjmuje wartości od -1 (doskonała ujemna korelacja) poprzez 0 (całkowita niezależność danych) do 1 (doskonała dodatnia korelacja).

print(cor(menHeight, menWeight))
print(cor(womanHeight, womanWeight))

height = c(menHeight, womanHeight)
weight = c(menWeight, womanWeight)

plot(height, weight, type = 'p')
#plot(height, weight, type = 'h')
#plot(height, weight, type = 'o')
#plot(height, weight, type = 's')
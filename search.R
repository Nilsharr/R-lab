# O(n)
linearSearch = function(vector, value){
    for(x in vector){
        if(x == value){
            return (TRUE)
        }
    }
    return (FALSE)
}

# O(log n)
binarySearch = function(vector, value){
    left = 1
    right = length(vector)
    while(left <= right){
        middle = left + (right - left) %/% 2
        if(vector[middle] == value){
           return (TRUE) 
        }
        if(vector[middle] < value){
            left = middle + 1
        }
        else{
            right = middle - 1
        }
    }
    return (FALSE)
}

# benchmark
library(microbenchmark)

searchVectorSmall = sample(999, 100)
sortedSearchVectorSmall = sort(searchVectorSmall)
randomSearchValueSmall = sample(999, 1)
existingSearchValueSmall = searchVectorSmall[sample(100, 1)]

searchVectorBig = sample(99999, 10000)
sortedSearchVectorBig = sort(searchVectorBig)
randomSearchValueBig = sample(99999, 1)
existingSearchValueBig = searchVectorBig[sample(10000, 1)]

# running functions before benchmarks because they are (probably) cached, so the first benchmark doesn't take longer time than next one
linearSearch(searchVectorSmall, randomSearchValueSmall)
binarySearch(sortedSearchVectorSmall, randomSearchValueSmall)


cat ("Benchmarking linear and binary search with vector that contains 100 random numbers from 1 to 999 \n\n")

# searching for random value
cat("Random value, unsorted vector for linear search, sorted vector for binary search\n\n")
print(paste("Result = ", binarySearch(sortedSearchVectorSmall, randomSearchValueSmall)))
print(microbenchmark(linearSearch(searchVectorSmall, randomSearchValueSmall), 
    binarySearch(sortedSearchVectorSmall, randomSearchValueSmall), times = 1000, check = "equal"))

cat("\n\nRandom value, sorted vector for linear and binary search\n\n")
print(microbenchmark(linearSearch(sortedSearchVectorSmall, randomSearchValueSmall), 
    binarySearch(sortedSearchVectorSmall, randomSearchValueSmall), times = 1000, check = "equal"))

# searching for existing value
cat("\n\nExisting value, unsorted vector for linear search, sorted vector for binary search\n\n")
print(paste("Result = ", binarySearch(sortedSearchVectorSmall, existingSearchValueSmall)))
print(microbenchmark(linearSearch(searchVectorSmall, existingSearchValueSmall), 
    binarySearch(sortedSearchVectorSmall, existingSearchValueSmall), times = 1000, check = "equal"))

cat("\n\nExisting value, sorted vector for linear and binary search\n\n")
print(microbenchmark(linearSearch(sortedSearchVectorSmall, existingSearchValueSmall), 
    binarySearch(sortedSearchVectorSmall, existingSearchValueSmall), times = 1000, check = "equal"))

cat("\n\n---------------------------------------------------------------------------------------------------\n\n")
cat ("Benchmarking linear and binary search with vector that contains 10000 random numbers from 1 to 99999 \n\n")

# searching for random value
cat("Random value, unsorted vector for linear search, sorted vector for binary search\n\n")
print(paste("Result = ", binarySearch(sortedSearchVectorBig, randomSearchValueBig)))
print(microbenchmark(linearSearch(searchVectorBig, randomSearchValueBig), 
    binarySearch(sortedSearchVectorBig, randomSearchValueBig), times = 1000, check = "equal"))

cat("\n\nRandom value, sorted vector for linear and binary search\n\n")
print(microbenchmark(linearSearch(sortedSearchVectorBig, randomSearchValueBig), 
    binarySearch(sortedSearchVectorBig, randomSearchValueBig), times = 1000, check = "equal"))

# searching for existing value
cat("\n\nExisting value, unsorted vector for linear search, sorted vector for binary search\n\n")
print(paste("Result = ", binarySearch(sortedSearchVectorBig, existingSearchValueBig)))
print(microbenchmark(linearSearch(searchVectorBig, existingSearchValueBig), 
    binarySearch(sortedSearchVectorBig, existingSearchValueBig), times = 1000, check = "equal"))

cat("\n\nExisting value, sorted vector for linear and binary search\n\n")
print(microbenchmark(linearSearch(sortedSearchVectorBig, existingSearchValueBig), 
    binarySearch(sortedSearchVectorBig, existingSearchValueBig), times = 1000, check = "equal"))

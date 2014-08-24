## a pair of functions that cache the inverse of a matrix

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL # m stores the inverted matrix
  
  get <- function() x
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  setinverse <- function(inverse) m <<- inverse
  # getinverse returns the cached value of inverted matrix
  getinverse <- function() m
  
  # the returned object is a list of functions to access and set original and inverted matrices
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}




cacheSolve <- function(x, ...) {
  m <- x$getinverse() # attempts to access the cached value of the inverted matrix

  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }

  data <- x$get()
  m <- solve(data, ...) # solve function returns the inverted matrix (given square invertible matrix)
  x$setinverse(m) # stores the inverted matrix into the cache
  m
}

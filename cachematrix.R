## a pair of functions that cache the inverse of a matrix

## makeCacheMatrix creates a special "matrix" object that can cache its inverse.
## The object contains following functions:
## set: sets the value of the matrix
## get: gets the value of the matrix
## setinverse: sets the value of the interted matrix
## getinverse: gets the value of the inverted matrix

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL # m stores the inverted matrix
  
  # gets and sets original data matrix
  get <- function() x
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  # gets and sets inverted data matrix
  # setinverse stores the value of inverted matrix to the cache using supperassignment
  setinverse <- function(inverse) m <<- inverse
  # getinverse returns the cached value of inverted matrix
  getinverse <- function() m
  
  # the returned object is a list of functions to access and set original and inverted matrices
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}



## cacheSolve computes the inverse of the special "matrix" returned by makeCacheMatrix. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve should retrieve the inverse from the cache.
## argument x is assumed to be an invertible matrix
cacheSolve <- function(x, ...) {
  m <- x$getinverse() # attempts to access the cached value of the inverted matrix
  # checks to see if the inversion  has already been calculated
  # If so, get the inversion from the cache and skip the computation
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  # calculate the inversion of the matrix with the solve function
  # set the value of the inverted matrix in the cache via the setinverse function
  data <- x$get()
  m <- solve(data, ...) # solve function returns the inverted matrix (given square invertible matrix)
  x$setinverse(m) # stores the inverted matrix into the cache
  m
}

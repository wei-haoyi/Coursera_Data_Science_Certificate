## Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather than compute it repeatedly (there are also alternatives to matrix inversion that we will not discuss here).
## Your assignment is to write a pair of functions that cache the inverse of a matrix.

## makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  ie <- NULL
  set <- function(y) {
    x <<- y
    ie <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) ie <<- inverse
  getinverse <- function() ie
  list(set = set,
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

## cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  ie <- x$getinverse()
  if (!is.null(ie)) {
    message("getting cached data")
    return(ie)
  }
  data <- x$get()
  ie <- solve(data, ...)
  x$setinverse(ie)
  ie
}

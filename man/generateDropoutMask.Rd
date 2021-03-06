% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dropout.R
\name{generateDropoutMask}
\alias{generateDropoutMask}
\title{Generates the dropout mask for the deep neural network}
\usage{
generateDropoutMask(length, dropoutRate)
}
\arguments{
\item{length, }{the dimension of the layer}

\item{dropoutRate, }{the dropout rate}
}
\description{
This function generates the dropout mask for the deep neural network
}
\references{
Dropout: A Simple Way to Prevent Neural Networks from
 Overfitting, Nitish Srivastava
}
\seealso{
\url{https://www.cs.toronto.edu/~hinton/absps/JMLRdropout.pdf}
}


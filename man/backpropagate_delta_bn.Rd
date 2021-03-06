% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/backpropagate_delta.R
\name{backpropagate_delta_bn}
\alias{backpropagate_delta_bn}
\title{Calculates the delta functions using backpropagation}
\usage{
backpropagate_delta_bn(darch, trainData, targetData,
  errorFunc = meanSquareErr, with_BN = TRUE)
}
\arguments{
\item{darch}{a darch instance}

\item{trainData}{training input}

\item{targetData}{training target}

\item{errorFunc}{error function to minimize during training. Right now mean squared
erros and cross entropy errors are supported.}

\item{with_BN}{traing with batch normalization on or off}
}
\description{
function that calculates the delta function of a darch object with batch
normalization
}
\references{
Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift
 Sergey Ioffe, Christian Szegedy
}
\seealso{
\url{http://jmlr.org/proceedings/papers/v37/ioffe15.pdf} Pg 4
}


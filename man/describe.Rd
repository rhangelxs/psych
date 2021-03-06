\name{describe}
\alias{describe}
\alias{describeData}
\title{  Basic descriptive statistics useful for psychometrics }
\description{
There are many summary statistics available in R; this function
  provides the ones most useful for scale construction and item analysis in classic psychometrics. 
  Range is most useful for the first pass in a data set, to check for coding errors. 
}
\usage{
describe(x, na.rm = TRUE, interp=FALSE,skew = TRUE, ranges = TRUE,trim=.1,
type=3,check=TRUE,fast=NULL)
describeData(x,head=4,tail=4) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ A data frame or matrix}
  \item{na.rm}{The default is to delete missing data.  na.rm=FALSE will delete the case. }
  \item{interp}{Should the median be standard or interpolated}
  \item{skew}{ Should the skew and kurtosis be calculated? }
  \item{ranges}{ Should the range be calculated? }
  \item{trim}{trim=.1 -- trim means by dropping the top and bottom trim fraction}
  \item{type}{Which estimate of skew and kurtosis should be used?  (See details.) }
  \item{check}{Should we check for non-numeric variables?  Slower but helpful.}
  \item{fast}{if TRUE, will do n, means, sds, ranges for an improvement in speed.  If NULL, will switch to fast mode for large (ncol * nrow > 10^7) problems, otherwise defaults to fast = FALSE}
  \item{head}{show the first 1:head cases for each variable in describeData}
  \item{tail}{Show the last nobs-tail cases for each variable in describeData}
}
\details{In basic data analysis it is vital to get basic descriptive statistics. 
Procedures such as \code{\link{summary}} and hmisc::describe do so.  The describe function in the \code{\link{psych}} package is meant to produce the most frequently requested stats in psychometric and psychology studies, and to produce them in an easy to read data.frame. The results from describe can be used in graphics functions (e.g., \code{\link{error.crosses}}).

The range statistics (min, max, range) are most useful for data checking to detect coding errors, and should be found in early analyses of the data.  

Although describe will work on data frames as well as matrices, it is important to realize that for data frames, descriptive statistics will be reported only for those variables where this makes sense (i.e., not  for alphanumeric data). If the check option is TRUE, variables that are categorical or logical are converted to numeric and then described.  These variables are marked with an * in the row name.  This is somewhat slower. 

In a typical study, one might read the data in from the clipboard (\code{\link{read.clipboard}}), show the splom plot of the correlations (\code{\link{pairs.panels}}), and then describe the data. 

na.rm=FALSE is equivalent to describe(na.omit(x))  

When finding the skew and the kurtosis, there are three different options available.  These match the choices available in skewness and kurtosis found in the e1071 package (see Joanes and Gill (1998) for the advantages of each one). 

If we define \eqn{m_r = [\sum(X- mx)^r]/n}{m_r = [sum(X- mx)^r]/n} then 

Type 1 finds skewness and kurtosis by \eqn{g_1 = m_3/(m_2)^{3/2} } and \eqn{g_2 = m_4/(m_2)^2 -3}.  

Type 2 is \eqn{G1 = g1 * \sqrt{n *(n-1)}/(n-2)} and \eqn{G2 = (n-1)*[(n+1)g2 +6]/((n-2)(n-3))}.  

Type 3 is \eqn{b1 = [(n-1)/n]^{3/2} m_3/m_2^{3/2}} and \eqn{b2 =  [(n-1)/n]^{3/2} m_4/m_2^2)}.

The additional helper function \code{\link{describeData}} just scans the data array and reports on whether the data are all numerical, logical/factorial, or categorical.  This is a useful check to run if trying to get descriptive statistics on very large data sets where to improve the speed, the check option is FALSE.  

The fast=TRUE option will lead to a speed up of about 50\% for larger problems by not finding all of the statistics (see NOTE)

}
\value{
 A data.frame of the relevant statistics: \cr
   item name \cr
   item number \cr
   number of valid cases\cr
   mean\cr
   standard deviation\cr
   trimmed mean (with trim defaulting to .1) \cr
   median (standard or interpolated\cr
   mad: median absolute deviation (from the median) \cr
   minimum\cr
   maximum\cr
   skew\cr
   kurtosis\cr
   standard error\cr
}

\note{For very large data sets that are data.frames, describe can be rather slow. Converting the data to a matrix first is recommended.  However, if the data are of different types, (factors or logical), this is  not possible.  If the data set includes columns of character data, it is also not possible.  Thus, a quick pass with \code{\link{describeData}} is recommended.

For the greatest speed, at the cost of losing information, do not ask for ranges or for skew and turn off check.  This is done automatically if the fast option is TRUE or for large data sets. 

Note that by default, fast=NULL.  But if the number of cases x number of variables exceeds (ncol * nrow > 10^7), fast will be set to TRUE.  This will provide just n, mean, sd, min, max, range, and standard errors. To get all of the statistics (but at a cost of greater time) set fast=FALSE. 

The problem seems to be a memory limitation in that the time taken is an accelerating function of nvars * nobs.  Thus, for a largish problem (72,000 cases with 1680 variables) which might take 330 seconds, doing it as two sets of 840 variable cuts the time down to 80 seconds.   }
\author{ 
 
 \url{http://personality-project.org/revelle.html} \cr

Maintainer: William Revelle \email{revelle@northwestern.edu} \cr
}



\references{Joanes, D.N. and Gill, C.A (1998).  Comparing measures of sample skewness and kurtosis.  The Statistician, 47, 183-189.}

\seealso{ \code{\link{describe.by}}, \code{\link{skew}}, \code{\link{kurtosi}} \code{\link{interp.median}}, \code{\link{pairs.panels}}, \code{\link{read.clipboard}}, \code{\link{error.crosses}} }
\examples{
data(sat.act)
describe(sat.act)

describe(sat.act,skew=FALSE)
describeData(sat.act)
   






}
\keyword{ multivariate }% at least one, from doc/KEYWORDS
\keyword{ models }% __ONLY ONE__ keyword per line
\keyword{univar}

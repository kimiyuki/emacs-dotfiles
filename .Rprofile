### コピペで、理解してないものあり
#library(ggplot2)
#library(
#library(PerformanceAnalytics)
#library(RFinanceYJ)

options(stringsAsFactors=FALSE)
options("digits"=3)
options("width"=240)                # wide display with multiple monitors
options("max.print"=500)
options("digits.secs"=3)            # show sub-second time stamps
#LANGUAGE=en
#put something this is your .Rprofile to customize the defaults
# setHook(packageEvent("grDevices", "onLoad"),
#         function(...)
#         grDevices::X11.options(
#                                xpos=0, pointsize=8,
#                                fonts=c("-ipagothic-gothic-%s-%s-normal--%d-*-*-*-*-*-*-*","-adobe-symbol-medium-r-*-*-%d-*-*-*-*-*-*-*"),type="cairo"))
#other Cairo dev  type="nbcairo"))  # Cairo device
##                #type="xlib"))      # old default


setHook(packageEvent("grDevices", "onLoad"),
        function(...) grDevices::pdf.options(family="Japan1"))


## from the AER book by Zeileis and Kleiber
options(prompt="R> ", digits=4, show.signif.stars=FALSE)

##Sys.setlocale("LC_ALL","en_US.UTF-8")
##Sys.setlocale("LC_ALL","en_US.UTF-8")
## Sys.setlocale("LC_COLLATE","en_US.UTF-8")
## Sys.setlocale("LC_MESSAGES","en_US.UTF-8")
## Sys.setlocale("LC_PAPER","en_US.UTF-8")

s <- base::summary
h <- utils::head
ln <- length
n <- base::names
cd <- setwd
pwd <- getwd
lss <- dir
lv <- .Last.value

print(paste("hello",Sys.getenv("R_PLATFORM")))
.Last <- function(){
 if (!any(commandArgs()=="--no-readline") && interactive()){
   require(utils)
   try(savehistory(Sys.getenv("R_HISTORY")))
 }
}
##http://stackoverflow.com/questions/3485456/useful-little-functions-in-r
destring <- function(x) {
    ## convert factor to strings
    if (is.character(x)) {
        as.numeric(x)
    } else if (is.factor(x)) {
        as.numeric(levels(x))[x]
    } else if (is.numeric(x)) {
        x
    } else {
        stop("could not convert to numeric")
    }
}

setdiff2 <- function(x,y){
  Xdiff = setdiff(x,y)
  Ydiff = setdiff(y,x)
  list(X_not_in_Y = Xdiff, Y_not_in_X = Ydiff)
}
## print.data.frame <- function(x, ...) {
##     oWidth <- getOption("width")
##     oMaxPrint <- getOption("max.print")
##     on.exit(options(width=oWidth, max.print=oMaxPrint))
##     options(width=300, max.print=1000)
##     nc <- length(x)
##     rval <- vector("list", nc)
##     base::print.data.frame(x,right=F, row.names = F, ...)
##     colnames(x)
## }

format.factor <- function(x, ...){
  x <- unlist(lapply(as.character(x), toString, 16))
  format(structure(as.character(x), names = names(x), dim = dim(x),
                   dimnames = dimnames(x)), ...)
}

format.AsIs <- function (x, width = 12, ...){
    if (is.character(x)){
      x <- sapply(x,toString,width+4) #modified
      return(format.default(x, ...))
    }
    if (is.null(width))
        width = 12L
    n <- length(x)
    rvec <- rep.int(NA_character_, n)
    for (i in 1L:n) {
        y <- x[[i]]
        cl <- oldClass(y)
        if (m <- match("AsIs", cl, 0L))
            oldClass(y) <- cl[-m]
        rvec[i] <- toString(y, width = width, ...)
    }
    dim(rvec) <- dim(x)
    dimnames(rvec) <- dimnames(x)
    format.default(rvec, justify = "right")
}

.eval <- function(evaltext,envir=sys.frame()) {
  ## evaluate a string as R code
  eval(parse(text=evaltext), envir=envir)
}
trim <- function(s) gsub("^[[:space:]]+|[[:space:]]+$","",s)
pad0 <- function(x,mx=NULL,fill=0) {
  ## pad numeric vars to strings of specified size
  lx <- nchar(as.character(x))
  mx.calc <- max(lx,na.rm=TRUE)
  if (!is.null(mx)) {
    if (mx<mx.calc) {
      stop("number of maxchar is too small")
    }
  } else {
    mx <- mx.calc
  }
  px <- mx-lx
  paste(sapply(px,function(x) paste(rep(fill,x),collapse="")),x,sep="")
}

##for query
#my.color.hot <- col.regions=colorRampPalette(c("white", "red"))(256)
#sv <- save.image(file=".RData",version=NULL, ascii=FALSE, compress=FALSE,safe=TRUE)


order.t <- function(...)order(...,decreasing=T)

esort <- function(x, sortvar, ...) {
  attach(x)
  x <- x[with(x,order(sortvar,...)),]
  return(x)
  detach(x)
}
read.cb <- function(header=TRUE, ...) utils::read.table(file="clipboard", header=header, ...)

write.cb <- function(data, sep="\t", header=TRUE, row.names=FALSE,
        col.names=ifelse(header && row.names, NA, header), qmethod="double", ...)
    utils::write.table(data, file="clipboard", sep=sep, row.names=row.names,
        col.names=col.names, qmethod=qmethod, ...)



yahoo.ad.read <- function(path,fileEnc="UTF-8"){
  hk <- read.csv(path, skip=13, sep=",", fileEncoding=fileEnc, header=F,as.is=T)
  names(hk) <- c("adid","adname","title","dsc","durl","lurl","grp","cmp","type","qi","imp","ctr","clicks","cpc","as","cvr","cv","cpa","sales","roas","cost","pos")
  hk <- within(hk, rm(durl, lurl, type, ctr, cpc, cvr, cpa, sales, roas))
  hk <- transform(hk, pos.sum=imp*pos)
  ret <- ddply(hk, .(paste(cmp,grp)), transform, adnum=order(imp))[,-1]
  write.csv(file=sub(".csv", "out.csv",path), ret, row.names=F)
  ret  
}

google.ad.read <- function(path){
 hk <- read.csv(path, skip=2, sep="\t", fileEncoding="UTF-8", header=F,as.is=T)
 names(hk) <- c("kw","mtype","kstate","hatena","day","dv","astate","ad","dsc1","dsc2","durl","lurl","cmp","grp","status","clicks","imp","ctr","cpc","cost","pos","cv","cpa","cvr","vcv","adtype","adid")
 hk <- hk[, c("kw","mtype","kstate","day","dv","astate","ad","dsc1","dsc2","cmp","grp","status","clicks","imp","cost","pos","cv", "adid")]
# hk <- hk[-nrow(hk),]
 ddply(hk, .(paste(cmp,grp)), transform, adnum=order(imp))
}

.Last <- function(){
 if (!any(commandArgs()=="--no-readline") && interactive()){
   require(utils)
   try(savehistory(Sys.getenv("R_HISTORY")))
 }
}
#my.color.hot <- col.regions=colorRampPalette(c("white", "red"))(256) 
#sv <- save.image(file=".RData",version=NULL, ascii=FALSE, compress=FALSE,safe=TRUE)
qt <- RFinanceYJ::quoteStockXtsData

qt <- function(x){
  #rt <- RFinanceYJ::quoteStockXtsData(x)
  assign(paste("c",x,sep=""), RFinanceYJ::quoteStockXtsData(x), inherits=TRUE)
  cat(paste("c",x,"\n",sep=""))
}
my.ggplot <- function(...){
  ret <- do.call("cbind", list(...))
  ret <- melt(data.frame(date=index(ret),ret), id="date")
  ggplot(ret, aes(date, value, colour=variable)) +geom_line(size=1.2)
  #print(p)
  #p
}

#NAPM: New Orders, Production, Employment, Supplier Deliveries, Inventories, Customer's inventories, prices, backlog orders, exports, impots
NAPM.f <-
  c("NAPM", "NAPMNOI", "NAPMPI","NAPMEI","NAPMSDI","NAPMII", "NAPMCI", "NAPMII", "NAPMPRI", "NAPMBI", "NAPMEXI","NAPMIMP")

pop <- function(x){x[1:length(x)-1]}
shift <- function(x){x[2:length(x)]}

ret.by.30m <- function(code){
  lapply(1:10,function(n)mean(na.omit(Op(code)-Lag(Cl(code))[pop(endpoints(code, "days"))+n])))
}

last <- function(x){tail(x,n=1)}
my.Date <- function(x){
  x <- sub("jan","01",tolower(x))
  x <- sub("feb","02",tolower(x))
  x <- sub("mar","03",tolower(x))
  x <- sub("apr","04",tolower(x))
  x <- sub("may","05",tolower(x))
  x <- sub("jun","06",tolower(x))
  x <- sub("jul","07",tolower(x))
  x <- sub("aug","08",tolower(x))
  x <- sub("sep","09",tolower(x))
  x <- sub("oct","10",tolower(x))
  x <- sub("nov","11",tolower(x))
  x <- sub("dec","12",tolower(x))
  as.Date(x, "%d-%m-%y")
}


test0620 <- function(){
  #library(doMC)
  #library(compiler)
  require(doMC)
  registerDoMC(cores=4)
  foreach(j=1:10, .combine="c") %dopar% sum(m[,j])
}

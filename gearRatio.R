bestGearRatio <- function (m, maxDepth = 10, maxGear = 127, maxError = 0.1) 
{
    best      = list()
    bestCount = 0
    
    for( i in 1:maxDepth)
    {
        tmp = gearRatio(m,1,i) 

        gg = max(tmp$gears)
        
        if(!is.nan(gg))
            if(gg <= 127)
                if(abs(tmp$percentError) <= maxError)
                {
                    bestCount         = bestCount + 1
                    best[[bestCount]] = append(tmp,list(depth = i))         
                }
    }
    
    class(best) = "gearRatioList"
    best
}

gearRatio <- function (m, n = 1, depth = 20) 
{
    if(m>n)
    {
        top    = m
        bottom = n
    }
    else
    {
        top    = n
        bottom = m
    }
    
    goal         = top / bottom
    factorVec    = double(depth + 2)
    remainderVec = double(depth + 2)
    
    for( i in 1:(depth + 2))
    {
        factorVec[i]    = top%/%bottom
        remainderVec[i] = top%%bottom
        top             = bottom
        bottom          = remainderVec[i]
    }
    
    gearVec    = c(0, 1, rev(factorVec[1:depth]) )
    
    for( i in 2 + (1:depth))    
    {
        gearVec[i] = gearVec[i] * gearVec[i - 1] + gearVec[i - 2]
    }
    
    ratio = gearVec[depth + 2] / gearVec[depth + 1]
    
    tmp = list(
                gears        = c(gearVec[depth + 2], gearVec[depth + 1]), 
                ratio        = ratio, 
                goal         = goal,
                percentError = 100 * (ratio - goal) / goal
                )
    
    class(tmp) <- "gearRatio"
    tmp
}

print.gearRatio <- function (x, ...) 
{
    cat("\nGears  :  ", x$gears[1], ":", x$gears[2], "\n")
    cat("Ratio  :  ", format(x$ratio, digits = 4), "[", format(x$goal, digits = 4),"]\n")
    cat("Error  :  ",  paste(format(x$percentError,digits=3), "%",sep=""),"\n\n")
    invisible(x)
}

print.gearRatioList <- function (x, ...) 
{
    for(i in 1:length(x))
        print.gearRatio(x[[i]])
    invisible(x)
}

bore3P<-function(d1,d2,d3)
{
    r1 = d1/2
    r2 = d2/2
    r3 = d3/2
    
    rProd       = r1 * r2 * r3
    rSum        = r1 + r2 + r3
    sumOf2Prods = r1*r2 + r1*r3 + r3*r2
    
    2 * (rProd / (2 * sqrt(rProd * rSum)- sumOf2Prods ))   
}


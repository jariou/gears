bestGearRatio<-function (m, maxDepth, maxGear) 
{
    cat("\nNeed to implement to obtain the best ratio approximation with certain constraints\n")
}

gearRatio<-function (m, n = 1, depth = 20) 
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

print.gearRatio<-function (x, ...) 
{
    cat("\nGears  :  ", x$gears[1], ":", x$gears[2], "\n")
    cat("Ratio  :  ", format(x$ratio, digits=4), "\n")
    cat("Error  :  ",  format(x$goal, digits=4), " [", paste(format(x$percentError,digits=3), "%",sep=""),"]\n\n")
    invisible(x)
}

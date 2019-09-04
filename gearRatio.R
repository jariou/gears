function (m, n=1, depth = 20) 
{
    if(m>n)
    {
        top   = m
        bottom = n
    }
    else
    {
        top   = n
        bottom = m
    }
    goal       = top/bottom
    factors    = double(depth+2)
    remainders = double(depth+2)

    for( i in 1:(depth+2))
    {
        factors[i]    = top%/%bottom
        remainders[i] = top%%bottom
        top    = bottom
        bottom = remainders[i]
    }
    
    gears    = c(0, 1, rev(factors[1:depth]))

    for( i in 2+(1:depth))    
    {
        gears[i] = gears[i] * gears[i-1] + gears[i-2]
    }
    ratio = gears[depth+2]/gears[depth+1]
    
    list(
         gears = c(gears[depth+2],gears[depth+1]), 
         ratio = ratio, 
         goal  = goal,
         error = 100*(ratio - goal) / goal
         )
}

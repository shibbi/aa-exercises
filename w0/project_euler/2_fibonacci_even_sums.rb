#given a max number sum up all even fibonacci sequence terms that are less than that number
def fib(max)
    a, b, sum = 1, 2, 0 # first two terms and sum
    
    #run while second term is less than max
    while b < max
        sum+=b if (b%2==0) #add whenever second term is even
        a = a+b #make next term
        break if a>=max #if this term is greater than or equal to max break before summing
        sum+=a if (a%2==0) #add whenever next term is even
        b = a+b #make next term again
    end
    
    sum #return sum
end

fib(4000000)

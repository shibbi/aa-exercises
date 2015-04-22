#EXTREMELY INEFFICIENT :(

#given a max number find the largest prime factor
def l_prime(max)
    i = max-1 #counter
    
    #check all numbers less than max
    while i > 0
        #if max is divisible by i check if it's prime
        if (max%i==0)
            #if i is prime return i
            if is_prime?(i)
                return i
            #if i is a factor but not prime then use i as max
            else
               max = i
            end
        end
        i-=1
    end
    
    #return largest prime factor
    return i
end

#check if number is prime
def is_prime?(num)
    i = num-1
    
    #check all numbers until 2
    while i > 1
        #if num is divisible by any number it's not prime
        if (num%i==0)
            return false
        end
        i-=1 #decrement i
    end
    
    #if num is not divisible by everything between 1 and num return true
    return true
end

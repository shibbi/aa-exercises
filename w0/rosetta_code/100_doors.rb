#rosettacode.org/wiki/100_doors
#9/5/14, 3:40PM-3:50PM
def hundred_doors
	for i in (2..100)
		for j in (0..99).step(i)
			doors[j]*=-1
		end
	end
	puts "These doors are open:"
	for i in (0..doors.count-1)
    	puts i if doors[i] == 1
	end
end

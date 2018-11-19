/*
	Title :	The Ring Package Manager 
	Date  : 2018.11.19
	Author: Mahmoud Fayed <msfclipper@yahoo.com>
*/

func Search aKeywords 
	eval(read(C_REGISTRYFILE))
	# Now we have aPackagesRegistry
	# Ring can do 1000 search operation in 100,000 (Worst case - last item) < 1 second 
	lFound = False 
	for aPackage in aPackagesRegistry 
		for aKeyword in aKeywords 
			if substr(aPackage[:name],aKeyword) or 
			   substr(aPackage[:description],aKeyword)
			   see "Package : " Style(aPackage[:name],:YellowBlack) 
			   ? " (" + aPackage[:description] + ")"
			   lFound = True 
			   loop 2
			ok
		next 
	next 
	if lFound = False 
		? "Not found!"
	ok

*! ado meanpv v.0.1

program define meanpv , eclass

	version 16
	
    syntax                 ///
        ,                          ///
        var1(string)              ///
        var2(string)  				///
		wtg(string)
 
 
	tempname b V
 
	if ("`var1'" != "") {
		mean `var1' [`wtg']
		mat eb1 = e(b) 
		mat eV1 = e(V)
	}
		
	if ("`var2'" != "") {
		mean `var2' [`wtg']
		mat eb2 = e(b) 
		mat eV2 = e(V)
	}

	mat eV1 = eV1	,	0
	mat eV2 = 0		,	eV2
	
	mat `b' = eb1 , eb2
	mat `V' = eV1 \ eV2
	
	mat colnames `b' = "var1" "var2" 
	mat colnames `V' = "var1" "var2" 
	mat rownames `V' = "var1" "var2" 
	
	ereturn post `b' `V' 
	
end 


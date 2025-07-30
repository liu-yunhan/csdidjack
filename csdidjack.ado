*! csdid_jack 0.3 10 Jul 2025 — Cluster jackknife (CV3) for Callaway–Sant'Anna DID
*  After running  csdid … , call:
*      csdid_jack [, cluster(varname) level(#)]
*  Returns r(atts), and r(table):
*      cv3se  cv3t  cv3p  cv3lci  cv3uci  cv3df  cv3crit

cap program drop csdidjack
program define csdidjack, sortpreserve rclass

    *--- 0. checks ---------------------------------------------------------
    if "`e(cmd)'" != "csdid" {
        di as err "{bf:csdidjack} must follow {bf:csdid}"
        exit 301
    }
    if !inlist("`e(agg)'", "simple", "group", "calendar") {
        di as err "must have simple, group, or calendar aggregation"
        exit 301
    }

    *--- 1. options --------------------------------------------------------
    local defclust `e(clustvar)'
    syntax [, cluster(varname) level(real 95)]
    tempname orig
    qui estimates store `orig'
    if "`cluster'"=="" local cluster "`defclust'"
    if "`cluster'" == "" {
		di as err "likely cluster() option missing — specify it in csdid or csdidjack"
		error 198
	}
    if "`level'"==""  local level 95
    scalar _level = `level'

    *--- 2. baseline -------------------------------------------------------
	global ATT = r(table)[1,1]
    local cmdline `"`e(cmdline)'"'
    gettoken cmdleft cmdright : cmdline, parse(",")

    preserve
        collapse (sum) `e(ggroup)', by(`cluster')
        qui count
        local g = r(N)
        qui count if `e(ggroup)' != 0
        local treated = r(N)
    restore
    local singclust = (`treated' < 2)
    noi di "Clusters: `g'"
	noi di "Treated: `treated'"
	if (`singclust' == 1) di as error "Skipping subsample with no treated clusters"

    *--- 3. jackknife ------------------------------------------------------
    quietly levelsof `cluster', local(_clist)
    local reps = `g' - `singclust'
    mata: df = `g' - 1 - `singclust'
    mata: atts = J(`reps',1,.)
    local sole ""
    qui if `singclust' levelsof `cluster' if `e(ggroup)'!=0, local(sole)

    local j = 0
    foreach _c of local _clist {
        if "`_c'"=="`sole'" continue
        local j = `j' + 1
        noi di ".", _continue
        qui `cmdleft' if `cluster' != `_c' `cmdright'
        local _att = r(table)[1,1]
		mata: atts[`j',1] = `_att'
    }

    *--- 4. Mata stats -----------------------------------------------------
	mata:	square = (atts:-$ATT):*(atts:-$ATT)
	mata: 	sumsquare = sum(square)
	mata: 	sumsquare = df/`reps' * sumsquare
    mata:   se  = sqrt(sumsquare)
    mata:   t   = $ATT / se
	mata: 	level  = st_numscalar("_level")
	mata: 	lvl = (1-level/100)/2
	mata: 	tail = ttail(df,t)
	
	mata: 	p    = 2*min((tail, 1-tail))
	mata: 	crit = invttail(df, lvl)
	mata: 	lci  = $ATT - crit * se
	mata: 	uci  = $ATT + crit * se
		
    mata:	st_numscalar("cv3se",se)
    mata:   st_numscalar("cv3t",t)
    mata:   st_numscalar("cv3p",p)
    mata:   st_numscalar("cv3lci",lci)
    mata:   st_numscalar("cv3uci",uci)
    mata:   st_numscalar("cv3df",df)
    mata:   st_numscalar("cv3crit",crit)
	mata:   st_matrix("atts", atts)

    *--- 5. return ---------------------------------------------------------
    return matrix atts = atts
	matrix res = ($ATT, cv3se, cv3t, cv3p, cv3lci, cv3uci)
    matrix colnames res = "ATT" "Std. Err." "t-stat" "P>|t|" "CI-lower" "CI-upper"
    matrix rownames res = "CV3J"
    di ""
    matlist res, title("Cluster Jackknife for csdid")
	
    matrix rtab = ($ATT \ cv3se \ cv3t \ cv3p \ cv3lci \ cv3uci \ cv3df \ cv3crit \ 0)
    matrix rownames rtab = b se t pvalue ll ul df crit eform
    matrix colnames rtab = ATT_CV3J
	return matrix table = rtab
	
	return sca ATT = $ATT
	return sca cv3se = cv3se
	return sca cv3t = cv3t
	return sca cv3p = cv3p
	return sca cv3lci = cv3lci
	return sca cv3uci = cv3uci
	
    qui estimates restore `orig'
end

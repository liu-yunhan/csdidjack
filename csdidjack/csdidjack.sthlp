{smcl}
{* *! version 0.2.0  10Jul2025}

{title:csdidjack}

{p 4 4 2}
{bf:csdidjack} — Cluster jackknife (CV3) inference after {bf:csdid}

{title:Syntax}

{p 8 8 2}
{cmd:csdidjack} [{cmd:,} {it:cluster(varname)} {opt level(#)}]

{synoptset 16 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt cluster(varname)}}cluster variable used in the preceding {cmd:csdid}; defaults to {cmd:e(cluster)}{p_end}
{synopt:{opt level(#)}}confidence level for the CV3 interval; default {cmd:level(95)}{p_end}
{synoptline}

{title:Description}

{pstd}
{cmd:csdidjack} implements the cluster jackknife (CV3) variance estimator for the
Callaway–Sant’Anna Difference‑in‑Differences estimator produced by {cmd:csdid}.  
It provides finite‑sample adjusted inference that is robust to few clusters and
heterogeneous treatment timing.  Run it immediately after a successful
{cmd:csdid} estimation.

{title:Stored results}

{pstd}{bf:r(table)} (1 × 8) with elements  
{bf:b  cv3se  cv3t  cv3p  cv3lci  cv3uci  cv3df  cv3crit}

{col 8}{bf:r()} scalars
{col 12}{bf:ATT}      average treatment effect
{col 12}{bf:cv3se}    CV3 standard error
{col 12}{bf:cv3t}     t‑statistic
{col 12}{bf:cv3p}     p‑value
{col 12}{bf:cv3df}    degrees of freedom
{col 12}{bf:cv3crit}  critical value at specified level

{title:Example}

{phang2}{cmd:. csdid y, ivar(id) time(t) group(g) cluster(state)}
{phang2}{cmd:. csdidjack}

{title:Author}

{pstd}Yunhan Liu  
{pstd}{browse "mailto:max.yunhan.liu@gmail.com":max.yunhan.liu@gmail.com}

{title:Version}

{pstd}0.2.0  10 Jul 2025

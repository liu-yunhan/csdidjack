{smcl}
{* *! version 0.2.0  10Jul2025}

{title:csdidjack}

{p 4 4 2}
{bf:csdidjack} — Cluster jackknife (CV3) inference for {bf:csdid}

{title:Syntax}

{p 8 8 2}
{cmd:csdidjack}{cmd: [,} {opt cluster(varname)} {opt level(#)}{cmd:]}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt cluster(varname)}}cluster variable used; defaults to {cmd:e(cluster)}{p_end}
{synopt:{opt level(#)}}confidence level for the interval; defaults to {cmd:95}{p_end}
{synoptline}

{title:Description}

{pstd}
{cmd:csdidjack} implements the cluster jackknife (CV3) variance estimator for the
Callaway–Sant’Anna Difference-in-Differences estimator produced by {cmd:csdid}.  
It provides finite-sample adjusted inference that is robust to few clusters and
heterogeneous treatment timing.  {break}

{pstd}**A cluster variable must be supplied either in the original {cmd:csdid} call or via the {opt cluster()} option here. {break} Currently supports only the aggregation schemes {cmd:agg(simple)}, {cmd:agg(group)}, and {cmd:agg(calendar)} **  {break}

{pstd}Run immediately after a successful {cmd:csdid} estimation.



{title:Stored results}

{p2colset 7 30 32 2}
{pstd}{it:Matrices:}{p_end}{break}
{p2col:{bf:r(table)}}Column vector with estimation results{p_end}
{p2col:{bf:r(atts)}}All ATTs from the leave-one-out procedure{p_end}

{pstd}{it:Scalars:}{p_end}{break}
{p2col:{bf:r(ATT)}}Coefficient result (from csdid){p_end}
{p2col:{bf:r(cv3se)}}Cluster-jackknife standard error{p_end}
{p2col:{bf:r(cv3t)}}t-statistic{p_end}
{p2col:{bf:r(cv3p)}}p-value{p_end}
{p2col:{bf:r(cv3lci)}}Lower bound{p_end}
{p2col:{bf:r(cv3uci)}}Upper bound{p_end}
{p2colreset}

{title:Example}

{phang}{cmd:csdid wage, time(year) gvar(first_treat) cluster(state) agg(group)}{p_end}
{phang}{cmd:csdidjack}{p_end}

{marker authors}{...}
{title:Authors}

{pstd}
Yunhan Liu: {browse "mailto:max.yunhan.liu@gmail.com":max.yunhan.liu@gmail.com}{p_end}

{title:Also see}

{pstd}
Help:  {help csdid}, {help csdid postestimation}{p_end}


# csdidjack
Cluster jackknife (CV3) inference for the Callaway-Sant'Anna DID estimator  <br>
This is a post-estimation program for [csdid (Fernando Rios-Avila)](https://friosavila.github.io/playingwithstata/main_csdid.html)

## Update
Now also supports `hdidregress` post-estimation, but only after `estat aggregation, overall` with `weights(cohort)` or `weights(timecohort)`, because `csdidjack` runs CV3 on the single aggregated average.

## Installation 
install (or update) using the following command

```stata
net install csdidjack, from("https://raw.githubusercontent.com/liu-yunhan/csdidjack/main/") replace
```
or try
```stata
ado update csdidjack, update
```

## Supported options
| `csdid` | `hdidregress` + `estat aggregation, overall` |
|---|---|
| `agg(simple)` | `weights(timecohort)` |
| `agg(group)` | `weights(cohort)` |
| `agg(calendar)` |  |
* the weights() option is availible in Stata 19 only

## Documentation 
```stata
help csdidjack
```

## Optional

#### Removal 
```stata
ado uninstall csdidjack
```
#### Install to a custom directory
```stata
sysdir set PLUS …
```
#### Add ado directory
```stata
adopath ++ …
```

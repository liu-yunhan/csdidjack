# csdidjack
Cluster jackknife (CV3) inference for the Callaway–Sant’Anna DID estimator  <br>
This is a post-estimation program for [csdid (Fernando Rios-Avila)](https://friosavila.github.io/playingwithstata/main_csdid.html)

## Installation 
install (or update) using the following command

```stata
net install csdidjack, from("https://raw.githubusercontent.com/liu-yunhan/csdidjack/main/") replace
```

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

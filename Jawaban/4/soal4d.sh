#!/bin/bash
read NOW
len=${#NOW}
len=$((len-2))
NOW=${NOW:1:$len}
key=${NOW:0:2}
key=$(($key+0))

temp1=( {a..z} )
cipher1=()
cipher1+=( ${temp1[@]:(-(26-$key))} )
cipher1+=( ${temp1[@]:0:$(($key))} )
temp2=( {A..Z} )
cipher2=()
cipher2+=( ${temp2[@]:(-(26-$key))} )
cipher2+=( ${temp2[@]:0:$(($key))} )
temp1+=( ${temp2[@]} )
cipher1+=( ${cipher2[@]} )
tr "${cipher1[*]}" "${temp1[*]}" <"$NOW"> "$NOW".decrypted

#!/bin/bash
key=`date +"%H"`
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
NOW=$(date +"%H:%M %d-%m-%Y")
< /var/log/syslog > "$NOW" tr "${temp1[*]}" "${cipher1[*]}"

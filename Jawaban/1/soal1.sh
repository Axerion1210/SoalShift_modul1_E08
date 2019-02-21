#!/bin/bash

unzip /home/siung2/Documents/soalshift1/1/nature.zip -d /home/siung2/Documents/soalshift1/1/
a=0
for photo in /home/siung2/Documents/soalshift1/1/nature/*.jpg
do
	`base64 -d $photo > /home/siung2/Documents/soalshift1/1/nature/$a.jpg`
	`xxd -r /home/siung2/Documents/soalshift1/1/nature/$a.jpg > /home/siung2/Documents/soalshift1/1/nature/hasil$a.jpg`
	`rm /home/siung2/Documents/soalshift1/1/nature/$a.jpg $photo`
	a=$(($a+1))
done

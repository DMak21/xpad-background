#!/bin/bash

min_number() {
    printf "%s\n" "$@" | sort -g | head -n1
}
max_number() {
    printf "%s\n" "$@" | sort -rn | head -1
}
cd ~/.config/xpad
killall xpad
xprop -root | grep _GNOME_BACKGROUND_REPRESENTATIVE_COLORS > new
xprop -root | grep _GNOME_BACKGROUND_REPRESENTATIVE_COLORS > new2
sed -i 's/(/ /g' new2
sed -i 's/)/ /g' new2
sed -i 's/,/ /g' new2
r=$(awk {'print $5'} new2)
g=$(awk {'print $6'} new2)
b=$(awk {'print $7'} new2)

min="$(min_number $r $g $b)"
max="$(max_number $r $g $b)"
sum="$(($min+$max))"

lum=$(echo $sum/510 | bc -l)

#PART 2
if (( $(bc <<< "$lum < 0.5") ))
then
  echo "text rgb(255,255,255)" > newu

else
  echo "text rgb(0,0,0)" > newu

fi

sed -i 's/_GNOME_BACKGROUND_REPRESENTATIVE_COLORS(STRING)/back/g' new
sed -i 's/"//g' new
sed -i 's/= //g' new
rm default-style
cat newu new final > default-style
xpad

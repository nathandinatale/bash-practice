#!/bin/bash

total_args=$#

for var in "$@"
do

response=$(curl -s https://restcountries.com/v2/name/${var})

name=$(echo ${response} | jq '.[] | .name' | tr -d "\"")
echo "Name: ${name}"

capital=$(echo ${response} | jq '.[] | .capital' | tr -d "\"")
echo "Capital: ${capital}"

population=$(echo ${response} | jq '.[] | .population' | tr -d "\"")
echo "Population: ${population}"

languages=$(echo ${response} | jq '.[] | .languages | .[].name' | tr -d "\"")

lang_string=""
for language in  ${languages}; do
lang_string="${lang_string}${language}, " 
done

lang_string=${lang_string%, }
echo "Languages: ${lang_string}"

printf "\n"

done



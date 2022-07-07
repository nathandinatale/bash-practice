#!/bin/bash

total_args=$#

function extract_property(){
  local property=${1}
  local res=${2}
  local result=$(echo $res | jq ".[] | .\"$property\"" | tr -d "\"")
  echo "${property^}: ${result}"
}

attributes=("name" "population" "capital")

for var in "$@"
do
  response=$(curl -s https://restcountries.com/v2/name/${var})

  for attr in ${attributes[@]}; do 
    country_attribute=$(extract_property "${attr}" "${response}")
    echo ${country_attribute}
  done

  languages=$(echo ${response} | jq '.[] | .languages | .[].name' | tr -d "\"")
  lang_string=""
  for language in  ${languages}; do
    lang_string="${lang_string}${language}, "
  done

  lang_string=${lang_string%, }
  echo "Languages: ${lang_string}"

  printf "\n"
done




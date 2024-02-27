#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -t -c"
#Refactor
#Chore
#Test
PRINT() {
if [[ -z $ELEMENT ]]
  then
    echo -e "I could not find that element in the database."
  else
  echo "$ELEMENT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
fi
}

if [[ -z $1 ]]
then
  echo -e 'Please provide an element as an argument.'
elif [[ $1 =~ [0-9]+ ]]
  then
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1;")
    PRINT
elif [[ $1 =~ [a-zA-Z]+ ]]
  then
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1' OR symbol='$1';")
    PRINT
fi 



#!/bin/bash
#check if the augument is passed
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
 
if [[ $1 ]]
then
  #check if the augument is numaric
  length_of_argument=$(echo -n $1 | wc -m)
  if [[ $1 =~ (^[0-9]+)$ ]]
  then
    ELEMENTS_PROPERTIES=$($PSQL "select e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type  from elements as e inner join properties as p on e.atomic_number=p.atomic_number left join types as t on t.type_id = p.type_id where e.atomic_number=$1;")
    if [[ $ELEMENTS_PROPERTIES ]]
    then
      echo "$ELEMENTS_PROPERTIES" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE BAR
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  elif [[ $1 =~ ^[A-Z] && $length_of_argument -le 2 ]]
  then
    ELEMENTS_PROPERTIES=$($PSQL "select e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type  from elements as e inner join properties as p on e.atomic_number=p.atomic_number left join types as t on t.type_id = p.type_id where e.symbol='$1';")
    if [[ $ELEMENTS_PROPERTIES ]]
    then
      echo "$ELEMENTS_PROPERTIES" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE BAR 
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  elif [[ $1 =~ ^[A-Z] && $length_of_argument -gt 2 ]]
  then
    ELEMENTS_PROPERTIES=$($PSQL "select e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type  from elements as e inner join properties as p on e.atomic_number=p.atomic_number left join types as t on t.type_id = p.type_id where e.name='$1';")
    if [[ $ELEMENTS_PROPERTIES ]]
    then
      echo "$ELEMENTS_PROPERTIES" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE BAR 
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  else
    echo "I could not find that element in the database."
  fi
else
  echo "Please provide an element as an argument."
fi

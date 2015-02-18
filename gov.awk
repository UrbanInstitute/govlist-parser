#!/bin/awk

#
# parse names, affiliation, and date
# out of governor list
#

BEGIN {
  FS = "\t";
  print "name, party, state, date1, date2"
  lag[1]=none
  lag[2]=none
}

{
  # if we see this phrase, the string two
  # periods back is the state
  if ($1 ~ /Became a state/ ) {
    state=lag[2]
  }

  # keep track of two lines back
  lag[2]=lag[1]
  lag[1]=$1

  gsub("\"","");
  gsub(",","");
  if ($1 ~ /^\w.*\(.+\)/) {
    v=gensub(/[^(a-zA-Z+)]/, "", "g", $1)
    split(gensub(/[()]/,"|","g", v), a, "|")
    split($1, name, "(")
    if (!($2 == "") && (name[1] != "")) {
      print name[1] "," a[2] "," state "," $2 "," $3
    }

  }
}

BEGIN {
        printf "{ \"body\": \"# <img src=\\\"https://www.shiftleft.io/static/images/ShiftLeft_logo_dark_2021.svg\\\" alt=\\\"ShiftLeft\\\" width=\\\"150\\\"/><p>NG-SAST Analysis Compliance Failure\\n\\n" ;
        RS = "\n";
        FS = " ";
        APPL = "nothing";
}

/^Using application/ {
        gsub(/`/, "", $3);
        APPL=$3;
}

/New matching finding ID/ {
  printf "* [ID %s](https://shiftleft.io/findingDetail/%s/%s) %s", $5, APPL, $5, $6 ;
  FS = ":";
  $0 = $0;
}

/New matching finding ID/ {
  printf "%s: %s\\n", $2, $3 ;
  FS = " ";
  $0 = $0;
}

END {
  print "\" }"
}

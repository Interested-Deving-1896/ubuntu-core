#! /bin/sh

GRADE=$1
INPUT=$2
OUTPUT=$3

UBUNTU_ID=`snapcraft whoami | grep '^id:' | awk '{print $2;}'`
TIMESTAMP=`date -Iseconds --utc`
JQ_SCRIPT="
  .[\"authority-id\"] = \"$UBUNTU_ID\" | 
  .[\"brand-id\"] = \"$UBUNTU_ID\" |
  .[\"grade\"] = \"$GRADE\" |
  .[\"display-name\"] = (.[\"display-name\"] + \", $GRADE\") |
  .[\"timestamp\"] = \"$TIMESTAMP\""

cat $INPUT | jq "$JQ_SCRIPT" > $OUTPUT


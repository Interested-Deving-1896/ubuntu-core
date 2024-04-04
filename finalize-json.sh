#! /bin/sh

GRADE=$1
INPUT=$2
OUTPUT=$3

UBUNTU_ID=`snapcraft whoami | grep '^id:' | awk '{print $2;}'`
ACCOUNT_VALIDATION=`snap known --remote account account-id=$UBUNTU_ID | grep '^validation:' | awk '{print $2;}'`
TIMESTAMP=`date -Iseconds --utc`

AUTHORITY_ID="canonical"
if [ $ACCOUNT_VALIDATION = "verified" ]; then
  AUTHORITY_ID=$UBUNTU_ID
fi

JQ_SCRIPT="
  .[\"authority-id\"] = \"$AUTHORITY_ID\" |
  .[\"brand-id\"] = \"$UBUNTU_ID\" |
  .[\"grade\"] = \"$GRADE\" |
  .[\"display-name\"] = (.[\"display-name\"] + \", $GRADE\") |
  .[\"timestamp\"] = \"$TIMESTAMP\""

cat $INPUT | jq "$JQ_SCRIPT" > $OUTPUT


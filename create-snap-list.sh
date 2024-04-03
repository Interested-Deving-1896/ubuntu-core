#! /bin/sh

GRADE=$1
INPUT=$2
OUTPUT=$3

JQ_SCRIPT="
  .snaps[] |
  select(.presence == \"optional\") |
  .name"

cat $INPUT | jq "$JQ_SCRIPT" > $OUTPUT

if [ $GRADE = "dangerous" ]; then
  find ./local-snaps -name '*.snap' >> $OUTPUT
fi


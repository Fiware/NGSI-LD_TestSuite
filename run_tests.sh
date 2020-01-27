#!/bin/bash

ACC_ENDPOINT=${ACC_ENDPOINT:-http://localhost:8080}
NOTIFY_ENDPOINT=${NOTIFY_ENDPOINT:-http://accumulator:8080/acc}
#NOTIFY_ENDPOINT=${NOTIFY_ENDPOINT:-http://host.docker.internal:8080/acc}

echo "The Accumulator endpoint listens on $ACC_ENDPOINT"
echo "Subscriptions will notify the accumulator using $NOTIFY_ENDPOINT"

# To run an accumulator locally run:
#
# export WEB_APP_PORT=8080
# node accumulator/accumulator.js

while [ `curl -s -o /dev/null -w %{http_code} $ACC_ENDPOINT` -eq 000 ]
do 
  echo -e "Accumulator HTTP state: " `curl -s -o /dev/null -w %{http_code} $ACC_ENDPOINT` " (waiting for 200)"
  sleep 1
done


TEST_ENDPOINT=${TEST_ENDPOINT:-http://localhost:1026}
echo "NGSI-LD Broker endpoint ... at $TEST_ENDPOINT"

while [ `curl -s -o /dev/null -w %{http_code} $TEST_ENDPOINT` -eq 000 ]
do 
  echo -e "Context Broker HTTP state: " `curl -s -o /dev/null -w %{http_code} $TEST_ENDPOINT` " (waiting for 200)"
  sleep 1
done

jest  --runInBand --verbose 
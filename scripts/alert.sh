#!/bin/bash

WEBHOOK_URL="YOUR_DIWSCORD_WEBHOOK_URL"
LAST_ALERT_FILE="/tmp/last_alert"
LAST_TIME_FILE="/tmp/last_time"
ELASTIC_URL="http://localhost:9200"

RESULT=$(curl -s "http://localhost:9200/filebeat-*/_serach?q=suricata.eve.alert.signature:*&sort=@timestamp:desc&size=1")

if echo "$RESULT" | grep -q '"value":[1-9]'; then
    SRC_IP=$(echo "$RESULT" | jq -r '.hits.hits[0]._source.source.ip')
    DEST_IP=$(echo "$RESULT" | jq -r '.hits.hits[0]._source.destination.ip')
    ATTACK=$(echo "$RESULT" | jq -r '.hits.hits[0]._source.suricata.eve.alert.signature')

    [ -z "$SRC_IP" ] && SRC_IP="unknown"
    [ -z "$DEST_IP" ] && DEST_IP="unknown"
    [ -z "$ATTACK" ] && ATTACK="unknown"

    DATA=$(cat <<EOF)
{
    "embeds":  [
        {
          "title":"Intrusion Detected!!!",
          "color": 16711680,
          "fields":  [
            {"name": "Source IP", "value": "$SRC_IP", "inline": true},
            {"name": "Destination IP", "value": "$DEST_IP", "inline": true},
            {"name": "Attack Type", "value": "$ATTACK", "inline": false}
          ],
          "foter": {"text": "Suricata IDS Alert"}
        }
    ]
}
EOF

TIEMSTAMP=$(date +%s)
CURRENT_ALERT="$SRC_IP-$DEST_IP-$ATTACK"

    if [ -f $LAST_ALERT_FILE ] && [ -f $LAST_TIME_FILE ]; then
        LAST_ALERT=$(cat $LAST_ALERT_FILE)
        LAST_TIME=$(cat $LAST_TIME_FILE)

        DIFF=$((CURRENT_TIME - LAST_TIME))

        if [ "$CURRENT_ALERT" == ""$LAST_ALERT ] && [$DIFF -lt 60 ]; then
          exit 0
        fi
    fi

    curl -H "Content-Type: application/json" -d "$DATA" "$WEBHOOK"

    echo "$CURRENT_ALERT" > $LAST_ALERT_FILE
    echo "$CURRENT_TIME" > $LAST_TIME_FILE
fi

# Real-Time Intrusion Detection and Threat Monitoring using Suricata, Elastic Stack, and Discord Alert
This repository is my University project about making a Real-time intrusion detection and threat monitoring using Suricata, Elastic Stack, and Discord alert.

---

## Overview
This project demonstrates a Security Information and Event Management (SIEM) implementation using:
- Suricata IDS for real-time intrusion detection
- Elastic Stack (Elasticsearch, Logstash, Kibana) for log analysis and visualization
- Filebeat for log shipping
- Discord Webhook for real-time alert notification
The system detects network attacks and instantly sends alerts to Discord, improving response time and visibility.

---

## Objectives
- Detect malicious network activity in real-time
- Centralize logs using Elastic Stack
- Visualize threats using Kibana dashboards
- Send automated alerts via Discord
- Simulate attacks for testing detection capability

---

## Tools and Technologies
- Suricata IDS
- Elasticsearch
- Logstash
- Kibana
- Filebeat
- Discord Webhook
- Kali Linux
- Gobuster
- Nmap
- hping3

---

## Installation and Configuration
1. Install and Configure Elasticsearch

Install Elasticsearch with:
```
sudo apt update
sudo apt install elasticsearch -y
```

Enable and start Elasticsearch service with:
```
sudo systemctl enable elasticsearch 
sudo systemctl start elasticsearch
```

We can check the service status with:

```
sudo systemctl status elasticsearch
```

Reset the elatic account password with:

```
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
```

we can save this password, because it will later be used for Kibana login.

2. Install and Configure Kibana
Install Kibana with:
```
sudo apt install kibana -y
```

Enable and start Kibana service with:
```
sudo systmctl enable kibana
sudo systemctl start kibana
```

Generate Enrollment Token for Kibana login with:
```
sudo /usr/share/elasticsearch/bin/elasticsearch/
```

we can access the Kibana dashboard with:
```http://localhost:5601```

- Paste token from earlier
- Login with:
  - Username: ```elastic```
  - Pasword: the one we generate from earlier

3. Inatall and Configure Suricata
Install Suricata with:
```
sudo apt install suricata -y
```

Verify interface:
```
ip a
```

Edit the configuration:
```
sudo nano /etc/suricata/suricata.yaml
```

Find ```af-packet:```, and set the interface into:
```
- interface: eth0
```

To enable the EVE JSON logging, Find ```outputs:```, make sure that they are enable and the path is correct:
```
- eve-log:
    enable: yes
    filetype: regular
    filename: /var/log/suricata/eve.json
```

After confirming all is set, start the Suricata service:
```
sudo systemctl enable suricata
sudo systemctl start suricata
```

we can check the logs with:
```
sudo tail -f /var/log/suricata/eve.json
```

4. Install andConfigure Filebeat
Install the filebeat using:
```
sudo apt install filebeat -y
```

Enable the suricata module:
```
sudo filebeat modules enable suricata
```

Configure filebeat using the command:
```
sudo nano /etc/filebeat/filebeat.yml
```

Set Elasticsearch output into:
```
output.elasticsesearch:
  hosts: ["localhost:9200"]
  username: "elastic"
  password: "YOUR_PASSWORD"
```

Then, enable the kibana setup:
```
sudo filebeat setup
```

and start the filebeat:
```
sudo systemctl enable filebeat
sudo systemctl start filebeat
```

5. Configure Discord Alert
Create a Channel for the alert to go:

```#alert-kibana```

Create Webhook by going to:
- Server settings --> integrations --> Webhooks
- Copy the Webhook URL

Test the webhook:
```
curl -H "Content-type: application/json"
-d '{"content":"Test Alert from SIEM"}'
WEBHOOK_URL
```

if it works, you will get a discord notification on the channel that you make

6. Create Alert Automation Script
```

```

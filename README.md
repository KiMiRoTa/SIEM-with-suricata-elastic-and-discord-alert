# Real-Time Intrusion Detection and Threat Monitoring using Suricata, Elastic Stack, and Discord Alert
This repository is my University project about making a Real-time intrusion detection and threat monitoring using Suricata, Elastic Stack, and Discord alert.

## Overview
This project demonstrates a Security Information and Event Management (SIEM) implementation using:
- Suricata IDS for real-time intrusion detection
- Elastic Stack (Elasticsearch, Logstash, Kibana) for log analysis and visualization
- Filebeat for log shipping
- Discord Webhook for real-time alert notification
The system detects network attacks and instantly sends alerts to Discord, improving response time and visibility.

## Objectives
- Detect malicious network activity in real-time
- Centralize logs using Elastic Stack
- Visualize threats using Kibana dashboards
- Send automated alerts via Discord
- Simulate attacks for testing detection capability

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

3. Setup Suricata
```
sudo apt install suricata
sudo systemctl enable suricata
sudo systemctl start suricata
```

4. Configure Filebeat
```

```

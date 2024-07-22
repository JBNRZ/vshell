#!/bin/bash
docker compose up -d
sleep 5
ntpdate ntp.aliyun.com

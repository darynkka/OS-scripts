#!/bin/bash

ping_website() {
    website=$1
    echo "-----------"
    echo "Ping $website"
    ping -c 3 $website

    echo "-----------"
}

check_response_speed() {
    website=$1
    echo "Checking answer speed of $website"
    response_time=$(curl -s -w "%{time_total}\n" -o /dev/null $website)
    echo "Answer time: $response_time sec"
}

check_http_status() {
    website=$1
    echo "Cheking http-query status for $website"
    http_status=$(curl -s -o /dev/null -I -w "%{http_code}" $website)
    echo "Http-query status: $http_status"
}

websites=( "reddit.com" "pinterest.com" )

for site in "${websites[@]}"; do
    ping_website $site
    check_response_speed $site
    check_http_status $site
done


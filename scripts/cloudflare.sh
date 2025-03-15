#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLOUDFLARE_FILE_PATH=$SCRIPT_DIR/../volumes/gateway/nginx-proxy-manager/custom/cloudflare.conf

{
  echo "#Cloudflare";
  echo "";

  echo "# - IPv4";
  for i in $(curl -s -L https://www.cloudflare.com/ips-v4); do
      echo "set_real_ip_from $i;";
  done

  echo "";
  echo "# - IPv6";
  for i in $(curl -s -L https://www.cloudflare.com/ips-v6); do
      echo "set_real_ip_from $i;";
  done

  echo "";
  echo "real_ip_header CF-Connecting-IP;";
} > $CLOUDFLARE_FILE_PATH

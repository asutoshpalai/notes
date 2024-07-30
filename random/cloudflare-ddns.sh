target_record="ghara.asutoshpalai.in"
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo $myip

dns_zone="$(curl -X GET "https://api.cloudflare.com/client/v4/zones"\
  -H "Authorization: Bearer $(cat cf-token)"\
  -H "Content-Type:application/json" |
  jq -r '.result | .[] | select(.name == "asutoshpalai.in") | .id')"

echo $dns_zone

record="$(curl -X GET "https://api.cloudflare.com/client/v4/zones/$dns_zone/dns_records?name=$target_record" \
  -H "Authorization: Bearer $(cat cf-token)" \
  -H "Content-Type:application/json")"

record_id="$(echo $record | jq -r '.result[0].id')"
record_ip="$(echo $record | jq -r '.result[0].content')"
echo $record_id
echo $record_ip

if [ "$record_ip" != "$myip"  ]; then
  curl -X PUT "https://api.cloudflare.com/client/v4/zones/$dns_zone/dns_records/$record_id"      -H "Authorization: Bearer $(cat cf-token)"      -H "Content-Type:application/json" --data '{"type":"A","name":"ghara.asutoshpalai.in","content":"'$myip'","ttl":1,"proxied":false}'
else
  echo "Record contains latest IP"
fi

#!/bin/bash
function fail() {
echo "Task failed !"
exit 1
}


until $(curl --output /dev/null --silent --head --fail localhost:9200); do
    printf '.'
    sleep 1
done
INDEX=$(curl -s -X GET localhost:9200/product 2> /dev/null | jq -c '.status')
[ "$INDEX" == "null" ] || fail
MAPPING=$(curl -s -X GET localhost:9200/product/_mapping | jq -c .product.mappings.properties)
[ `jq -r '.name.type' 2> /dev/null <<< "$MAPPING"` == "text" ] || fail
[ `jq -r '.name.fields[].type' 2> /dev/null <<< "$MAPPING"` == "keyword" ] || fail
[ `jq -r '.description.type' 2> /dev/null <<< "$MAPPING"` == "text" ] || fail
[ `jq -r '.category.type' 2> /dev/null <<< "$MAPPING"` == "keyword" ] || fail
[ `jq -r '.price.type' 2> /dev/null <<< "$MAPPING"` == "double" ] || fail
[ "$(curl -s -X GET localhost:9200/product/_doc/P99 2> /dev/null | jq -c '._source' 2> /dev/null)" == '{"name":"Fantasy Adventure Novel","description":"Explore a magical world filled with wonder and adventure in this epic fantasy novel.","category":"Books","price":9.99}' ] || fail
echo "Good Job !"
echo "Last step to validate this part, write a request to retrieve all documents. Ctrl+D to submit"
echo 
echo Example : 
echo PUT /index
echo {
echo   "mapping": {
echo   }
echo }
echo
echo
echo Your request :
echo 

INPUT=$(cat <<< $(cat))
VERB=$(echo $INPUT | awk '{ print $1 }')
URL=$(echo $INPUT | awk '{ print $2 }')
DATA=$(echo $INPUT | awk '{ for (i=3; i<= NF; i++) printf "%s", $i}')
RESULT=$(curl -H "Content-Type: application/json" -X $VERB -d "$DATA" localhost:9200$URL 2> /dev/null)
FIRST_DOC=$(echo $RESULT | jq '.hits.hits[0]')
DOC_COUNT=$(echo $RESULT | jq '.hits.hits' | jq length)

[ `jq -r '._index' 2> /dev/null <<< "$FIRST_DOC"` == "product" ] || fail
[ "$DOC_COUNT" == "100" ] || fail

echo "Task succeeded :)"

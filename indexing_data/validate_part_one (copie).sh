#!/bin/bash
MAPPING=$(curl -s -X GET localhost:9200/product/_mapping | jq -c .product.mappings.properties)
RESULT=true
RESULT=$RESULT && [ `jq -r '.name.type' 2> /dev/null <<< "$MAPPING"` == "text" ]
RESULT=$RESULT && [ `jq -r '.name.fields[].type' 2> /dev/null <<< "$MAPPING"` == "keyword" ]
RESULT=$RESULT && [ `jq -r '.description.type' 2> /dev/null <<< "$MAPPING"` == "text" ]
RESULT=$RESULT && [ `jq -r '.category.type' 2> /dev/null <<< "$MAPPING"` == "keyword" ]
RESULT=$RESULT && [ `jq -r '.price.type' 2> /dev/null <<< "$MAPPING"` == "double" ]
RESULT=$RESULT && [ "$(curl -s -X GET localhost:9200/product/_doc/P99 2> /dev/null | jq -c '._source' 2> /dev/null)" == '{"name":"Fantasy Adventure Novel","description":"Explore a magical world filled with wonder and adventure in this epic fantasy novel.","category":"Books","price":9.99}' ]
if $RESULT
then
echo "Good Job !"
else
echo "Task failed !"
fi

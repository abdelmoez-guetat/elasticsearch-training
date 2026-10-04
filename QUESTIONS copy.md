## Data Management:
### Exercise 1: Define an Index

#### Question:
Create an index named products with a custom mapping where the name, category, and description fields are analyzed text fields, price is a double, and stock and rating are integers.

#### Topics Covered:
* Index creation
* Custom mappings
* Data types for fields
* Text analysis

#### Solution:

```json
PUT /products
{
  "mappings": {
    "properties": {
       "created": {
          "type": "keyword"
        },
        "description": {
          "type": "text"
        },
        "in_stock": {
          "type": "long"
        },
        "is_active": {
          "type": "boolean"
        },
        "name": {
          "type": "text"
        },
        "price": {
          "type": "long"
        },
        "product_id": {
          "type": "long"
        },
        "sold": {
          "type": "long"
        },
        "tags": {
          "type": "keyword"
        }
    }
  }
}
```
### Exercise 2: Define an Index Template

#### Question:
Create an Elasticsearch index template for indices matching the pattern products-*. The template should include mappings and settings for these indices, specifying that:

* The `name` and `description` fields are analyzed as text fields.
* The `category` field is treated as a keyword.
* The `price` field is defined as a double.
* The `stock` and rating fields are defined as integers.

Additionally, set the number_of_shards to 3 and the number_of_replicas to 1.

#### Topics Covered:

* Index templates
* Pattern matching
* Mappings and settings

#### Solution:

```json

PUT _index_template/products_template
{
  "index_patterns": ["products-*"],
  "template": {
    "settings": {
      "number_of_shards": 3,
      "number_of_replicas": 1
    },
    "mappings": {
      "properties": {
        "created": {
          "type": "date"
        },
        "description": {
          "type": "text"
        },
        "in_stock": {
          "type": "long"
        },
        "is_active": {
          "type": "boolean"
        },
        "name": {
          "type": "text"
        },
        "price": {
          "type": "double"
        },
        "product_id": {
          "type": "long"
        },
        "sold": {
          "type": "integer"
        },
        "tags": {
          "type": "keyword"
        }
      }
    }
  }
}
```
### Exercise 3: Dynamic Templates

#### Question:
Create a dynamic template that applies to fields ending in _txt, treating them as analyzed text fields with custom analyzers.

#### Topics Covered:

* Dynamic templates
* Custom analyzers

#### Solution:


```json

PUT /products
{
  "mappings": {
    "dynamic_templates": [
      {
        "custom_txt_template": {
          "match": "*_txt",
          "mapping": {
            "type": "text",
            "analyzer": "custom_analyzer"
          }
        }
      }
    ]
  }
}
```

### Exercise 4: Index Lifecycle Management

#### Question:
Define an ILM policy for a time-series index (e.g., sales-*) with phases for hot, warm, and cold storage.

#### Topics Covered:

* Index Lifecycle Management (ILM)
* Time-series index management

#### Solution:

```json

PUT _ilm/policy/sales_policy
{
  "policy": {
    "phases": {
      "hot": {
        "actions": {
          "rollover": {
            "max_size": "50GB",
            "max_age": "30d"
          }
        }
      },
      "warm": {
        "actions": {
          "forcemerge": {
            "max_num_segments": 1
          }
        }
      },
      "cold": {
        "actions": {
          "freeze": {}
        }
      }
    }
  }
}
```
### Exercise 5: Data Stream

#### Question:
Create an index template that uses a data stream for real-time ingestion of data (e.g., order data). The index template should have appropriate mappings.

#### Topics Covered:

* Data streams
* Index templates

#### Solution:

```json

PUT _index_template/order_template
{
  "index_patterns": ["orders-*"],
  "data_stream": {},
  "mappings": {
    "properties": {
      "order_id": { "type": "keyword" },
      "order_date": { "type": "date" },
      "total_amount": { "type": "double" }
    }
  }
}
```

## Searching Data:
### Exercise 6: Basic Search Query

#### Question:
Write a query to search for products that have the term "electronics" in the category field.

#### Topics Covered:

* Search queries
* Term matching

#### Solution:

```json

GET /products/_search
{
  "query": {
    "match": {
      "category": "electronics"
    }
  }
}
```
### Exercise 7: Boolean Query

#### Question:
Create a search query that filters products with a rating of 4.0 or higher and a price between 100 and 1000.

#### Topics Covered:

* Boolean queries
* Range filters

#### Solution:

```json

GET /products/_search
{
  "query": {
    "bool": {
      "must": [
        { "range": { "rating": { "gte": 4.0 } } },
        { "range": { "price": { "gte": 100, "lte": 1000 } } }
      ]
    }
  }
}
```
### Exercise 8: Asynchronous Search

#### Question:
Write and execute an asynchronous search to retrieve all products where the tags field contains the keyword "winter".

#### Topics Covered:

* Asynchronous search
* Tag-based search

#### Solution:

```json

POST /_async_search
{
  "query": {
    "match": {
      "tags": "winter"
    }
  }
}
```
### Exercise 9: Aggregations

#### Question:
Write a metric aggregation to calculate the average price of all products in the Electronics category.

#### Topics Covered:

* Metric aggregations
* Average calculations

#### Solution:

```json

GET /products/_search
{
  "size": 0,
  "query": {
    "match": {
      "category": "Electronics"
    }
  },
  "aggs": {
    "avg_price": {
      "avg": {
        "field": "price"
      }
    }
  }
}
```
### Exercise 10: Sub-Aggregations

#### Question:
Write a bucket aggregation to group products by category and calculate the average rating within each category.

#### Topics Covered:

* Bucket aggregations
* Sub-aggregations

#### Solution:

```json

GET /products/_search
{
  "size": 0,
  "aggs": {
    "by_category": {
      "terms": {
        "field": "category.keyword"
      },
      "aggs": {
        "avg_rating": {
          "avg": {
            "field": "rating"
          }
        }
      }
    }
  }
}
```
### Exercise 11: Cross-Cluster Search

#### Question:
Write a search query that spans across multiple clusters to retrieve data from both the products index and a remote inventory index.

#### Topics Covered:

* Cross-cluster search
* Querying multiple clusters

#### Solution:

```json

GET /products,remote_cluster:inventory/_search
{
  "query": {
    "match_all": {}
  }
}
```

##  Developing Search Applications:
### Exercise 12: Highlight Search Terms

#### Question:
Execute a search query that highlights the term "laptop" in the description field.

#### Topics Covered:

* Search queries
* Highlighting terms in results

#### Solution:

```json

GET /products/_search
{
  "query": {
    "match": {
      "description": "laptop"
    }
  },
  "highlight": {
    "fields": {
      "description": {}
    }
  }
}
```

### Exercise 13: Sort Results

#### Question:
Sort the products by price in ascending order and return the top 5 cheapest products.

#### Topics Covered:

* Sorting search results
* Limiting result set

#### Solution:

```json

GET /products/_search
{
  "size": 5,
  "sort": [
    { "price": "asc" }
  ]
}
```

### Exercise 14: Pagination

#### Question:
Implement pagination on the search results to retrieve 10 products at a time.

#### Topics Covered:

* Pagination
* From/size parameters in Elasticsearch

#### Solution:

```json

GET /products/_search
{
  "from": 0,
  "size": 10,
  "query": {
    "match_all": {}
  }
}
```

### Exercise 15: Index Aliases

#### Question:
Define an alias for the products index, such as current-products, and perform a search query using this alias.

#### Topics Covered:

* Index aliases
* Querying via aliases

#### Solution:

```json

POST /_aliases
{
  "actions": [
    {
      "add": {
        "index": "products",
        "alias": "current-products"
      }
    }
  ]
}

GET /current-products/_search
{
  "query": {
    "match_all": {}
  }
}
```

### Exercise 16: Search Template

#### Question:
Define a search template that allows for parameterized queries, where you can dynamically provide values like category or price range.

#### Topics Covered:

* Search templates
* Parameterized queries

#### Solution:

```json

POST _scripts/category_price_template
{
  "script": {
    "lang": "mustache",
    "source": """
    {
      "query": {
        "bool": {
          "must": [
            { "match": { "category": "{{category}}" } },
            { "range": { "price": { "gte": "{{min_price}}", "lte": "{{max_price}}" } } }
          ]
        }
      }
    }
    """
  }
}

POST _search/template
{
  "id": "category_price_template",
  "params": {
    "category": "electronics",
    "min_price": 100,
    "max_price": 1000
  }
}
```

## Data Processing:
### Exercise 17: Define a Mapping

#### Question:
Create a mapping where the description field uses a custom analyzer to handle synonyms.

#### Topics Covered:

* Mappings
* Custom analyzers
* Synonym handling

#### Solution:

```json

PUT /products
{
  "settings": {
    "analysis": {
      "filter": {
        "synonym_filter": {
          "type": "synonym",
          "synonyms": [
            "laptop, notebook",
            "mobile, smartphone"
          ]
        }
      },
      "analyzer": {
        "synonym_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": ["lowercase", "synonym_filter"]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "description": { 
        "type": "text",
        "analyzer": "synonym_analyzer"
      }
    }
  }
}
```

### Exercise 18: Multi-fields

#### Question:
Define multi-fields for the name field, where one version is analyzed with a standard analyzer and another with a keyword analyzer.

#### Topics Covered:

    Multi-fields
    Analyzers

#### Solution:

```json

PUT /products
{
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "fields": {
          "raw": { 
            "type": "keyword"
          }
        }
      }
    }
  }
}
```

### Exercise 19: Reindexing

#### Question:
Use the Reindex API to copy data from the old-products index to the new-products index.

#### Topics Covered:

    Reindexing data
    Data migration

#### Solution:

```json

POST _reindex
{
  "source": {
    "index": "old-products"
  },
  "dest": {
    "index": "new-products"
  }
}
```

### Exercise 20: Ingest Pipeline

#### Question:
Define an ingest pipeline that adds a field is_expensive based on the price of the product (e.g., true if price > 500), using Painless scripting.

#### Topics Covered:

* Ingest pipelines
* Painless scripting

#### Solution:

```json

PUT _ingest/pipeline/product_pipeline
{
  "processors": [
    {
      "script": {
        "lang": "painless",
        "source": """
        if (ctx.price > 500) {
          ctx.is_expensive = true;
        } else {
          ctx.is_expensive = false;
        }
        """
      }
    }
  ]
}
```

## Cluster Management:
### Exercise 21: Diagnose Shard Issues

#### Question:
Simulate a shard issue in a cluster and demonstrate how to repair the cluster’s health.

#### Topics Covered:

* Cluster health
* Shard allocation and repairs

#### Solution:

```json

GET _cluster/health

POST _cluster/reroute
{
  "commands": [
    {
      "cancel": {
        "index": "products",
        "shard": 0,
        "node": "node1",
        "allow_primary": true
      }
    }
  ]
}
```

### Exercise 22: Backup and Restore

#### Question:
Create a snapshot of the products index, and then demonstrate how to restore it.

#### Topics Covered:

* Snapshots
* Index backup and restoration

#### Solution:

```json

PUT /_snapshot/my_backup_repository
{
  "type": "fs",
  "settings": {
    "location": "/mnt/backups"
  }
}

PUT /_snapshot/my_backup_repository/snapshot_1
{
  "indices": "products",
  "ignore_unavailable": true,
  "include_global_state": false
}

POST /_snapshot/my_backup_repository/snapshot_1/_restore
```

### Exercise 23: Cross-Cluster Replication

#### Question:
Set up cross-cluster replication where the products index from one cluster is replicated to another cluster.

#### Topics Covered:
* Cross-cluster replication
* Data redundancy across clusters

#### Solution:

```json

PUT /_ccr/auto_follow/my_auto_follow_pattern
{
  "leader_index_patterns": ["products*"],
  "remote_cluster": "remote_cluster_name"
}

PUT /products/_ccr/follow
{
  "remote_cluster": "remote_cluster_name",
  "leader_index": "products"
}
```

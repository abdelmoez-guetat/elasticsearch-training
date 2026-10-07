## Cluster Management:
### Exercise 1: Diagnose Shard Issues

#### Question:
Check cluster health API, diagnose unassigned shards on the cluster, and reallocate or repair cluster health to green.

#### Topics Covered:
* Cluster health
* Shard allocation and repairs


## Data Management:
### Exercise 2: Define an Index

#### Question:
Create an index named `products` with a custom mapping where the `name`, `category`, and `description` fields are analyzed text fields, `price`, `stock` and `rating` are doubles.

#### Topics Covered:
* Index creation
* Custom mappings
* Data types for fields
* Text analysis

### Exercise 3: Define an Index Template

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


### Exercise 4: Dynamic Templates

#### Question:
Create a dynamic template that applies to fields ending in _txt, treating them as analyzed text fields with custom analyzers.

#### Topics Covered:

* Dynamic templates
* Custom analyzers

### Exercise 5: Index Lifecycle Management

#### Question:
Define an ILM policy for a time-series index (e.g., sales-*) with phases for hot, warm, and cold storage.

#### Topics Covered:

* Index Lifecycle Management (ILM)
* Time-series index management

### Exercise 6: Data Stream

#### Question:
Create an index template that uses a data stream for real-time ingestion of data (e.g., order data). The index template should have appropriate mappings.

#### Topics Covered:

* Data streams
* Index templates


## Searching Data:
### Exercise 7: Basic Search Query

#### Question:
Write a query to search for products that have the term "electronics" in the category field.

#### Topics Covered:

* Search queries
* Term matching


### Exercise 8: Boolean Query

#### Question:
Create a search query that filters products with a rating of 4.0 or higher and a price between 100 and 1000.

#### Topics Covered:

* Boolean queries
* Range filters


### Exercise 9: Asynchronous Search

#### Question:
Write and execute an asynchronous search to retrieve all products where the tags field contains the keyword "winter".

#### Topics Covered:

* Asynchronous search
* Tag-based search


### Exercise 10: Aggregations

#### Question:
Write a metric aggregation to calculate the average price of all products in the Electronics category.

#### Topics Covered:

* Metric aggregations
* Average calculations

### Exercise 11: Sub-Aggregations

#### Question:
Write a bucket aggregation to group products by category and calculate the average rating within each category.

#### Topics Covered:

* Bucket aggregations
* Sub-aggregations

### Exercise 12: Cross-Cluster Search

#### Question:
Write a search query that spans across multiple clusters to retrieve data from both the products index and a remote inventory index.

#### Topics Covered:

* Cross-cluster search
* Querying multiple clusters


##  Developing Search Applications:
### Exercise 13: Highlight Search Terms

#### Question:
Execute a search query that highlights the term "laptop" in the description field.

#### Topics Covered:

* Search queries
* Highlighting terms in results


### Exercise 14: Sort Results

#### Question:
Sort the products by price in ascending order and return the top 5 cheapest products.

#### Topics Covered:

* Sorting search results
* Limiting result set


### Exercise 15: Pagination

#### Question:
Implement pagination on the search results to retrieve 10 products at a time.

#### Topics Covered:

* Pagination
* From/size parameters in Elasticsearch


### Exercise 16: Index Aliases

#### Question:
Define an alias for the products index, such as current-products, and perform a search query using this alias.

#### Topics Covered:

* Index aliases
* Querying via aliases


### Exercise 17: Search Template

#### Question:
Define a search template that allows for parameterized queries, where you can dynamically provide values like category or price range.

#### Topics Covered:

* Search templates
* Parameterized queries



## Data Processing:
### Exercise 18: Define a Mapping

#### Question:
Create a mapping where the description field uses a custom analyzer to handle synonyms.

#### Topics Covered:

* Mappings
* Custom analyzers
* Synonym handling


### Exercise 19: Multi-fields

#### Question:
Define multi-fields for the name field, where one version is analyzed with a standard analyzer and another with a keyword analyzer.

#### Topics Covered:

    Multi-fields
    Analyzers


### Exercise 20: Reindexing

#### Question:
Use the Reindex API to copy data from the old-products index to the new-products index.

#### Topics Covered:

    Reindexing data
    Data migration



### Exercise 21: Ingest Pipeline

#### Question:
Define an ingest pipeline that adds a field is_expensive based on the price of the product (e.g., true if price > 500), using Painless scripting.

#### Topics Covered:

* Ingest pipelines
* Painless scripting

## Cluster Management:
### Exercise 22: Backup and Restore

#### Question:
Create a snapshot of the products index, and then demonstrate how to restore it.

#### Topics Covered:

* Snapshots
* Index backup and restoration


### Exercise 23: Cross-Cluster Replication

#### Question:
Set up cross-cluster replication where the products index from one cluster is replicated to another cluster.

#### Topics Covered:
* Cross-cluster replication
* Data redundancy across clusters


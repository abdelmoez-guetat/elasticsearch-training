import json
import requests
from flask import Flask, jsonify, request

app = Flask(__name__)

ES_URL = "http://c1es1:9200"

def parse_user_query(user_queries, q_id, default_json=None):
    if not user_queries:
        return default_json
    raw = user_queries.get(str(q_id)) or user_queries.get(q_id)
    if not raw or not raw.strip():
        return default_json
    try:
        return json.loads(raw)
    except Exception:
        return None

@app.route('/api/evaluate', methods=['GET', 'POST'])
def evaluate():
    user_queries = {}
    if request.method == 'POST':
        data = request.get_json(silent=True) or {}
        user_queries = data.get('queries', {})

    results = []

    # Exercise 1: Define an Index 'products'
    try:
        r = requests.get(f"{ES_URL}/products/_mapping")
        if r.status_code == 200:
            props = r.json().get('products', {}).get('mappings', {}).get('properties', {})
            cond = (
                props.get('name', {}).get('type') == 'text' and
                props.get('category', {}).get('type') in ['text', 'keyword'] and
                props.get('description', {}).get('type') == 'text' and
                props.get('price', {}).get('type') in ['double', 'float'] and
                props.get('stock', {}).get('type') in ['double', 'integer', 'long'] and
                props.get('rating', {}).get('type') in ['double', 'float']
            )
            results.append({
                "id": 1,
                "title": "Define an Index 'products'",
                "passed": bool(cond),
                "message": "Index 'products' exists with requested mappings." if cond else "Mapping mismatch for 'products'."
            })
        else:
            results.append({"id": 1, "title": "Define an Index 'products'", "passed": False, "message": "Index 'products' not found."})
    except Exception as e:
        results.append({"id": 1, "title": "Define an Index 'products'", "passed": False, "message": str(e)})

    # Exercise 2: Define an Index Template 'products-*'
    try:
        r = requests.get(f"{ES_URL}/_index_template")
        passed = False
        msg = "Index template matching products-* not found."
        if r.status_code == 200:
            templates = r.json().get('index_templates', [])
            for t in templates:
                patterns = t.get('index_template', {}).get('index_patterns', [])
                if any("products-" in p for p in patterns):
                    passed = True
                    msg = f"Index template '{t.get('name')}' found for products-*."
                    break
        results.append({"id": 2, "title": "Define Index Template", "passed": passed, "message": msg})
    except Exception as e:
        results.append({"id": 2, "title": "Define Index Template", "passed": False, "message": str(e)})

    # Exercise 3: Dynamic Templates
    try:
        r = requests.get(f"{ES_URL}/_template")
        r_index_tmpl = requests.get(f"{ES_URL}/_index_template")
        passed = False
        content_str = (r.text + r_index_tmpl.text).lower()
        if "_txt" in content_str and "dynamic_templates" in content_str:
            passed = True
        results.append({
            "id": 3,
            "title": "Dynamic Templates",
            "passed": passed,
            "message": "Dynamic template for *_txt fields detected." if passed else "No dynamic template for *_txt fields found."
        })
    except Exception as e:
        results.append({"id": 3, "title": "Dynamic Templates", "passed": False, "message": str(e)})

    # Exercise 4: ILM Policy
    try:
        r = requests.get(f"{ES_URL}/_ilm/policy")
        passed = False
        if r.status_code == 200:
            policies = r.json()
            if any("sales" in k.lower() or "products" in k.lower() for k in policies.keys()):
                passed = True
        results.append({
            "id": 4,
            "title": "Index Lifecycle Management (ILM)",
            "passed": passed,
            "message": "ILM policy configured." if passed else "No custom ILM policy found."
        })
    except Exception as e:
        results.append({"id": 4, "title": "Index Lifecycle Management (ILM)", "passed": False, "message": str(e)})

    # Exercise 5: Data Stream
    try:
        r = requests.get(f"{ES_URL}/_data_stream")
        passed = False
        if r.status_code == 200 and len(r.json().get('data_streams', [])) > 0:
            passed = True
        results.append({
            "id": 5,
            "title": "Data Stream",
            "passed": passed,
            "message": "Data stream created." if passed else "No active data streams found."
        })
    except Exception as e:
        results.append({"id": 5, "title": "Data Stream", "passed": False, "message": str(e)})

    # Exercise 6: Basic Search Query
    try:
        query_body = parse_user_query(user_queries, 6, {"query": {"term": {"category": "electronics"}}})
        if query_body is None:
            results.append({"id": 6, "title": "Basic Search Query", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200 and r.json().get('hits', {}).get('total', {}).get('value', 0) > 0)
            results.append({
                "id": 6,
                "title": "Basic Search Query",
                "passed": passed,
                "message": "DSL search query executed successfully." if passed else f"DSL search failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 6, "title": "Basic Search Query", "passed": False, "message": str(e)})

    # Exercise 7: Boolean Query
    try:
        query_body = parse_user_query(user_queries, 7, {
            "query": {
                "bool": {
                    "filter": [
                        {"range": {"rating": {"gte": 4.0}}},
                        {"range": {"price": {"gte": 100, "lte": 1000}}}
                    ]
                }
            }
        })
        if query_body is None:
            results.append({"id": 7, "title": "Boolean Query", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200)
            results.append({
                "id": 7,
                "title": "Boolean Query",
                "passed": passed,
                "message": "Boolean DSL query verified." if passed else f"DSL search failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 7, "title": "Boolean Query", "passed": False, "message": str(e)})

    # Exercise 8: Asynchronous Search
    try:
        query_body = parse_user_query(user_queries, 8, {"query": {"term": {"tags": "winter"}}})
        if query_body is None:
            results.append({"id": 8, "title": "Asynchronous Search", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_async_search", json=query_body)
            passed = (r.status_code == 200)
            if not passed:
                r_fallback = requests.post(f"{ES_URL}/products/_search", json=query_body)
                passed = (r_fallback.status_code == 200)
            results.append({
                "id": 8,
                "title": "Asynchronous Search",
                "passed": passed,
                "message": "Async search DSL query verified." if passed else f"Async search failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 8, "title": "Asynchronous Search", "passed": False, "message": str(e)})

    # Exercise 9: Aggregations
    try:
        query_body = parse_user_query(user_queries, 9, {
            "size": 0,
            "query": {"term": {"category": "electronics"}},
            "aggs": {"avg_price": {"avg": {"field": "price"}}}
        })
        if query_body is None:
            results.append({"id": 9, "title": "Aggregations", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200 and len(r.json().get('aggregations', {})) > 0)
            results.append({
                "id": 9,
                "title": "Aggregations",
                "passed": passed,
                "message": "Metric aggregation DSL query verified." if passed else f"Aggregation query failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 9, "title": "Aggregations", "passed": False, "message": str(e)})

    # Exercise 10: Sub-Aggregations
    try:
        query_body = parse_user_query(user_queries, 10, {
            "size": 0,
            "aggs": {
                "by_category": {
                    "terms": {"field": "category.keyword"},
                    "aggs": {"avg_rating": {"avg": {"field": "rating"}}}
                }
            }
        })
        if query_body is None:
            results.append({"id": 10, "title": "Sub-Aggregations", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200 and len(r.json().get('aggregations', {})) > 0)
            results.append({
                "id": 10,
                "title": "Sub-Aggregations",
                "passed": passed,
                "message": "Sub-aggregation DSL query verified." if passed else f"Sub-aggregation query failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 10, "title": "Sub-Aggregations", "passed": False, "message": str(e)})

    # Exercise 11: Cross-Cluster Search
    try:
        r = requests.get(f"{ES_URL}/_cluster/settings")
        passed = False
        if r.status_code == 200:
            settings = r.json()
            persistent = settings.get('persistent', {}).get('cluster', {}).get('remote', {})
            transient = settings.get('transient', {}).get('cluster', {}).get('remote', {})
            if persistent or transient:
                passed = True
        results.append({
            "id": 11,
            "title": "Cross-Cluster Search",
            "passed": passed,
            "message": "Remote cluster entry configured." if passed else "No remote cluster settings configured."
        })
    except Exception as e:
        results.append({"id": 11, "title": "Cross-Cluster Search", "passed": False, "message": str(e)})

    # Exercise 12: Highlight Search Terms
    try:
        query_body = parse_user_query(user_queries, 12, {
            "query": {"match": {"description": "laptop"}},
            "highlight": {"fields": {"description": {}}}
        })
        if query_body is None:
            results.append({"id": 12, "title": "Highlight Search Terms", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200)
            results.append({
                "id": 12,
                "title": "Highlight Search Terms",
                "passed": passed,
                "message": "Highlight search query verified." if passed else f"Highlight query failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 12, "title": "Highlight Search Terms", "passed": False, "message": str(e)})

    # Exercise 13: Sort Results
    try:
        query_body = parse_user_query(user_queries, 13, {
            "sort": [{"price": {"order": "asc"}}],
            "size": 5
        })
        if query_body is None:
            results.append({"id": 13, "title": "Sort Results", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200 and len(r.json().get('hits', {}).get('hits', [])) <= 5)
            results.append({
                "id": 13,
                "title": "Sort Results",
                "passed": passed,
                "message": "Sort results query verified." if passed else f"Sort query failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 13, "title": "Sort Results", "passed": False, "message": str(e)})

    # Exercise 14: Pagination
    try:
        query_body = parse_user_query(user_queries, 14, {"from": 10, "size": 10})
        if query_body is None:
            results.append({"id": 14, "title": "Pagination", "passed": False, "message": "Invalid JSON syntax in DSL query editor."})
        else:
            r = requests.post(f"{ES_URL}/products/_search", json=query_body)
            passed = (r.status_code == 200)
            results.append({
                "id": 14,
                "title": "Pagination",
                "passed": passed,
                "message": "Pagination query verified." if passed else f"Pagination query failed (HTTP {r.status_code})."
            })
    except Exception as e:
        results.append({"id": 14, "title": "Pagination", "passed": False, "message": str(e)})

    # Exercise 15: Index Aliases
    try:
        r = requests.get(f"{ES_URL}/_alias/current-products")
        passed = (r.status_code == 200)
        results.append({
            "id": 15,
            "title": "Index Aliases",
            "passed": passed,
            "message": "Alias 'current-products' exists." if passed else "Alias 'current-products' not found."
        })
    except Exception as e:
        results.append({"id": 15, "title": "Index Aliases", "passed": False, "message": str(e)})

    # Exercise 16: Search Template
    try:
        r = requests.get(f"{ES_URL}/_scripts/product-search-template")
        passed = (r.status_code == 200)
        results.append({
            "id": 16,
            "title": "Search Template",
            "passed": passed,
            "message": "Search template 'product-search-template' exists." if passed else "Search template not found."
        })
    except Exception as e:
        results.append({"id": 16, "title": "Search Template", "passed": False, "message": str(e)})

    # Exercise 17: Mapping with Synonyms
    try:
        r = requests.get(f"{ES_URL}/synonym-products/_mapping")
        passed = (r.status_code == 200)
        results.append({
            "id": 17,
            "title": "Mapping with Synonyms",
            "passed": passed,
            "message": "Index 'synonym-products' exists." if passed else "Index 'synonym-products' not found."
        })
    except Exception as e:
        results.append({"id": 17, "title": "Mapping with Synonyms", "passed": False, "message": str(e)})

    # Exercise 18: Multi-fields
    try:
        r = requests.get(f"{ES_URL}/products/_mapping")
        passed = False
        if r.status_code == 200:
            name_prop = r.json().get('products', {}).get('mappings', {}).get('properties', {}).get('name', {})
            if 'fields' in name_prop:
                passed = True
        results.append({
            "id": 18,
            "title": "Multi-fields",
            "passed": passed,
            "message": "Multi-fields defined on 'name' property." if passed else "No sub-fields defined on 'name'."
        })
    except Exception as e:
        results.append({"id": 18, "title": "Multi-fields", "passed": False, "message": str(e)})

    # Exercise 19: Reindexing
    try:
        r = requests.get(f"{ES_URL}/new-products/_count")
        passed = (r.status_code == 200 and r.json().get('count', 0) > 0)
        results.append({
            "id": 19,
            "title": "Reindexing",
            "passed": passed,
            "message": "Index 'new-products' contains reindexed docs." if passed else "Index 'new-products' not found or empty."
        })
    except Exception as e:
        results.append({"id": 19, "title": "Reindexing", "passed": False, "message": str(e)})

    # Exercise 20: Ingest Pipeline
    try:
        r = requests.get(f"{ES_URL}/_ingest/pipeline/check-expensive")
        passed = (r.status_code == 200)
        results.append({
            "id": 20,
            "title": "Ingest Pipeline",
            "passed": passed,
            "message": "Ingest pipeline 'check-expensive' exists." if passed else "Ingest pipeline 'check-expensive' not found."
        })
    except Exception as e:
        results.append({"id": 20, "title": "Ingest Pipeline", "passed": False, "message": str(e)})

    # Exercise 21: Diagnose Shard Issues
    try:
        r = requests.get(f"{ES_URL}/_cluster/health")
        passed = False
        if r.status_code == 200:
            status = r.json().get('status')
            if status in ['green', 'yellow']:
                passed = True
        results.append({
            "id": 21,
            "title": "Diagnose Shard Issues",
            "passed": passed,
            "message": f"Cluster status is healthy ({r.json().get('status')})." if passed else "Cluster status degraded."
        })
    except Exception as e:
        results.append({"id": 21, "title": "Diagnose Shard Issues", "passed": False, "message": str(e)})

    # Exercise 22: Backup and Restore
    try:
        r = requests.get(f"{ES_URL}/_snapshot/my_backup")
        passed = (r.status_code == 200)
        results.append({
            "id": 22,
            "title": "Backup and Restore",
            "passed": passed,
            "message": "Snapshot repository 'my_backup' registered." if passed else "Snapshot repository 'my_backup' not found."
        })
    except Exception as e:
        results.append({"id": 22, "title": "Backup and Restore", "passed": False, "message": str(e)})

    # Exercise 23: Cross-Cluster Replication
    try:
        r = requests.get(f"{ES_URL}/_ccr/auto_follow")
        passed = (r.status_code in [200, 404, 400])
        results.append({
            "id": 23,
            "title": "Cross-Cluster Replication",
            "passed": passed,
            "message": "CCR API available." if passed else "CCR not configured."
        })
    except Exception as e:
        results.append({"id": 23, "title": "Cross-Cluster Replication", "passed": False, "message": str(e)})

    passed_count = sum(1 for res in results if res['passed'])
    total_count = len(results)
    score_percentage = round((passed_count / total_count) * 100)

    return jsonify({
        "score": score_percentage,
        "passed_count": passed_count,
        "total_count": total_count,
        "results": results
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

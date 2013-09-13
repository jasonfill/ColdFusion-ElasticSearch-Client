IMPORTANT NOTES
--------------------------
Please feel free to submit additional code to enhance this project.  The goal is to create a full featured ElasticSearch client for ColdFusion, Railo, BlueDragon, and any other CFML engine.

Before proceeding, please keep in mind that this library is:

* Still under development and should be considered as a BETA at this time.
* Has only been tested with Railo 4+
* Developed with ElasticSearch 0.90.3 

Introduction
------------
Currently a semi-full featured client for ElasticSearch.  This library uses all native ColdFusion/Railo/BlueDragon code, no additional jars required for communication.  All interactions with the ElasticSearch cluster are done through the ElasticSearch REST interface.  

Supported Queries
-----------------
* Boolean
* Id
* Match
* MatchAll
* MultiMatch
* Nested
* Prefix
* Range
* RegEx
* Term
* Terms

Supported Filters
-----------------
* Boolean
* Exists
* Ids
* Limit
* MatchAll
* Missing
* Not
* Numeric Range
* Or
* Prefix
* Query
* Range
* Term
* Terms
* Type

Supported Facets
----------------
* Date Histogram
* Filter
* Histogram
* Range
* Statistical
* Terms
* Terms Stats


Getting Started
------------
```
// Cluster Connection
	// allows for connecting to multiple clusters.

	ClusterManager = new ClusterManager();
							.addNode(new lib.NodeConfig(host="Node1", port="9200", secure=true))
							.addNode(new lib.NodeConfig(host="Node2", port="9200", secure=true))

// Create the ElasticSearchClient which serves as the factory for the library.
	es = new ElasticSearchClient(ClusterManager);

// Example Get Request
	GetResponse = es.prepareGet("MyIndex","MyType","MyId").execute();

// Example Index
	IndexResult = es.prepareIndex("MyIndex","MyType","MyId")
						.setBody('{"status":"Hello World"}')
						.execute();

// Example Boolean Search
	Query = qb.BoolQuery()
				.mustNot(qb.rangeQuery("age")
							.from(10)
							.to(20))
				.must(qb.termQuery("user", "kimchy"))
				.should(qb.termQuery("tag", "wow"))
				.minMatch(1)
				.boost(1.0);

	SearchResponse = es.prepareSearch("MyIndex")
						.setTypes("MyType")
						.setQuery(Query)
						.setFrom(0)
						.setSize(20)
						.execute();

```

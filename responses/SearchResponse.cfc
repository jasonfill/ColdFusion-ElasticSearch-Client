component extends="Response" accessors="true" {

	property name="Facets"; // TODO: Handle the facets...
	property name="FailedShards";
	property name="Hits";
	property name="Took";
	property name="TimedOut";
	property name="SuccessfulShards";
	property name="TotalShards";
	property name="FailedShards";

	public SearchResponse function init(){
		setHits(new SearchHits());
		return this;
	}

	public void function handleResponse(){
		super.handleResponse(argumentCollection=arguments);

		if(structKeyExists(getBody(), "_shards")){
			setFailedShards(getBody()["_shards"].failed);
			setSuccessfulShards(getBody()["_shards"].successful);
			setTotalShards(getBody()["_shards"].total);
		}
		if(structKeyExists(getBody(), "timed_out")){
			setTimedOut(getBody()["timed_out"]);
		}
		if(structKeyExists(getBody(), "took")){
			setTook(getBody()["took"]);
		}
		if(structKeyExists(getBody(), "hits")){
			var maxScore = structKeyExists(getBody().hits, "max_score") ?  getBody().hits.max_score : 0;
			getHits().setMaxScore(maxScore);
			getHits().setTotalHits(getBody().hits.total);

			for(var h=1; h<= arrayLen(getBody().hits.hits); h++){
				var SearchHit = new SearchHit()
											.setId(getBody().hits.hits[h]["_id"])
											.setIndex(getBody().hits.hits[h]["_index"])
											.setType(getBody().hits.hits[h]["_type"])
											.setScore(getBody().hits.hits[h]["_score"])
											.setSource(getBody().hits.hits[h]["_source"]);
											
				if(structKeyExists(getBody().hits.hits[h],"highlight"))
					SearchHit.setHighlight(getBody().hits.hits[h]["highlight"])
					
				getHits().addHit(SearchHit);
			}
		}
	}
}
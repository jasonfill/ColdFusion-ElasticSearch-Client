component accessors="true" {

	property name="MaxScore" type="numeric";
	property name="TotalHits" type="numeric";
	property name="Hits" type="array";
	
	public ElasticSearchMapping.responses.SearchHits function init(){
		variables.Hits = [];
		return this;
	}

	public ElasticSearchMapping.responses.SearchHit function getAt(required numeric position){
		if(arrayLen(getHits()) <= arguments.position){
			return variables.Hits[arguments.position];
		}else{
			throw(message="There are only #arrayLen(getHits())# hits so #arguments.position# is out of bounds.");
		}
	}

	public void function addHit(required ElasticSearchMapping.responses.SearchHit SearchHit){
		arrayAppend(getHits(), arguments.SearchHit);
	}
}
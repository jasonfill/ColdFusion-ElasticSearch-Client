component accessors="true" {

	property name="MaxScore" type="numeric";
	property name="TotalHits" type="numeric";
	property name="Hits" type="array";
	
	public SearchHits function init(){
		variables.Hits = [];
		return this;
	}

	public SearchHit function getAt(required numeric position){
		if(arrayLen(getHits()) <= arguments.position){
			return variables.Hits[arguments.position];
		}else{
			throw(message="There are only #arrayLen(getHits())# hits so #arguments.position# is out of bounds.");
		}
	}

	public void function addHit(required SearchHit SearchHit){
		arrayAppend(getHits(), arguments.SearchHit);
	}
}
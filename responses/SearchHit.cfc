component accessors="true"{

	property name="Id" type="string";
	property name="Index" type="string";
	property name="Score" type="numeric";
	property name="Type" type="string";
	property name="Source" type="struct";
	
	public SearchHit function init(){
		return this;
	}

	public string function getSourceAsString(){
		if(isStruct(getSource())){
			return serializeJson(getSource());
		}
	}


}
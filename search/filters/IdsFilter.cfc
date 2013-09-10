/**
* http://www.elasticsearch.org/guide/reference/query-dsl/ids-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="type" type="array";
	property name="ids" type="array";
	
	public function init(string type="",
						 string ids=""){
		variables.ids = listToArray(Arguments.type);
		variables.type = listToArray(Arguments.Ids);
	
		return this;
	}

	public function addIds(){
		for(var i IN arguments){
			arrayAppend(variables.ids,arguments[i]);
		}
		
		return this;
	}

	public string function toString(){
		var json = "";
		if(ArrayLen(getType()) == 1){
			json = '"ids":{"type":"#getType()#","values":#arrayToStringArray(getIds())#}';
		}else{
			json = '"ids":{"type":#arrayToStringArray(getType())#,"values":#arrayToStringArray(getIds())#}';
		}		
		return json;
	}
}
/**
* http://www.elasticsearch.org/guide/reference/query-dsl/ids-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="type" type="array";
	property name="ids" type="array";
	
	public function init(string type="",
						 string ids=""){
		variables.ids = listToArray(Arguments.type);
		variables.type = listToArray(Arguments.Ids);;
	
		return this;
	}

	public function addIds(){
		for(var i IN arguments){
			arrayAppend(variables.ids,arguments[i]);
		}
		
		return this;
	}

	public string function toString(){
		var json = '"ids":{"type":"#getType()#","values":#arrayToStringArray(getIds())#}';
		return json;
	}
}
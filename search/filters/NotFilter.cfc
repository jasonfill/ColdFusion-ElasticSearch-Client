/**
* http://www.elasticsearch.org/guide/reference/query-dsl/not-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="filter" type="IFilter";
	property name="cache" type="boolean" default="false";

	public function init(string filter="",
						 boolean cache=TRUE){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = '"not":{#getFilter().toString()#}';
		if(getCache()){
			json = json & ',"_cache":true';
		}
		return json;
	}
}
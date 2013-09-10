/**
* http://www.elasticsearch.org/guide/reference/query-dsl/query-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="queryString" type="string";
	property name="cache" type="boolean" default="false";

	public function init(string queryString=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){

		var json = '"query":{query_string":{"query":"#getQueryString()#"}}';
		
		if(getCache()){
			json = '"fquery":{#json#},"_cache":true';
		}
		return json;
	}
}
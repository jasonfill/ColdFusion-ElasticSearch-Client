/**
* http://www.elasticsearch.org/guide/reference/query-dsl/prefix-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field" type="string";
	property name="value" type="string";
	property name="cache" type="boolean" default="false";

	public function init(string field="", 
						 string value=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = '"prefix":{"#getField()#":"#getValue()#"';
		if(getCache()){
			json = json & ',"_cache":true';
		}
		json = json & '}';
		return json;
	}
}
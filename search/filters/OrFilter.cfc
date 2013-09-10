/**
* http://www.elasticsearch.org/guide/reference/query-dsl/or-filter.html
**/

component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="filters" type="array";

	public function init(){
		variables.filters = [];
		
		for(var i IN arguments){
			add(arguments[i]);
		}
		return this;
	}

	public function add(required any Filter){
		arrayAppend(filters,arguments.filter);
		return this;
	}

	public string function toString(){
		var json = '';

			for(var f=1; f<=ArrayLen(getFilters()); f++){
				json = listAppend(json, '{#getFilters()[f].toString()#}');
			}	
			json = '"filters":[#json#]';
			if(getCache()){
				json = json & ',"_cache":true'
			}

			return '"or":{#json#}';
	}
}
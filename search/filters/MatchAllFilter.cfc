/**
* http://www.elasticsearch.org/guide/reference/query-dsl/match-all-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	public function init(){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		return '"match_all":{}';
	}

}
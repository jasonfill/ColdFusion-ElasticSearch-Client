/**
* http://www.elasticsearch.org/guide/reference/query-dsl/limit-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="value" type="numeric";

	public function init(string value=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		return '"limit":{"value":#getValue()#}';
	}
}
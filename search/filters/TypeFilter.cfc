
/**
* http://www.elasticsearch.org/guide/reference/query-dsl/type-filter/
**/

component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="type";
	
	public function init(string type=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		return '"type":{"value":"#getType()#"}';
	}
}
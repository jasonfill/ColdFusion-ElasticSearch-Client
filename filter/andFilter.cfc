component accessors="true" extends="com.elasticsearch.filter.Base"{

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
}
component accessors="true" extends="com.elasticsearch.filter.Base"{

	property name="must" type="array";
	property name="mustNot" type="array";
	property name="should" type="array";

	public function init(){
		variables.must = [];
		variables.mustNot = [];
		variables.should = [];
		return this;
	}

	public function must(required any Filter){
		arrayAppend(variables.must,arguments.filter);
		return this;
	}
	public function mustNot(required any Filter){
		arrayAppend(variables.mustNot,arguments.filter);
		return this;
	}
	public function should(required any Filter){
		arrayAppend(variables.should,arguments.filter);
		return this;
	}
}
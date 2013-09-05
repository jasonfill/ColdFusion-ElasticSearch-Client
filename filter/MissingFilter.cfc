component accessors="true" extends="com.elasticsearch.filter.Base"{

	property name="field";
	property name="existence";
	property name="null_value";

	public function init(string field="", 
						 boolean existence=FALSE, 
						 boolean null_value=FALSE){
		super.init(argumentCollection=Arguments);
		return this;
	}
}
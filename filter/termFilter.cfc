component accessors="true" extends="com.elasticsearch.filter.Base"{

	property name="field";
	property name="value";
	property name="cache";

	public function init(string field="", 
						 string value="",
						 boolean cache=TRUE){
		super.init(argumentCollection=Arguments);
		return this;
	}
}
/**
* http://www.elasticsearch.org/guide/reference/query-dsl/terms-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="field";
	property name="terms";
	property name="minMatch" type="numeric";

	public function init(string field="", 
						 string terms="",
						 numeric minMatch="1"){
		super.init(argumentCollection=Arguments);
		setTerms(listToArray(arguments.terms));
		return this;
	}

	public string function toString(){
		var json = '"terms":{"#getField()#":#arrayToStringArray(getTerms())#';
		if(val(getBoost()) > 0){
			json = json & ',"minimum_should_match":#getMinMatch()#';
		}
		json = json & '}';
		return json;
	}

}
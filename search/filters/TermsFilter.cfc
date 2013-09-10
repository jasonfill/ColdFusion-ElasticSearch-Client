/**
* http://www.elasticsearch.org/guide/reference/query-dsl/terms-filter/
**/
component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field";
	property name="terms";
	property name="execution" type="string" default="plain"; // plain, bool, and, or
	property name="cache" type="boolean" default="true";

	// support for the terms lookup mechanism...
	property name="index" type="string";
	property name="type" type="string";
	property name="path" type="string";
	property name="routing" type="string";
	property name="cacheKey" type="string";
	
	public function init(string field="", 
						 string terms=""){
		super.init(argumentCollection=Arguments);
		variables.terms = listToArray(Arguments.terms);
		return this;
	}

	public string function toString(){
		if(len(trim(getIndex()))){
			return toStringTermsLookupMechanism();
		}else{
			return toStringRegular();
		}
	}

	private string function toStringRegular(){
		var keys = "";

		if(len(trim(getFrom()))){
			keys = listAppend(keys, '"#getField()#":#arrayToStringArray(getTerms())#');
		}
		if(getExecution() != "plain"){
			keys = listAppend(keys, '"execution":"#getExecution()#"');
		}
		if(!getCache()){
			keys = listAppend(keys, '"_cache":false');
		}		
		return '"terms":{#keys#}';
	}

	private string function toStringTermsLookupMechanism(){
		var keys = "";
		var json = "";
		
			keys = listAppend(keys, '"index":"#getIndex()#"');
			keys = listAppend(keys, '"type":"#getType()#"');
			keys = listAppend(keys, '"id":"#getId()#"');
			keys = listAppend(keys, '"path":"#getPath()#"');
		
		json = '"#getField()#:{#keys#}';
		
		if(len(trim(getCacheKey()))){
			json = json & ',"_cache_key":"#getCacheKey()#"'
		}
	
		return '"terms":{#json#}';
	}

}
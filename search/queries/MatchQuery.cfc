/**
* http://www.elasticsearch.org/guide/reference/query-dsl/match-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{
	
	property name="field";
	property name="query";
	property name="operator";
	property name="zeroTermsQuery" type="string"; // valid options are none and all.
	property name="cutoffFrequency" type="numeric" default="0";
	property name="type" type="string" default="match"; // options include match, match_phrase, and match_phrase_prefix
	property name="analyzer";
	property name="maxExpansions" type="numeric" default="0";

	public function init(string field="",
						 string query=""){
		super.init(argumentCollection=Arguments);
		return this;
	}
	
	public string function toString(){
		var json = '"query":"#getQuery()#"';

		if(len(getOperator()) > 0){
			json =  listAppend(json, '"operator":"#getOperator()#"');
		}
		
		if(len(getZeroTermsQuery()) > 0){
			json =  listAppend(json, '"zero_terms_query":"#getZeroTermsQuery()#"');
		}
		
		if(len(getAnalyzer()) > 0){
			json =  listAppend(json, '"analyzer":"#getAnalyzer()#"');
		}
		
		if(val(getCutoffFrequency()) > 0){
			json =  listAppend(json, '"cutoff_frequency":#getCutoffFrequency()#');
		}

		if(val(getMaxExpansions()) > 0){
			json =  listAppend(json, '"max_expansions":#getMaxExpansions()#');
		}


		switch(getType()){
			case "match_phrase":
				return '"match_phrase":{"#getField()#":{#json#}}';
			break;
			case "match_phrase":
				return '"match_phrase_prefix":{"#getField()#":{#json#}}';
			break;
			default:
				return '"match":{"#getField()#":{#json#}}';
			break;
		}
	}
}
/**
* http://www.elasticsearch.org/guide/reference/query-dsl/match-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{
	
	property name="fields";
	property name="query";
	property name="operator";
	property name="useDisMax" type="boolean" default="true";
	property name="tieBreaker" type="numeric" default="0";
	property name="zeroTermsQuery" type="numeric";
	property name="cutoffFrequency" type="numeric";
	property name="type";
	property name="analyzer";
	property name="maxExpansions" type="numeric";

	public function init(string fields="",
						 string query=""){
		super.init(argumentCollection=Arguments);
		setFields(listToArray(arguments.fields));
		return this;
	}

	public string function toString(){
		var json = '"query":"#getQuery()#"';
		
		if(arrayLen(getFields()) > 0){
			json =  listAppend(json, '"fields": ["#replace(arrayToList(getFields()), ',', '","', 'all')#"]');
		}

		if(!getUseDisMax()){
			json =  listAppend(json, '"use_dis_max":false');
		}

		if(val(getTieBreaker()) > 0){
			json =  listAppend(json, '"tie_breaker":#getTieBreaker()#');
		}
		
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

		return '"multi_match":{#json#}';

	}
}
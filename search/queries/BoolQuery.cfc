component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="must" type="array";
	property name="mustNot" type="array";
	property name="should" type="array";
	property name="minMatch" type="numeric";
	property name="boost" type="numeric";

	public ElasticSearchMapping.search.queries.BoolQuery function init(){
		variables.must = [];
		variables.mustNot = [];
		variables.should = [];
		return this;
	}
	public ElasticSearchMapping.search.queries.BoolQuery function must(required ElasticSearchMapping.search.queries.IQuery Query){
		arrayAppend(variables.must,arguments.Query);
		return this;
	}
	public ElasticSearchMapping.search.queries.BoolQuery function mustNot(required ElasticSearchMapping.search.queries.IQuery Query){
		arrayAppend(variables.mustNot,arguments.Query);
		return this;
	}
	public ElasticSearchMapping.search.queries.BoolQuery function should(required ElasticSearchMapping.search.queries.IQuery Query){
		arrayAppend(variables.should,arguments.Query);
		return this;
	}
	public string function toString(){
		var boolStr = '';
		var m = "";
		var options = "";
		var must = "";
		var must_not = "";
		var should = "";
		if(arrayLen(getMust()) == 1){
			must = '"must":{' & getMust()[1].toString() & '}';
		}else if(arrayLen(getMust()) > 1){
			for(m=1; m<=ArrayLen(getMust()); m++){
				must = listAppend(must, '{' & getMust()[m].toString() & '}');
			}
			must = '"must":[' & must & ']';
		}

		if(arrayLen(getMustNot()) == 1){
			must_not = '"must_not":{' & getMustNot()[1].toString() & '}';
		}else if(arrayLen(getMustNot()) > 1){
			for(m=1; m<=ArrayLen(getMustNot()); m++){
				must_not = listAppend(must_not, '{' & getMustNot()[m].toString() & '}');
			}
			must_not = '"must_not":[' & must_not & ']';
		}

		if(arrayLen(getShould()) == 1){
			should = '"should":{' & getShould()[1].toString() & '}';
		}else if(arrayLen(getShould()) > 1){
			for(m=1; m<=ArrayLen(getShould()); m++){
				should = listAppend(should, '{' & getShould()[m].toString() & '}');
			}
			should = '"should":[' & should & ']';
		}

		if(len(trim(must))){
			boolStr = listAppend(boolStr, must);
		}
		if(len(trim(must_not))){
			boolStr = listAppend(boolStr, must_not);
		}
		if(len(trim(should))){
			boolStr = listAppend(boolStr, should);
		}

		if(arrayLen(getShould()) > 0 && val(getMinMatch()) > 0){
			boolStr = listAppend(boolStr, '"minimum_should_match":#getMinMatch()#');
		}

		if(val(getBoost()) > 0){
			boolStr = listAppend(boolStr, '"boost":#getBoost()#');
		}
		return '"bool":{#boolStr#}';
	}
}
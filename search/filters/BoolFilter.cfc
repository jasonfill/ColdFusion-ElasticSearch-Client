component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="must" type="array";
	property name="mustNot" type="array";
	property name="should" type="array";
	property name="cache" type="boolean" default="false";

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

		json = '"bool":{#boolStr#}';

		if(getCache()){
				json = json & ',"_cache":true';
			}

		return json;
	}
}
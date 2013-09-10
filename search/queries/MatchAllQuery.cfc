/**
* http://www.elasticsearch.org/guide/reference/query-dsl/match-all-query.html
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="boost" type="numeric";

	public function init(){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = '"match_all":{';
		if(val(getBoost()) > 0){
			json = json & '"boost":#getBoost()#'
		}
		json = json & '}';
		return json;
	}

}
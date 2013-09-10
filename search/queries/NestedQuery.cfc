/**
* http://www.elasticsearch.org/guide/reference/query-dsl/term-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="path" type="string";
	property name="query" type="IQuery";
	property name="scoreMode" type="string" default="avg"; // valid options avg, total, max, none

	public function init(string path="", 
						 IQuery query=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = '"path":"#getPath()#"';

			json =  listAppend(json, '"score_mode":"#getScoreMode()#"');
			json =  listAppend(json, '"query": {#getQuery().toString()#}');

			return '"nested":{#json#}';
	}

}
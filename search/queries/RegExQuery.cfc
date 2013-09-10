/**
* http://www.elasticsearch.org/guide/reference/query-dsl/regexp-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="field";
	property name="regEx";
	property name="boost" type="numeric" default="0";
	property name="flags" type="string" default="";

	public function init(string field="", 
						 string regEx=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var keys = '"value":"#getRegEx()#"';
		
		if(val(getBoost()) > 0){
			keys = listAppend(keys, '"boost":"#getBoost()#"');
		}

		if(len(trim(getBoost())) > 0){
			keys = listAppend(keys, '"flags":"#ucase(replace(getFlags(), ",", "|", "all"))#"');
		}
		return '"regexp":{"#getField()#":{#keys}}#';
	}
}
/**
* http://www.elasticsearch.org/guide/reference/query-dsl/term-query/
**/
component accessors="true" extends="BaseQuery" implements="IQuery"{

	property name="field";
	property name="value";
	property name="boost" type="numeric";

	public function init(string field="", 
						 string value="",
						 string boost=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = '"term":{"#getField()#":';
		if(val(getBoost()) > 0){
			json = json & '{"value":"#getValue()#","boost":#getBoost()#}';
		}else{
			json = json & '"#getValue()#"';
		}
		json = json & '}';
		return json;
	}

}
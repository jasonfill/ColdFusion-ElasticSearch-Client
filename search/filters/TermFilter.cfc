component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field";
	property name="value";
	property name="cache" type="boolean" default="true";

	public function init(string field="", 
						 string value=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = '"term":{"#getField()#":#getValue()#';
		if(!getCache()){
			json = json & ',"_cache":false';
		}
		json = json & '}';
		return json;
	}
}
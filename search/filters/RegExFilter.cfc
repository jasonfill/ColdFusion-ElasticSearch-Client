component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field";
	property name="regEx";
	property name="flags" type="string" default="";
	property name="cache" type="boolean" default="false";
	property name="name" type="string" default="";
	property name="cacheKey" type="string" default="";

	public function init(string field="", 
						 string regEx=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var keys = '"value":"#getRegEx()#"';
		var json = "";
		
		if(val(getBoost()) > 0){
			keys = listAppend(keys, '"boost":"#getBoost()#"');
		}

		if(len(trim(getBoost())) > 0){
			keys = listAppend(keys, '"flags":"#ucase(replace(getFlags(), ",", "|", "all"))#"');
		}

		json = '#getField()#":{#keys}#';

		if(getCache()){
			json = json & ',"_cache":true';
		}

		if(len(trim(getName()))){
			json = json & ',"_name":"#getName()#"';
		}

		if(len(trim(getCacheKey()))){
			json = json & ',"_cache_key":"#getCacheKey()#"';
		}
		return '"regexp":{#json#}';
	}
}
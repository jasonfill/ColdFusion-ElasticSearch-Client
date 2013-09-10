component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field" type="string";
	property name="existence" type="boolean";
	property name="nullValue" type="boolean";

	public function init(string field="", 
						 boolean existence=FALSE, 
						 boolean null_value=FALSE){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var keys = "";

		if(len(trim(getField()))){
			keys = listAppend(keys, '"field":"#getField()#"');
		}
		if(len(trim(getExistence()))){
			keys = listAppend(keys, '"existence":#getExistence()#');
		}
		if(len(trim(getNullValue()))){
			keys = listAppend(keys, '"null_value":#getNullValue()#');
		}
		
		return '"missing":{#keys#}';
	}



}
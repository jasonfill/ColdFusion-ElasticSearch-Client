component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field";
	property name="value";
	
	public function init(string field="", 
						 string value=""){
		super.init(argumentCollection=Arguments);
		return this;
	}
	
	public string function toString(){
		return '"exists":{"#getField()#":"#getValue()#"}';
	}

}
component accessors="true"{
	property name="Name" type="string"; 
	property name="Type" type="string";
	property name="Store" type="string" default="";
	property name="Index" type="string" default="";
	property name="Boost" type="numeric" default="1";
	
	public function init(required string name, required string type, string store="", string index="", numeric boost=1){
		setName(arguments.name);
		setType(arguments.type);	
		setStore(arguments.store);
		setIndex(arguments.index);
		setBoost(arguments.boost);
	}
	
	public string function getJson() {
		var json = '"type":"#getType()#"';
		
		if(Len(getStore()))
			json = ListAppend(json, '"store":"#getStore()#"');
			
		if(Len(getIndex()))
			json = ListAppend(json, '"index":"#getIndex()#"');
			
		if(Len(getBoost()))
			json = ListAppend(json, '"boost":"#getBoost()#"');
			
		return '"#getName()#":{#json#}';
	}
}
component accessors="true"{
	property name="Name" type="string"; 
	property name="FieldMappings" type="array";
	
	public function init(required string name, required array fieldMappings){
		setName(arguments.name);	
		setFieldMappings(arguments.fieldMappings);
	}
	
	public string function getJson() {
		var json = '';	
		for(var fieldMapping in getFieldMappings()){
			json = ListAppend(json, fieldMapping.getJson());	
		}
		
		if(Len(Json) == 0)
			return '';
			
		return '{"#getName()#":{"properties":{#json#}}}';
	}
}
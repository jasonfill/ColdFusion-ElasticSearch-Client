

component accessors="true" extends="BaseModifier" implements="IModifier"{

	property name="fields" type="array" default =[];
	property name="preTags" type="string" default ="";
	property name="postTags" type="string" default ="";

	public function init(required array fields){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var json = "";
		
		json = Len(getPreTags()) ? ListAppend(json, '"pre_tags":["#getPreTags()#"]') : json;
		json = Len(getPostTags()) ? ListAppend(json, '"post_tags":["#getPostTags()#"]') : json;

		
		var fieldsJson = "";
		for(var field in getfields()){
			var fieldJson = "";
			fieldJson = Len(field.getIndexOptions()) ? ListAppend(fieldJson, '"index_options":"#field.getIndexOptions()#"') : fieldJson;
			fieldJson = Len(field.getTermVector()) ? ListAppend(fieldJson, '"term_vector":"#field.getTermVector()#"') : fieldJson;
			fieldJson = Len(field.getType()) ? ListAppend(fieldJson, '"type":"#field.getType()#"') : fieldJson;
			fieldJson = Len(field.getFragmentSize()) ? ListAppend(fieldJson, '"fragment_size":"#field.getFragmentSize()#"') : fieldJson;
			fieldJson = Len(field.getNumberOfFragments()) ? ListAppend(fieldJson, '"number_of_fragments":"#field.getNumberOfFragments()#"') : fieldJson;
			fieldsJson = ListAppend(fieldsJson, '"#field.getName()#":{#fieldJson#}');	
		}
		
		json = ListAppend(json, '"fields":{#fieldsJson#}');
		json = '"highlight":{#json#}';

		return json;
	}
}
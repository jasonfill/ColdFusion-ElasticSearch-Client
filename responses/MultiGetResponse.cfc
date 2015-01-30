component extends="Response" accessors="true" implements="IResponse" {

	property name="docs" type="array";
	property name="docsPointers" type="struct";
	
	public ElasticSearchMapping.responses.MultiGetResponse function init(){
		variables.docs = [];
		variables.docsPointers = {};
		return this;
	}

	public void function handleResponse(){
		var GetResponse = "";
		super.handleResponse(argumentCollection=arguments);

		if(getSuccess()){
			for(var i=1; i<=ArrayLen(getBody().docs); i++){
				GetResponse = new GetResponse();
				GetResponse.setId(getBody().docs[i]["_id"]);
				GetResponse.setIndex(getBody().docs[i]["_index"]);
				GetResponse.setType(getBody().docs[i]["_type"]);
				GetResponse.setExists(getBody().docs[i]["exists"]);

				if(GetResponse.getExists()){
					GetResponse.setVersion(getBody().docs[i]["_version"]);
					GetResponse.setSource(getBody().docs[i]["_source"]);
				}
				variables.docsPointers["#GetResponse.getIndex()#_#GetResponse.getType()#_#GetResponse.getId()#"] = ArrayLen(getDocs()) + 1;
				arrayAppend(getDocs(), GetResponse);
			}
		}
	}

	public any function getDoc(required string index, required string type, required string id){
		if(structKeyExists(variables.docsPointers, "#arguments.index#_#arguments.type#_#arguments.id#")){
			return docs[variables.docsPointers["#arguments.index#_#arguments.type#_#arguments.id#"]];
		}
	}
}
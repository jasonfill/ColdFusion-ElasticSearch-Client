component extends="Response" accessors="true" implements="IResponse" {

	property name="Index";
	property name="Type";
	property name="Id";
	property name="Version";
	property name="Error";
	property name="Exists" type="boolean" default="true";
	property name="ok" type="boolean" default="true";

	public ElasticSearchMapping.responses.IndexResponse function init(){
		return this;
	}

	public void function handleResponse(){
		super.handleResponse(argumentCollection=arguments);
		if(getSuccess()){
			if(structKeyExists(getBody(), "_index")){
				setIndex(getBody()["_index"]);
			}
			if(structKeyExists(getBody(), "_type")){
				setType(getBody()["_type"]);
			}
			if(structKeyExists(getBody(), "_id")){
				setId(getBody()["_id"]);
			}
			if(structKeyExists(getBody(), "_version")){
				setVersion(getBody()["_version"]);
			}
			if(structKeyExists(getBody(), "exists")){
				setExists(getBody()["exists"]);
			}
			if(structKeyExists(getBody(), "ok") && !getBody()["ok"]){
				setSuccess(false);
			}
		}
	}
}
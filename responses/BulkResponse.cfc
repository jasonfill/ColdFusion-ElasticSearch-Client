component extends="Response" accessors="true" implements="IResponse" {

	property name="successes";
	property name="failures";
	
	public BulkResponse function init(){
		variables.successes = [];
		variables.failures = [];
		return this;
	}

	public void function handleResponse(){
		var IndexResponse = "";
		var Container = "index";
		super.handleResponse(argumentCollection=arguments);

		if(getSuccess()){
			for(var i=1; i<=ArrayLen(getBody().items); i++){
				
				// TODO: we need to create UPDATE and DELETE responses so those can be used as needed.
				IndexResponse = new IndexResponse();

				Container = listFirst(structKeyList(getBody().items[i]));

				IndexResponse.setId(getBody().items[i][Container]["_id"]);
				IndexResponse.setIndex(getBody().items[i][Container]["_index"]);
				IndexResponse.setType(getBody().items[i][Container]["_type"]);
				
				if(structKeyExists(getBody().items[i][Container], "exists")){
					IndexResponse.setExists(getBody().items[i][Container]["exists"]);
				}
				
				if(structKeyExists(getBody().items[i][Container], "error")){
					IndexResponse.setError(getBody().items[i][Container]["error"]);
					IndexResponse.setSuccess(false);
					IndexResponse.setOk(false);
				}else{
					IndexResponse.setOk(getBody().items[i][Container]["ok"]);
					IndexResponse.setSuccess(IndexResponse.getOk());
				}

				if(IndexResponse.getSuccess()){
					IndexResponse.setVersion(getBody().items[i][Container]["_version"]);
					arrayAppend(getSuccesses(), IndexResponse);
				}else{
					arrayAppend(getFailures(), IndexResponse);
				}
			}
		}
	}

	public boolean function hasFailures(){
		return YesNoFormat(arrayLen(getFailures()) > 0);
	}
}
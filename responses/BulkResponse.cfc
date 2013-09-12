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
		super.handleResponse(argumentCollection=arguments);
		
		if(getSuccess()){
			for(var i=1; i<=ArrayLen(getBody().items); i++){
				IndexResponse = new IndexResponse();
				IndexResponse.setId(getBody().items[i].index["_id"]);
				IndexResponse.setIndex(getBody().items[i].index["_index"]);
				IndexResponse.setType(getBody().items[i].index["_type"]);

				if(structKeyExists(getBody().items[i].index, "error")){
					IndexResponse.setError(getBody().items[i].index["error"]);
					IndexResponse.setSuccess(false);
					IndexResponse.setOk(false);
				}else{
					IndexResponse.setOk(getBody().items[i].index["ok"]);
					IndexResponse.setSuccess(IndexResponse.getOk());
				}

				if(IndexResponse.getSuccess()){
					IndexResponse.setVersion(getBody().items[i].index["_version"]);
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
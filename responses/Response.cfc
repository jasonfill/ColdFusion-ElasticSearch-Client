component accessors="true" implements="IResponse"{

	property name="success" type="boolean" default="false";
	property name="message";
	property name="status";
	property name="statuscode";
	property name="body";
	property name="headers";

	public function init(){
		return this;
	}

	public void function handleResponse(){

		var _httpResponse = arguments[1];

		local.content = _httpResponse.FileContent;

		if(getMetaData(local.content).getName() IS "java.io.ByteArrayOutputStream") {
			local.content = _httpResponse.FileContent.toString();
		}

		setStatusCode(_httpResponse.Responseheader.Status_Code);
		setStatus(_httpResponse.Responseheader.Explanation);
		setBody(deserializeJSON(local.content));
		setHeaders(_httpResponse.responseHeader);
		setSuccess(false); // default does not work in CF9

		if(getStatusCode() <= 206 && getStatusCode() >= 200){
			setSuccess(true);
		}
	}

	
}
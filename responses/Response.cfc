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
		
		setStatusCode(_httpResponse.status_code);
		setStatus(_httpResponse.StatusCode);
		setBody(deserializeJSON(_httpResponse.FileContent));
		setHeaders(_httpResponse.responseHeader);

		if(getStatusCode() == "200"){
			setSuccess(true);
		}
	}

	
}
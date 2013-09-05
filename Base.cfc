component output="false" accessors="true" extends="com.appmarkable.base.Service" {

	public function init(){
		return this;
	}

	package struct function doRequest(required string Endpoint, required string Resource, string Method="GET", string Body=""){
		var httpSvc = new http();
		var response = new Response();

			httpSvc.setUrl(arguments.endpoint  & Arguments.Resource);
			httpSvc.setMethod(Arguments.Method);

			if(len(trim(Arguments.Body))){
				httpSvc.addParam(type="body",value=Arguments.Body); 
			}

		var sendResult = httpSvc.send().getPrefix();
		response.setStatusCode(sendResult.status_code);
		response.setStatus(sendResult.StatusCode);
		response.setBody(deserializeJSON(sendResult.FileContent));
		response.setHeader(sendResult.responseHeader);

		if(response.getStatusCode() == "200"){
			response.setSuccess(true);
		}

		return response;

	}

	
	

}
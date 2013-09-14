component accessors="true"{

	property name="active" type="struct";
	property name="serverList" type="struct";
	property name="inactive" type="struct";
	property name="ClusterName" type="string";

	public ClusterManager function init(any nodeConfig=""){
		variables.active = {};
		variables.inactive = {};
		loadConfigFromString(arguments.nodeConfig);
		return this;
	}

	private ClusterManager function loadConfigFromString(required any nodeConfig){
		/*
			config = [{
				host = "",
				port = "",
				path = "",
				secure = "",
				username = "",
				password = ""
			}]
		*/
		var config = "";
		if(isSimpleValue(arguments.nodeConfig) && len(trim(arguments.nodeConfig))){
			if(isJson(arguments.nodeConfig)){
				config = deserializeJSON(arguments.NodeConfig);
			}else{
				throw(message="The node config passed to the ElasticSearch ClusterManager is not a valid JSON string.");
			}
		}else if(isArray(arguments.nodeConfig)){
			config = arguments.nodeConfig;
		}

		for(var c=1; c<=arrayLen(config); c++){
			addServer(new NodeConfig(argumentCollection=config[c]));
		}
		return this;
	}

	public ClusterManager function addServer(required NodeConfig NodeConfig){
		variables.active[arguments.NodeConfig.getServerId()] = arguments.NodeConfig;
		updateServerList();
		return this;
	}

	public ClusterManager function updateServerList(){
		variables.serverList = {active = structKeyList(getActive()), inactive = structKeyList(getInactive())};
		return this;
	}
	
	public string function getEndpoint(){
		 return variables.active[listGetAt(variables.serverList.active, RandRange(1,listLen(variables.serverList.active)))].url();
	}

	public struct function doRequest(string Endpoint=getEndPoint(), required string Resource, string Method="GET", string Body="", string ResponseType="Response"){
		var httpSvc = new http();
		var response = createObject("component", "responses.#arguments.ResponseType#").init();

			if(find("@", arguments.endpoint)){
				var basicAuth = listLast(listFirst(arguments.endpoint, "@"), "/");
				httpSvc.setUsername(listFirst(basicAuth, ":"));
				httpSvc.setPassword(listLast(basicAuth, ":"));
			}

			httpSvc.setUrl(arguments.endpoint  & Arguments.Resource);
			httpSvc.setMethod(Arguments.Method);

			if(len(trim(Arguments.Body))){
				httpSvc.addParam(type="body",value=Arguments.Body); 
			}

		var sendResult = httpSvc.send().getPrefix();

		response.handleResponse(sendResult);

		return response;

	}

}
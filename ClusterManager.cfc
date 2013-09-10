component accessors="true"{

	property name="active" type="struct";
	property name="serverList" type="struct";
	property name="inactive" type="struct";
	property name="ClusterName" type="string";

	public ClusterManager function init(){
		variables.active = {};
		variables.inactive = {};
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

}
component accessors="true" {

	property name="Uri" type="string";
	property name="Method" type="string";
	property name="Body" type="string";
	

	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchMapping.requests.GenericRequest function init(required ElasticSearchMapping.ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager
		return this;
	}

	public ElasticSearchMapping.responses.Response function execute(){
		return getClusterManager().doRequest(resource = getUri(),
												method=getMethod(),
												body=getBody(),
												responseType="Response");
	}

}
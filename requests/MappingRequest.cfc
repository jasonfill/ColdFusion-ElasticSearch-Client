component accessors="true" {

	property name="Index" type="string";
	property name="Type" type="string";
	property name="Body" type="string";

	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchMapping.requests.MappingRequest function init(required ElasticSearchMapping.ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager
		return this;
	}

	public ElasticSearchMapping.responses.Response function execute(){
		return getClusterManager().doRequest(resource = "/#getIndex()#/#getType()#/_mapping",
												method="PUT",
												body=getBody(),
												responseType="Response");
	}

}
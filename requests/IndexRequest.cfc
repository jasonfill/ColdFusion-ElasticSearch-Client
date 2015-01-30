component accessors="true" {

	property name="Index" type="string";
	property name="Type" type="string";
	property name="Id" type="string";
	property name="Body" type="string";

	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchMapping.requests.IndexRequest function init(required ElasticSearchMapping.ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager
		return this;
	}

	public ElasticSearchMapping.responses.IndexResponse function execute(){
		return getClusterManager().doRequest(resource = "/#getIndex()#/#getType()#/#getId()#",
												method="PUT",
												body=getBody(),
												responseType="IndexResponse");
	}

}
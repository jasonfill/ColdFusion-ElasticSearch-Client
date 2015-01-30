component accessors="true" {

	property name="Index" type="string";
	property name="Type" type="string" default="";
	property name="Id" type="string" default="";

	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchMapping.requests.DeleteRequest function init(required ElasticSearchMapping.ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager
		return this;
	}

	public ElasticSearchMapping.responses.Response function execute(){
		var _url = "#getIndex()#/";
		
		if(getType() != "")
			_url &= "#getType()#/";
		
		if(getId() != "")
			_url &= "#getId()#/";		

		return getClusterManager().doRequest(resource = _url,
												method = "DELETE",
												body = "",
												responseType = "Response");
	}
}
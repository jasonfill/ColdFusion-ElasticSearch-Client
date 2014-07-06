component accessors="true" {

	property name="Index" type="string";
	property name="Type" type="string" default="";
	property name="Id" type="string" default="";

	property name="ClusterManager" type="ClusterManager";

	public DeleteRequest function init(required ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager
		return this;
	}

	public Response function execute(){
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
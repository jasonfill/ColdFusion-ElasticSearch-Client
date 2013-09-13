component accessors="true" {

	property name="Index" type="string";
	property name="Type" type="string" default="_all";
	property name="Id" type="string";
	property name="Realtime" type="boolean" default="true";
	property name="SourceOnly" type="boolean" default="false";
	property name="Fields" type="string";
	property name="Routing" type="string";
	property name="Preference" type="string";

	property name="ClusterManager" type="ClusterManager";

	public GetRequest function init(required ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager
		return this;
	}

	public GetResponse function execute(){
		var _url = "/#getIndex()#/#getType()#/#getId()#";

		if(getSourceOnly()){
			_url = _url & "/_source"
		}

		_url = _url & "?realtime=#getRealtime()#";
		
		if(len(trim(getRouting()))){
			_url = _url & "&routing=#getRouting()#";
		}

		if(len(trim(getFields()))){
			_url = _url & "&fields=#getFields()#";
		}


		return getClusterManager().doRequest(resource = _url,
												method="GET",
												body="",
												responseType="GetResponse");
	}
}
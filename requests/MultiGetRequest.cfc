component accessors="true" {

	property name="Items" type="array";
	property name="ClusterManager" type="ClusterManager";
	property name="OutputUtils" type="OutputUtils";

	public MultiGetRequest function init(required ClusterManager ClusterManager, required OutputUtils OutputUtils){
		variables.Items = [];
		variables.ClusterManager = arguments.ClusterManager;
		variables.OutputUtils = arguments.OutputUtils;
		return this;
	}

	public MultiGetRequest function add(required string index, required string type, required string id){
		arrayAppend(getItems(), arguments);
		return this;
	}

	public MultiGetResponse function execute(){

		var MultiGetResponse = getClusterManager().doRequest(resource = "/_mget",
												method="POST",
												body=getBody(),
												responseType="MultiGetResponse");

		return MultiGetResponse;
	}

	public string function getBody(){
		var json = createObject("Java","java.lang.StringBuilder")
		var items = getItems();
		json.append('{docs:[');
		for(var i=1; i<=arrayLen(items); i++){
			if(i>1){
				json.append(',');
			}
			json.append('{"_index":"#items[i].index#","_type":"#items[i].type#","_id":"#items[i].id#"}');
		}
		json.append(']}');

		return json.toString();
	}
}
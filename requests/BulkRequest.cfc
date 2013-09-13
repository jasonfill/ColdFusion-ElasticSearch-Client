component accessors="true" {

	property name="BulkItems" type="array";
	property name="BulkItemPreUpdate" type="MultiGetResponse";
	property name="ClusterManager" type="ClusterManager";
	property name="ElasticSearchClient" type="ElasticSearchClient";
	property name="OutputUtils" type="OutputUtils";
	property name="Transactional" type="boolean" default="false" getter="false" setter="false";

	public BulkRequest function init(boolean Transactional=false, required ClusterManager ClusterManager, required OutputUtils OutputUtils, required ElasticSearchClient ElasticSearchClient){
		variables.BulkItems = [];
		variables.ClusterManager = arguments.ClusterManager;
		variables.OutputUtils = arguments.OutputUtils;
		variables.ElasticSearchClient = arguments.ElasticSearchClient;
		variables.transactional = arguments.Transactional;
		return this;
	}

	public boolean function isTransactional(){
		return variables.Transactional;
	}

	public BulkRequest function add(required IndexRequest IndexRequest){
		arrayAppend(getBulkItems(), arguments.IndexRequest);
		return this;
	}

	public BulkResponse function execute(){
		var Response = "";
		// prior to sending the bulk request, if this is transactional, let's pull up the current state of all the docs that are going to be updated...
		if(isTransactional()){ loadPreUpdateData(); }
		
		var BulkUpdateResponse = getClusterManager().doRequest(resource = "/_bulk",
												method="POST",
												body=getBody(),
												responseType="BulkResponse");
		
		// if this bulk request is transactional and their are failures...go through the rollback process...
		if(isTransactional() && BulkUpdateResponse.hasFailures()){
			//writeoutput(getRollbackBody(BulkUpdateResponse)); abort;
			var RollbackResponse = getClusterManager().doRequest(resource = "/_bulk",
																 method="POST",
																 body=getRollbackBody(BulkUpdateResponse),
																 responseType="BulkResponse");
			// TODO: add better error message output...
			RollbackResponse.setSuccess(false);
			Response=RollbackResponse;
		}else{
			Response=BulkUpdateResponse;
		}
		return Response;
	}

	private string function loadPreUpdateData(){
		var multiGetRequest = getElasticSearchClient().prepareMultiGet();
		var items = getBulkItems();
		for(var i=1; i<=arrayLen(items); i++){
			multiGetRequest.add(index=items[i].getIndex(),type=items[i].getType(),id=items[i].getId());
		}
		setBulkItemPreUpdate(multiGetRequest.execute());
	}

	private string function getRollbackBody(required BulkResponse BulkResponse){
		var json = createObject("Java","java.lang.StringBuilder");
		var successes = BulkResponse.getSuccesses();
		var item = "";
		//writeDump(getBulkItemPreUpdate());
		//writeDump(successes); abort;
		for(var i=1; i<=ArrayLen(successes); i++){
			item=successes[i];
			var GetResponse = getBulkItemPreUpdate().getDoc(index=item.getIndex(), type=item.getType(), id=item.getId());
			// if this is the first version, we need to run a delete
			if(item.getVersion() == 1 || !GetResponse.getExists()){
				json.append('{"delete":{"_index":"#item.getIndex()#","_type":"#item.getType()#","_id":"#item.getId()#"}}#chr(10)#');
			}else{
				// we need to roll this document back to an earlier version...
				if(!isNull(GetResponse)){
					json.append('{"index":{"_index":"#GetResponse.getIndex()#","_type":"#GetResponse.getType()#","_id":"#GetResponse.getId()#"}}#chr(10)#');
					json.append('#GetResponse.sourceToString()##chr(10)#');
				}
			}
		}
		return json.toString();
	}

	public string function getBody(){
		var json = createObject("Java","java.lang.StringBuilder")
		var items = getBulkItems();
		for(var i=1; i<=arrayLen(items); i++){
			json.append('{"index":{"_index":"#items[i].getIndex()#","_type":"#items[i].getType()#","_id":"#items[i].getId()#"}}#chr(10)#');
			json.append("#getOutputUtils().compress(items[i].getBody())##chr(10)#");
		}
		return json.toString();
	}
}
component accessors="true" extends="Base" {

	
	property name="OutputUtils";
	property name="LoggingUtil";
	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchMapping.ElasticSearchClient function init(required ElasticSearchMapping.ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager;
		variables.OutputUtils = new OutputUtils();
	 	return this;
	}

	public ElasticSearchMapping.search.filters.FilterBuilder function filterBuilder(){
		return new search.filters.FilterBuilder();
	}

	public ElasticSearchMapping.search.queries.QueryBuilder function queryBuilder(){
		return new search.queries.QueryBuilder();
	}

	public ElasticSearchMapping.search.facets.FacetBuilder function facetBuilder(){
		return new search.facets.FacetBuilder();
	}

	public ElasticSearchMapping.requests.SearchRequest function prepareSearch(){
		var search = new requests.SearchRequest(argumentCollection=arguments);
			search.setClusterManager(getClusterManager());
		return search;
	}

	public ElasticSearchMapping.requests.IndexRequest function prepareIndex(string index="", string type="", string id=""){
		var index = new requests.IndexRequest(ClusterManager=getClusterManager());
			index.setIndex(arguments.index);
			index.setType(arguments.type);
			index.setId(arguments.id);
		return index;
	}
	
	public ElasticSearchMapping.requests.MappingRequest function prepareMapping(required string index, required string type, required ElasticSearchMapping.indexing.TypeMapping typeMapping){
		var index = new requests.MappingRequest(ClusterManager=getClusterManager());
			index.setIndex(arguments.index);
			index.setType(arguments.type);
			index.setBody(typeMapping.getJson());
		return index;
	}

	public ElasticSearchMapping.requests.BulkRequest function prepareBulk(boolean Transactional=false){
		return new requests.BulkRequest(Transactional=Arguments.Transactional, ClusterManager=getClusterManager(), OutputUtils=getOutputUtils(), ElasticSearchClient=this);
	}

	public ElasticSearchMapping.requests.MultiGetRequest function prepareMultiGet(){
		return new requests.MultiGetRequest(ClusterManager=getClusterManager(), OutputUtils=getOutputUtils());
	}

	public ElasticSearchMapping.requests.GetRequest function prepareGet(string index="", string type="_all", string id=""){
		var get = new requests.GetRequest(ClusterManager=getClusterManager());
		get.setIndex(arguments.index);
		get.setType(arguments.type);
		get.setId(arguments.id);
		return get;
	}
	
	public ElasticSearchMapping.requests.DeleteRequest function prepareDelete(required string index, string type="", string id=""){
		var delete = new requests.DeleteRequest(ClusterManager=getClusterManager());
		delete.setIndex(arguments.index);
		delete.setType(arguments.type);
		delete.setId(arguments.id);
		return delete;
	}
	
	public ElasticSearchMapping.requests.GenericRequest function prepareRequest(required string uri, required string method, required string body){
		var genericRequest = new requests.GenericRequest(ClusterManager=getClusterManager());
		genericRequest.setUri(arguments.uri);
		genericRequest.setMethod(arguments.method);
		genericRequest.setBody(arguments.body);
		return genericRequest;
	}
	
}
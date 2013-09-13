component accessors="true" extends="Base" {

	
	property name="OutputUtils";
	property name="LoggingUtil";
	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchClient function init(required ClusterManager ClusterManager){
		variables.ClusterManager = arguments.ClusterManager;
		variables.OutputUtils = new OutputUtils();
	 	return this;
	}

	public FilterBuilder function filterBuilder(){
		return new search.filters.FilterBuilder();
	}

	public QueryBuilder function queryBuilder(){
		return new search.queries.QueryBuilder();
	}

	public FacetBuilder function facetBuilder(){
		return new search.facets.FacetBuilder();
	}

	public Search function prepareSearch(){
		var search = new Search(argumentCollection=arguments);
			search.setClusterManager(getClusterManager());
		return search;
	}

	public IndexRequest function prepareIndex(string index="", string type="", string id=""){
		var index = new requests.IndexRequest(ClusterManager=getClusterManager());
			index.setIndex(arguments.index);
			index.setType(arguments.type);
			index.setId(arguments.id);
		return index;
	}

	public BulkRequest function prepareBulk(boolean Transactional=false){
		return new requests.BulkRequest(Transactional=Arguments.Transactional, ClusterManager=getClusterManager(), OutputUtils=getOutputUtils(), ElasticSearchClient=this);
	}

	public MultiGetRequest function prepareMultiGet(){
		return new requests.MultiGetRequest(ClusterManager=getClusterManager(), OutputUtils=getOutputUtils());
	}

	public GetRequest function prepareGet(string index="", string type="_all", string id=""){
		var get = new requests.GetRequest(ClusterManager=getClusterManager());
		get.setIndex(arguments.index);
		get.setType(arguments.type);
		get.setId(arguments.id);
		return get;
	}
	
}
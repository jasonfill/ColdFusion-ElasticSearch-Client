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


	public function index(string required id, string required data ){
		var httpSvc = new http();
		var _url = getElasticSearchUrl();
		var oResult = newResult();

		httpSvc.setUrl(_url & "/" & getElasticSearchIndex() & "/" & getElasticSearchDocType() & "/" & arguments.id);
		httpSvc.setMethod("PUT");
		httpSvc.addParam(type="body",value=arguments.data); 

		var sendResult = httpSvc.send().getPrefix();
		
	}

	public function get(string required id ){
		var httpSvc = new http();
		var _url = getElasticSearchUrl();
		var oResult = newResult();

		httpSvc.setUrl(_url & "/" & getElasticSearchIndex() & "/" & getElasticSearchDocType() & "/" & arguments.id);
		httpSvc.setMethod("GET");

		var sendResult = httpSvc.send().getPrefix();
		return sendResult;
		
	}

	public function createAccountAlias(required string account_id){
		var httpSvc = new http();
		var _url = getElasticSearchUrl();
		

		json = '{"actions" : [{"add" : {"index" : "webhooks","alias" : "#arguments.account_id#","filter" : {"term" : {"couchbaseDocument.doc.account_id" : "#arguments.account_id#"}}}}]}';
		httpSvc.setUrl(_url & "/_aliases");
		httpSvc.setMethod("POST");
		httpSvc.addParam(type="body",value=json); 

		var sendResult = httpSvc.send().getPrefix();

	}

	public function manualIndex(required string account_id){
		var httpSvc = new http();
		var _url = getElasticSearchUrl();
		

		json = '{"actions" : [{"add" : {"index" : "webhooks","alias" : "#arguments.account_id#","filter" : {"term" : {"couchbaseDocument.doc.account_id" : "#arguments.account_id#"}}}}]}';
		httpSvc.setUrl(_url & "/_aliases");
		httpSvc.setMethod("POST");
		httpSvc.addParam(type="body",value=json); 

		var sendResult = httpSvc.send().getPrefix();

	}


	public function search(required string alias, string type="", string query='', string sort="[]", string facets="{}", numeric from=0, numeric size=50, boolean excludeDeleted=true){
		var oSearchResult = getModel("SearchResult");
		var httpSvc = new http();
		var _url = getElasticSearchUrl();
		var searchString = "";
		var _query = arguments.query;
		var _from = arguments.from-1;
		if(len(trim(Arguments.alias))){
			_url = _url & "/" & arguments.alias;
		}
		_url = _url & "/_search";
		
		if(!len(trim(_query))){
			_query = '{}';
		}
		
		_query = evaluate(_query);

		if(len(trim(arguments.type))){
			_query["bool"]["must"] = [];
			arrayAppend(_query["bool"]["must"], {term["couchbaseDocument.doc.type"] = arguments.type});

			searchString = replaceNoCase(serialize(_query), "'", '"', "all");
		}
		if(excludeDeleted && structKeyExists(_query, "bool")){
			arrayAppend(_query["bool"]["must"], {term["couchbaseDocument.doc.date_deleted"] = 0});
			//_query["bool"]["must"]["term"]["couchbaseDocument.doc.date_deleted"] = 0;
		}

		searchString = replaceNoCase(serialize(_query), "'", '"', "all");

		//writeDump(searchString); writeDump(_query); abort;

		searchString = replaceNoCase(serialize(_query), "'", '"', "all");

		if(!len(trim(searchString))){
			searchString = '{"match_all":{}}';
		}

		if(_from < 0){
			_from = 0;
		}
		//writeDump(searchString); abort;

		searchString = '{"query":#searchString#,"from":#val(_from)#,"size":#arguments.size#,"sort":#arguments.sort#,"facets":#arguments.facets#}';
		searchString = getOutputUtil().compress(string=searchString, level=3);
		httpSvc.setUrl(_url);
		httpSvc.setMethod("POST");
		httpSvc.addParam(type="body",value=searchString); 

		var sendResult = httpSvc.send().getPrefix();
		//writeDump(sendResult); abort;
		var json = evaluate(sendResult.filecontent);

		if(structKeyExists(json, "hits") && structKeyExists(json.hits, "total")){
			oSearchResult.setHits(json.hits.total);	
		}else{
			oSearchResult.setHits(0);	
		}		
		
		oSearchResult.setSize(arguments.size);
		oSearchResult.setFrom(arguments.from);
		oSearchResult.setSearchString(searchString);
		if(structKeyExists(json, "hits") && structKeyExists(json.hits, "hits")){
			oSearchResult.setResults(json.hits.hits);
		}else{
			oSearchResult.setResults([]);
		}

		return oSearchResult;
	}


}
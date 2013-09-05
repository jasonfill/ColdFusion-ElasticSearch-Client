component accessors="true" extends="com.elasticsearch.Base" {

	property name="ElasticSearchUrl";
	property name="ElasticSearchIndex";
	property name="ElasticSearchDocType";
	
	property name="OutputUtil";
	property name="LoggingUtil";

	property name="ElasticSearchConfig";

	public function init(){
	 	return this;
	}

	public function filterBuilder(){
		return new com.elasticsearch.filter.FilterBuilder();
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
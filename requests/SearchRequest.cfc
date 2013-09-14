/**
* http://www.elasticsearch.org/guide/reference/java-api/search/
**/
component accessors="true" {

	this.SEARCH_TYPES = "query_and_fetch,query_then_fetch,dfs_query_and_fetch,dfs_query_then_fetch,count,scan";

	property name="Indexes" type="array";
	property name="Types" type="array";
	property name="SearchType" type="string" default="query_then_fetch";
	property name="Query" type="IQuery";
	property name="Filter" type="FilterBuilder";
	property name="Facet" type="FacetBuilder";
	property name="From" type="numeric";
	property name="Size" type="numeric";
	property name="Explain" type="boolean";

	property name="ClusterManager" type="ClusterManager";

	public SearchRequest function init(){
		variables.Types = [];
		variables.Indexes = [];
		
		for(var i IN arguments){
			arrayAppend(variables.Indexes, Arguments[i]);
		}
		return this;
	}

	public SearchRequest function setTypes(){
		for(var i IN arguments){
			arrayAppend(variables.Types, Arguments[i]);
		}
		return this;
	}

	public SearchRequest function setSearchType(required string SearchType){
		if(listFindNoCase(this.SEARCH_TYPES, arguments.SearchType)){
			variables.SearchType = arguments.SearchType;
		}else{
			throw(message="Invalid search type, must be one of: #this.SEARCH_TYPES#.");
		}
		return this;
	}

	public string function searchString(){
		var json = '';

		if(!isNull(getFilter())){
			json = '{"filtered":{';
		}

		if(!isNull(getQuery())){
			json = json & '{"query":{#getQuery().toString()#}';
		}

		if(!isNull(getFilter())){
			json = json & '{"filter":{#getFilter().toString()#}';
		}

		if(!isNull(getFilter())){
			json = json & '}';
		}

		json = json & '}';

		return json;
	}


	public SearchResponse function execute(){

		var resource = "_search?search_type=" & getSearchType();

		return getClusterManager().doRequest(endpoint=getClusterManager().getEndPoint(),
											  resource = resource,
											  method="POST",
											  body=searchString(),
											  responseType="SearchResponse");
	}
}
/**
* http://www.elasticsearch.org/guide/reference/java-api/search/
**/
component accessors="true" {

	this.SEARCH_TYPES = "query_and_fetch,query_then_fetch,dfs_query_and_fetch,dfs_query_then_fetch,count,scan";

	property name="Indexes" type="array";
	property name="Types" type="array";
	property name="SearchType" type="string" default="query_then_fetch";
	property name="Query" type="IQuery";
	property name="Filters" type="array";
	property name="Modifiers" type="array";
	property name="Facet" type="FacetBuilder";
	property name="From" type="numeric";
	property name="Size" type="numeric";
	property name="Explain" type="boolean";

	property name="ClusterManager" type="ClusterManager";

	public ElasticSearchMapping.requests.SearchRequest function init(){
		variables.Types = [];
		variables.Indexes = [];
		variables.Filters = [];
		variables.Modifiers = [];
		
		for(var i IN arguments){
			arrayAppend(variables.Indexes, Arguments[i]);
		}
		return this;
	}

	public ElasticSearchMapping.requests.SearchRequest function setTypes(){
		for(var i IN arguments){
			arrayAppend(variables.Types, Arguments[i]);
		}
		return this;
	}

	public ElasticSearchMapping.requests.SearchRequest function setSearchType(required string SearchType){
		if(listFindNoCase(this.SEARCH_TYPES, arguments.SearchType)){
			variables.SearchType = arguments.SearchType;
		}else{
			throw(message="Invalid search type, must be one of: #this.SEARCH_TYPES#.");
		}
		return this;
	}

	public string function searchString(){
		var json = '';


		if(!isNull(getQuery())){
			json &= '{';
			if(!isNull(getFrom()) && !isNull(getSize()))
				json &= '"from": #getFrom()#, "size": #getSize()#,';
			
			json = json & '"query":{#getQuery().toString()#}';
		}

	
		if(ArrayLen(getFilters()) > 0){
			json = json & (ArrayLen(getFilters()) > 1 ?  ',"filter":{"and":[' : ',"filter":');
			var filterJson = "";
			for(var filter in getFilters()){
				var filterString = filter.toString();
				if(Len(filterString))
					filterJson = ListAppend(filterJson, '{#filterString#}');
			}
			json = json & filterJson & (ArrayLen(getFilters()) > 1 ?  ']}' : '');
		}
		
		if(ArrayLen(getModifiers()) > 0){
			for(var modifier in getModifiers()){
				json = ListAppend(json, modifier.toString());
			}
		}

		json = json & '}';

		return json;
	}


	public ElasticSearchMapping.responses.SearchResponse function execute(){
		var urlIndexes = Len(getIndexes()[1]) > 0 ? ArrayToList(getIndexes()) & "/" : "";
		var urlTypes = Len(getTypes()[1]) > 0 ? ArrayToList(getTypes()) & "/" : "";
		
		var resource = urlIndexes & urlTypes & "_search?search_type=" & getSearchType();

		return getClusterManager().doRequest(endpoint=getClusterManager().getEndPoint(),
											  resource = resource,
											  method="POST",
											  body=searchString(),
											  responseType="SearchResponse");
	}
}
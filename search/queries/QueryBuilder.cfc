component accessors="true" {
	
	property name="queries";

	public ElasticSearchMapping.search.queries.QueryBuilder function init(){
		variables.queries = [];
		return this;
	}

	public function add(required any query){
		arrayAppend(getQueries(), arguments.query);
		return this;
	}

	public function onMissingMethod(required string MissingMethodName, required array MissingMethodArguments){
		if(findNoCase("query", arguments.MissingMethodName)){
			local.query = createObject("component", "#arguments.MissingMethodName#").init(argumentCollection=MissingMethodArguments);
			add(local.query);
			return local.query;
		}
	}
}
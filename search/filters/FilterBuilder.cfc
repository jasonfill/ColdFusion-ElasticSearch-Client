component accessors="true" {
	
	property name="filters";
	
	public ElasticSearchMapping.search.filters.FilterBuilder function init(){
		variables.filters = [];
		return this;
	}

	public function add(required any filter){
		arrayAppend(getFilters(), arguments.filter);
		return this;
	}
	
	public ElasticSearchMapping.search.filters.IFilter function buildFilter(required string MissingMethodName, required array MissingMethodArguments){
		return onMissingMethod(MissingMethodName, MissingMethodArguments);
	}

	public function onMissingMethod(required string MissingMethodName, required array MissingMethodArguments){
		if(findNoCase("filter", arguments.MissingMethodName)){
			local.filter = createObject("component", "#arguments.MissingMethodName#").init(argumentCollection=MissingMethodArguments);
			add(local.filter);
			return local.filter;
		}
	}
}
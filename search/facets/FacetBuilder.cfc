component accessors="true" {
	
	property name="facets" type="array";

	public FacetBuilder function init(){
		variables.facets = [];
		return this;
	}

	public function add(required any facet){
		arrayAppend(getFacets(), arguments.facet);
		return this;
	}

	public function onMissingMethod(required string MissingMethodName, required array MissingMethodArguments){
		if(findNoCase("facet", arguments.MissingMethodName)){
			local.facet = createObject("component", "#arguments.MissingMethodName#").init(argumentCollection=MissingMethodArguments);
			add(local.facet);
			return local.facet;
		}
	}
}
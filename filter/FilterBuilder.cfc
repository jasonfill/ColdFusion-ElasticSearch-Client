component {
	public function init(){
		return this;
	}

	public function onMissingMethod(required string MissingMethodName, required array MissingMethodArguments){
		if(findNoCase("filter", arguments.MissingMethodName)){
			return createObject("component", "com.elasticsearch.filter.#arguments.MissingMethodName#").init(argumentCollection=MissingMethodArguments);
		}
	}
}
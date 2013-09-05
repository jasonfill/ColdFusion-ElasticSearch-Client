component accessors="true"{

	public function init(){
		for(var i IN arguments){
			variables[i] = arguments[i];
		}
		return this;
	}
}
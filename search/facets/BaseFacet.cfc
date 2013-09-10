component accessors="true"{

	public function init(){
		for(var i IN arguments){
			variables[i] = arguments[i];
		}
		return this;
	}
	public function arrayToStringArray(required array arr){
		var tempList = "";
		for(var t=1; t<=arrayLen(arguments.arr); t++){
			tempList = listAppend(tempList, '"arguments.arr[t]"');
		}
		return '[#tempList#]';
	}
}
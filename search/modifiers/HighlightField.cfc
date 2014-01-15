component accessors="true" {
	property name="name" type="string";
	property name="indexOptions" type="string" default ="";
	property name="termVector" type="string" default ="";
	property name="type" type="string" default ="";
	property name="fragmentSize" type="string" default ="";
	property name="numberOfFragments" type="string" default ="";
	
	public function init(required string name){
		setName(arguments.name);	
	}
}
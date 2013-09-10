component accessors="true" {

	property name="success" type="boolean" default="false";
	property name="message";
	property name="status";
	property name="statuscode";
	property name="body";
	property name="headers";

	public function init(){
		return this;
	}
}
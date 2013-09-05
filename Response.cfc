component accessors="true" {

	property name="success" type="boolean" default="false";
	property name="message";
	property name="status";
	property name="statuscode";
	property name="body";
	property name="header";

	public function init(){
		return this;
	}
}
component extends="Response" accessors="true" {

	property name="Facets";
	property name="FailedShards";
	property name="Hits";
	property name="Took";
	property name="TimedOut";
	property name="SuccessfulShard";
	property name="TotalShards";
	property name="FailedShards";

	public SearchResponse function init(){
		return this;
	}





}
component accessors="true" extends="com.elasticsearch.Base" {

	property name="ElasticSearchClient";

	public function init(){
		this.indicies = {app={}, hook={}};
	 	return this;
	}

	public function configure(any event){
		buildSettings(arguments.event);
		buildIndicies();
	}

	private function buildIndicies(){

		for(var i IN this.indicies){
			// Create the app index...
			local.IndexResponse = doRequest(endpoint=this.indicies[i].endpoint,
											   Resource="/#this.indicies[i].name#/_settings");

			if(!local.IndexResponse.getSuccess() && local.IndexResponse.getStatusCode() == "404"){
				// we need to build this index...
				local.json = '{
								    "settings" : {
								        "number_of_shards" : #this.indicies[i].shards#,
								        "number_of_replicas" : #this.indicies[i].replicas#
								    }
								}';
				local.IndexCreateResponse = doRequest(endpoint=this.indicies[i].endpoint, 
												   Resource="/#this.indicies[i].name#/",
												   Method="PUT",
												   Body=local.json);

				if(!local.IndexCreateResponse.getSuccess()){
					throw(message="There was an error creating the #this.indicies[i].name# for the #getClusterRegion()# region.",
						  detail = local.IndexCreateResponse.getMessage());
				}
			}
		}
	}


	private void function buildSettings(any event){
		var appProperties = getSettings().getAllProperties();
		variables.ClusterRegion = arguments.event.getClusterRegion();

		for(var i IN this.indicies){
			local.settings = {};
			if(structKeyExists(appProperties, "elasticsearch.region.#variables.ClusterRegion#.#i#")){
				local.settings.Name = getSettings().getProperty("elasticsearch.region.#variables.ClusterRegion#.#i#");
			}
			if(structKeyExists(appProperties, "elasticsearch.region.#variables.ClusterRegion#.#i#.url")){
				local.settings.EndPoint = getSettings().getProperty("elasticsearch.region.#variables.ClusterRegion#.#i#.url");
			}			
			if(structKeyExists(appProperties, "elasticsearch.region.#variables.ClusterRegion#.#i#.Replicas")){
				local.settings.Replicas = getSettings().getProperty("elasticsearch.region.#variables.ClusterRegion#.#i#.Replicas");
			}
			if(structKeyExists(appProperties, "elasticsearch.region.#variables.ClusterRegion#.#i#.Shards")){
				local.settings.Shards = getSettings().getProperty("elasticsearch.region.#variables.ClusterRegion#.#i#.Shards");
			}
			this.indicies[i] = local.settings;
		}
	}


}
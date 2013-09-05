component accessors="true"{
	// http://www.elasticsearch.org/guide/reference/java-api/query-dsl-queries/
	
	property name="field";
	property name="query";
	property name="operator";
	property name="zero_terms_query";
	property name="cutoff_frequency";
	property name="type";
	property name="analyzer";
	property name="max_expansions";


	public function init(){
		return this;
	}

	public function toString(){
		var q = {"match"={}};

		q["match"] = {"#getField()#"={}};
		q["match"]["#getField()#"]["query"] = getQuery();

		


	}


}
{"query":
{
    "match" : {
        "couchbaseDocument.doc.type" : {
            "query" : "user",
            "operator" : "and"
        }
    }
}
}
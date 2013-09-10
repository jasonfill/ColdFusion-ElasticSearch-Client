/**
* http://www.elasticsearch.org/guide/reference/query-dsl/range-filter/
**/

component accessors="true" extends="BaseFilter" implements="IFilter"{

	property name="field";
	property name="from";
	property name="to";
	property name="includeLower" type="boolean";
	property name="includeUpper" type="boolean";
	property name="gt";
	property name="gte";
	property name="lt";
	property name="lte";
	property name="cache" type="boolean" default="false";

	public function init(string field=""){
		super.init(argumentCollection=Arguments);
		return this;
	}

	public string function toString(){
		var keys = "";

		if(len(trim(getFrom()))){
			keys = listAppend(keys, '"from":"#getFrom()#"');
		}
		if(len(trim(getTo()))){
			keys = listAppend(keys, '"to":"#getTo()#"');
		}
		if(len(trim(getIncludeLower()))){
			keys = listAppend(keys, '"include_lower":#getIncludeLower()#');
		}
		if(len(trim(getIncludeUpper()))){
			keys = listAppend(keys, '"include_upper":#getIncludeUpper()#');
		}
		if(len(trim(getGt()))){
			keys = listAppend(keys, '"gt":"#getGt()#"');
		}
		if(len(trim(getGte()))){
			keys = listAppend(keys, '"gte":"#getGte()#"');
		}
		if(len(trim(getLt()))){
			keys = listAppend(keys, '"lt":"#getLt()#"');
		}
		if(len(trim(getLte()))){
			keys = listAppend(keys, '"lte":"#getLte()#"');
		}		
		if(getCache()){
			keys = listAppend(keys, '"_cache":true');
		}
		
		return '"range":{"#getField()#":{#keys#}}';
	}

}
component accessors="true" {

	property name="host" type="string";
	property name="port" type="numeric" default="";
	property name="path" type="string";
	property name="secure" type="boolean";
	property name="username" type="string";
	property name="password" type="string";
	property name="health" type="string" default="ok";

	public NodeConfig function init(string host="", numeric port=0, string path="", boolean secure=false, string username="", string password=""){
		variables.host = arguments.host;
		variables.port = arguments.port;
		variables.path = arguments.path;
		variables.secure = arguments.secure;
		variables.username = arguments.username;
		variables.password = arguments.password;
		return this;
	}

	public function getServerId(){
		return host;
	}

	public function url(){
		var protocol = "http";
		var port = "";
		var basicAuth = "";
		if(getSecure()){
			protocol = "https";
		}

		if(len(trim(getPort())) && (getPort() != 80 && getPort() != 0)){
			port = ":#getPort()#";
		}

		if(len(trim(getUsername())) && len(trim(getPassword()))){
			basicAuth = getUsername() & ":" & getPassword() & "@";
		}
		//build the full url..
		return protocol & "://" & basicAuth & host & port & path & "/";
	}
}
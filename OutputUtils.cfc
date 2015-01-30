component{

	public ElasticSearchMapping.OutputUtils function init(){
		return this;
	}

	public string function compress(required string string, numeric level="3"){
		var stringToCompress = ARGUMENTS.string;
		var compressionLevel = ARGUMENTS.level;

		//TRIM OFF ANY EXTRA SPACES FROM STRING TO BE FILTERED
		stringToCompress = trim(stringToCompress);

		// RUN FILTER BASED ON SPECIFIED COMPRESSION LEVELs
		switch(compressionLevel){
			case "4":
				stringToCompress = reReplace(stringToCompress, "[[:space:]]{2,}", " ", "all");
				stringToCompress = replace(stringToCompress, "> <", "><", "all");
				stringToCompress = reReplace(stringToCompress, "<!--[^>]+>", "", "all");
			break;
			case "3":
				stringToCompress = reReplace(stringToCompress, "[[:space:]]{2,}", " ", "all");
				stringToCompress = replace(stringToCompress, "> <", "><", "all");
				stringToCompress = reReplace(stringToCompress, "<!--[^>]+>", "", "all");
				stringToCompress = replace(stringToCompress, '" : "', '":"', "ALL");
				stringToCompress = replace(stringToCompress, '} , {', '},{', "ALL");
				stringToCompress = replace(stringToCompress, ', "', ',"', "ALL");
				stringToCompress = replace(stringToCompress, '} }', '}}', "ALL");
				stringToCompress = replace(stringToCompress, '} ]', '}]', "ALL");
				stringToCompress = replace(stringToCompress, '[ {', '[{', "ALL");
				stringToCompress = replace(stringToCompress, ' }', '}', "ALL");
				stringToCompress = replace(stringToCompress, '{ ', '{', "ALL");
				stringToCompress = replace(stringToCompress, ' :', ':', "ALL");
				stringToCompress = replace(stringToCompress, ': ', ':', "ALL");
				stringToCompress = replace(stringToCompress, ', ', ',', "ALL");
				stringToCompress = replace(stringToCompress, ' ,', ',', "ALL");
			break;
			case "2":
				stringToCompress = reReplace(stringToCompress, "[[:space:]]{2,}", chr( 13 ), "all");
			break;
			default:
				stringToCompress = reReplace(stringToCompress, "(" & chr( 10 ) & "|" & chr( 13 ) & ")+[[:space:]]{2,}", chr( 13 ), "all");
			break;
		}

		stringToCompress = Replace(stringToCompress, "\r", "", "all");
		stringToCompress = Replace(stringToCompress, "\n", "", "all");
		stringToCompress = Replace(stringToCompress, "\t", "", "all");

		return stringToCompress;
	}

}
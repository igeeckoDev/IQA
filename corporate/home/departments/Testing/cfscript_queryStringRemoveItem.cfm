<cfscript>
/**
 * Deletes a var from a query string.
 * Idea for multiple args from Michael Stephenson
 *
 * @param variable 	 A variable, or a list of variables, to delete from the query string.
 * @param qs 	 Query string to modify. Defaults to CGI.QUERY_STRING.
 * @return Returns a string.
 * @author Nathan Dintenfass
 * @version 1.1, February 24, 2002
 */
function queryStringDeleteVar(variable){
	//var to hold the final string
	var string = "";
	//vars for use in the loop, so we don't have to evaluate lists and arrays more than once
	var ii = 1;
	var thisVar = "";
	var thisIndex = "";
	var array = "";
	//if there is a second argument, use that as the query string, otherwise default to cgi.query_string
	var qs = cgi.query_string;
	if(arrayLen(arguments) GT 1)
		qs = arguments[2];
	//put the query string into an array for easier looping
	array = listToArray(qs,"&");
	//now, loop over the array and rebuild the string
	for(ii = 1; ii lte arrayLen(array); ii = ii + 1){
		thisIndex = array[ii];
		thisVar = listFirst(thisIndex,"=");
		//if this is the var, edit it to the value, otherwise, just append
		if(not listFind(variable,thisVar))
			string = listAppend(string,thisIndex,"&");
	}
	//return the string
	return string;
}
</cfscript>
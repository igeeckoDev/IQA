<cfscript>
/**
 * Converts a query object into an array of structures.
 *
 * @param query 	 The query to be transformed
 * @return This function returns a structure.
 * @author Nathan Dintenfass (nathan@changemedia.com)
 * @version 1, September 27, 2001
 */
function QueryToArrayOfStructures(theQuery){
	var theArray = arraynew(1);
	var cols = ListtoArray(theQuery.columnlist);
	var row = 1;
	var thisRow = "";
	var col = 1;
	for(row = 1; row LTE theQuery.recordcount; row = row + 1){
		thisRow = structnew();
		for(col = 1; col LTE arraylen(cols); col = col + 1){
			thisRow[cols[col]] = theQuery[cols[col]][row];
		}
		arrayAppend(theArray,duplicate(thisRow));
	}
	return(theArray);
}
</cfscript>

<CFQUERY Name="Data" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
From ProgramReportCard_Test
ORDER BY ID
</CFQUERY>


<CFSET arrStruct = QueryToArrayOfStructures(Data)>

<CFDUMP VAR="#arrStruct#">
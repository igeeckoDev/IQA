<br>
<u>Available Actions</u><br />
Click an Icon below to execute each action.<br /><br />

<cfoutput>
<FORM ACTION="QueryToExcel.cfm?#cgi.query_String#&refpage=#CGI.Script_Name#&FullTable=Yes" METHOD="POST" NAME="SaveTable">
	<!---<input type="Submit" value="View CARs in Excel"><br>--->
	<input type="image" src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0" Alt="View CARs in Excel" /> - View all CARs from this table in Excel
</form><br>

<FORM ACTION="DataTableToExcel.cfm?#cgi.query_String#&refpage=#CGI.Script_Name#" METHOD="POST" NAME="SaveTable">
	<!---<input type="Submit" value="Output Table to Excel"><br>--->
	<input type="image" src="#SiteDir#SiteImages/folder_up.png" align="absmiddle" border="0" Alt="Output Table to Excel" /> - 
	Output above table in Excel
</form><br>
</cfoutput>
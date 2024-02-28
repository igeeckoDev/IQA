<br>
<u>Available Actions</u><br />
Click an Icon below to execute each action.<br /><br />

<cfoutput>
<FORM ACTION="QueryToExcel.cfm?#cgi.query_String#&refpage=#CGI.Script_Name#&FullTable=Yes" METHOD="POST" NAME="SaveTable">
	<!---<input type="Submit" value="View CARs in Excel"><br>--->
    <input type="image" src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0" Alt="View CARs in Excel" /> - View all CARs from this table in Excel
</form><br>

<FORM ACTION="getEmpNo.cfm?page=SaveQuery" METHOD="POST" name="SaveQuery">
	<input type="hidden" name="PageName" value="#CGI.Script_Name#">
	<input type="hidden" name="QueryString" value="#CGI.Query_String#">
	
	<!---<INPUT TYPE="Submit" value="Save Report"><br>--->
	<input type="image" src="#SiteDir#SiteImages/book_addresses_add.png" align="absmiddle" border="0" Alt="Save Report" /> - Save this page*<br /></form>
<Br>

<FORM ACTION="DataTableToExcel.cfm?#cgi.query_String#&refpage=#CGI.Script_Name#" METHOD="POST" NAME="SaveTable">
	<!---<input type="Submit" value="Output Table to Excel"><br>--->
    <input type="image" src="#SiteDir#SiteImages/folder_up.png" align="absmiddle" border="0" Alt="Output Table to Excel" /> - 
	Output above table in Excel
</form><br>

* <u>Note</u> - You will be able to return to the site and view this page/report with updated GCAR Data by seleting the menu item <a href="getEmpNo.cfm?page=ViewQueries">View Your Saved Reports</a> or <a href="ViewQueries.cfm?EmpNo=All">View All Saved Reports</a>.<br />
</cfoutput>
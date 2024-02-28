<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="KPI - Manage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) as maxID, MIN(ID) as MinID
FROM KPI
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM KPI
ORDER BY Year_, Month, PeriodEnding
</CFQUERY>

<u>Available Actions</u><br>
<cfif MaxID.MinID neq 0>
 :: <a href="KPI_Add.cfm"><b>Add</b></a> New KPI Data (Add Month)
<cfelse>
 :: <a href="KPI_Edit.cfm?ID=0"><b>Edit</b></a> Draft KPI Data
</cfif>
<br><br>
	 
<table border=1>
<tr>
	<th>ID</th>
	<th>Year</th>
	<th>Month</th>
	<th>Date Posted</th>
	<th>View Data Table</th>
	<th>View Historical KPIs</th>
	<th>Period Ending</th>
</tr>
	<cfoutput query="KPI">
	<tr>
		<td align="center" width="150">#ID# <cfif ID eq 0>DRAFT DATA<cfelseif ID eq maxID.maxID>PUBLISHED DATA</cfif></td>
		<td align="center">#Year_#</td>
		<td align="center">#Month#</td>
		<td align="center">#dateformat(datePosted, "mm/dd/yyyy")#</td>
		<td align="center"><a href="KPI_View.cfm?ID=#ID#">View</a></td>
		<td align="center"><a href="#IQADir#KPI.cfm?ID=#ID#" target="_blank">View</a></td>
		<td align="center">#Dateformat(PeriodEnding, "mm/dd/yyyy")#</td>
	</tr>
	</cfoutput>
</table>
				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
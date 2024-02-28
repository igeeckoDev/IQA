<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Internal Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="OfficeStats">
SELECT * FROM iReportOffice
WHERE OfficeName = '#url.officename#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ViewAudits">
SELECT * FROM iReportAudits
WHERE OfficeName = '#url.officename#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>				  
<br><u><b>#url.Year# Internal Audit Report</b></u> - <u><b>#url.OfficeName#</b></u><br>
Select year: 
<A href="iReport_Office.cfm?officename=#url.officename#&year=2006">2006</A> ::  
<a href="iReport_Office.cfm?officename=#url.officename#&year=2007">2007</A><br>
</cfoutput><br>

<cfif OfficeStats.recordcount is "0">
<br>There have been no audits conducted for this office in <cfoutput>#URL.Year#</cfoutput>.<br>
<cfelse>

<cfquery name="KP" Datasource="Corporate">
SELECT * FROM KeyProcesses
ORDER BY ID
</cfquery>

<Table>
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="400" valign="top">
<tr><td class="blog-content" valign="top"><b>Key Processes</b></td></tr>
<cfoutput query="KP">
<tr>
<td class="blog-content">
#KP#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 1>
<cfoutput query="ViewAudits">
<td class="blog-content">

<Table border="1">
<tr><td class="blog-content" align="center">#year#-#id#</td></tr>
<cfloop list="#ViewAudits.ColumnList#" index="col">
<cfif col is "Year" or col is "OfficeName" or col is "AuditType" or col is "AuditedBy" or col is "ID">
<cfelse>
<tr>
 	<td class="blog-content" align="center" width="80" nowrap>
		#round(ViewAudits[col][i])#
	</td></tr> 
</cfif>
</cFLOOP>
<cfset i = i+1>
</TABLE>

</td>
 </cfoutput>
</tr>
</TABLE>
<br>
<table>
<tr class="blog-content">
	<td class="blog-content">
<br>
*These Audit Coverage is comprised of the audits listed below.<br><br>

<cfset i = 1>
<cfoutput query="ViewAudits">
#i#: <a href="auditdetails.cfm?year=#year#&id=#id#">#Year#-#ID#</a><br>
<cfset i = i + 1>
</cfoutput><br>
	</td>
</tr>
</table>

</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

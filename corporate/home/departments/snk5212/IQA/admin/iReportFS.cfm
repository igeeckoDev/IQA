<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Field Service - IQA Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FSStats">
SELECT * FROM iReportFS
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ViewAuditList">
SELECT * FROM iReportFSAudits
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>				  
<br><u><b>#url.Year# Internal Audit Report</b></u> - <u><b>Field Services</b></u><br>
Select year: 
<A href="iReportFS.cfm?year=2006">2006</A> ::  
<a href="iReportFS.cfm?year=2007">2007</A><br>
</cfoutput><br>

<cfif FSStats.recordcount is "0">
<br>There have been no audits conducted for Field Services in <cfoutput>#URL.Year#</cfoutput>.<br>
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
<cfoutput query="KP" startrow="1" maxrows="17">
<tr>
<td class="blog-content">
#KP#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 1>
<cfoutput query="FSStats" group="year">
<td class="blog-content">

<Table border="1">
<tr><td class="blog-content" align="center" nowrap><b>Noncompliance and Preventive actions</b></td></tr>
<cfloop list="#FSStats.ColumnList#" index="col">
<cfif col is "Year" or col is "AuditType2" or col is "AuditedBy">
<cfelse>
<tr>
 	<td class="blog-content" align="center">
		#round(FSStats[col][1])#
	</td></tr> 
</cfif>
<cfset i = i+1>
</cFLOOP>
</TABLE>

</td>
 </cfoutput>
</tr>
<tr class="blog-content">
	<td class="blog-content" colspan="2">
<br>
*The data above is comprised of the audits listed below.<br><br>

<cfset i = 1>
<cfoutput query="ViewAuditList">
#i#: <a href="auditdetails.cfm?year=#year#&id=#id#">#Year#-#ID#</a> - #officename# [#Area#]<br>
<cfset i = i + 1>
</cfoutput><br>
	</td>
</tr>
</TABLE>

</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

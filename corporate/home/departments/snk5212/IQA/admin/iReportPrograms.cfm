<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Program Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfif url.area is "NACPO">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ProgStats">
	SELECT * FROM iReportNACPO
	WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ViewAudits">
	SELECT * FROM iReportProgramAudits
	WHERE 
	Manager = 'Carney, W.'
	AND year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	</cfquery>	
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ProgStats">
	SELECT * FROM iReportPrograms
	WHERE 
	Area = '#url.Area#'
	and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ViewAudits">
	SELECT * FROM iReportProgramAudits
	WHERE 
	Area = '#url.Area#'
	and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	</cfquery>
</cfif>

<cfoutput>				  
<br><u><b>#url.Year# Program Report</b></u> - <u><cfif url.area is "NACPO">NACPO Programs<cfelse>#url.Area#</cfif></u>*<br>
</cfoutput><br>

<cfif ProgStats.recordcount is "0">
<br>There have been no audits conducted for this program in <cfoutput>#URL.Year#</cfoutput>.<br>
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
<cfoutput query="ProgStats" group="year">
<td class="blog-content">

<Table border="1">
<tr><td class="blog-content" align="center"><b>Noncompliance and Preventive actions</b></td></tr>
<cfloop list="#ProgStats.ColumnList#" index="col">
<cfif col is "Year" or col is "AuditType2" or col is "AuditedBy" or col is "Area" or col is "progowner" or col is "manager" or col is "Officename" or col is "ID">
<cfelse>
<tr>
 	<td class="blog-content" align="center">
		#round(ProgStats[col][i])#
	</td></tr> 
</cfif>
</cFLOOP>
<cfset i = i+1>
</TABLE>

</td>
 </cfoutput>
</tr>
</table>
<br>
<table>
<tr class="blog-content">
	<td class="blog-content">
*The data above is comprised of the audits listed below:<br><br>

<cfset ProgHolder=""> 

<CFOUTPUT Query="ViewAudits"> 
<cfif ProgHolder IS NOT Area> 
<cfIf ProgHolder is NOT ""><br></cfif>
#Area#<br> 
</cfif>
&nbsp;&nbsp; - <a href="auditdetails.cfm?year=#year#&id=#id#">#Year#-#ID#</a> :: #OfficeName#<br>
<cfset ProgHolder = Area>
</CFOUTPUT><br>
	</td>
</tr>
</TABLE>

</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

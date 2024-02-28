<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Coverage - #URL.OfficeName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfset Startyear = #curyear# - 2>
<cfset NextYear = #startyear# + 1>
<cfset TwoYear = #startyear# + 2>
						  
<cfquery name="Output" Datasource="Corporate">
SELECT Report4.*, AuditSchedule.OfficeName as OfficeName, AuditSchedule.Area as Area
FROM Report4, AuditSchedule
WHERE AuditSchedule.ID = Report4.ID
AND AuditSchedule.Year_ = Report4.Year_
AND AuditSchedule.OfficeName = '#URL.OfficeName#' 
AND Report4.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND Report4.AuditedBy = '#AuditedBy#'
</cfquery>

<cfoutput>
<b><u>Audit Coverage #URL.Year# - #OfficeName#</u></b><br>
Select year: 
<A href="audit_coverage2.cfm?Year=#startyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#startyear#</A> ::  
<a href="audit_coverage2.cfm?Year=#nextyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#nextyear#</A> :: 
<A href="audit_coverage2.cfm?Year=#twoyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#twoyear#</A><br>
</cfoutput>
<br>

<div align="Left" class="blog-time">
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

<cfoutput>
<a href="Audit_Coverage.cfm?Year=#URL.Year#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">Expand</a> Coverage<br>
<!---<a href="Audit_Plan2.cfm?OfficeName=#URL.OfficeName#&Start=#StartYear#&AuditedBy=#AuditedBy#">View</a> Audit Plan<br>--->
</cfoutput>

<cfif output.recordcount is "0">
<br>There have been no audits conducted for this office in <cfoutput>#URL.Year#</cfoutput>.<br>
<cfelse>
<br>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM clauses_2010sept1
ORDER BY ID
</cfquery>

<Table width="700">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="650" valign="top">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="Clauses">
<tr>
<td class="blog-content">
#title#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 1>
<cfset C=ArrayNew(1)>
<cfloop index="j" from="1" to="37">
	<CFSET C[j] = 0>
</cfloop>

<cfset j = 1>
<cfoutput query="output" group="ID">
<cfloop list="#output.ColumnList#" index="col">
	<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "Comments" or col is "Placeholder">
    <cfelse>
        <cfif output[col][i] IS "1">
            <cfset C[j]= C[j]+1>
        </cfif>
        <cfset J = J+1>  
    </cfif>  
	<cfif J eq 37>
		<cfset J = 1>
	</cfif>
</cFLOOP>
<cfset i = i+1>
</cfoutput>

<cfoutput>
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b><a href="Audit_Coverage.cfm?Year=#URL.Year#&OfficeName=#URL.OfficeName#">#Year#</a></b></td></tr>
<cfloop index="j" from="1" to="37">
<tr>
 <td class="blog-content" align="center">
  <cfif c[j] gte 1>
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
</cfloop>
</TABLE>

</td>
</cfoutput>
</tr>
</TABLE>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->


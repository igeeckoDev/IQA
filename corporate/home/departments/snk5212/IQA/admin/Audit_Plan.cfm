<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Audit Plan">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset Start = #url.Start#>
<cfset End = #url.Start# + 2>
<cfset Middle = #url.start# + 1>

<cflock scope="SESSION" timeout="60">
    <cfquery name="plan" Datasource="Corporate"> 
    SELECT * FROM Plan
    WHERE OfficeName = '#URL.OfficeName#' 
    AND START_ = #URL.Start#
    <CFIF SESSION.Auth.AccessLevel is "SU" 
        OR SESSION.Auth.AccessLevel is "Admin" 
        or SESSION.Auth.AccessLevel is "IQAAuditor" 
        or SESSION.Auth.AccessLevel is "Auditor"> 
    AND AuditedBy = 'IQA'
    <cfelse>
    AND AuditedBy = '#SESSION.Auth.SubRegion#'
    </cfif>
    ORDER BY YEAR_, START_
    </cfquery>
</cflock>

<cfif plan.recordcount is 0>
<cfoutput>						  
<b><u>3 Year Audit Plan - #URL.OfficeName# (#URL.Start# - #End#) - #AuditedBy#</u></b><br><br>

<div align="Left" class="blog-time">
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

There is currently no Audit Plan data available.<br><br>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#URL.Start#&auditedby=#URL.AuditedBy#">Add</a> Audit Plan for #URL.Start#<br>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#middle#&auditedby=#URL.AuditedBy#">Add</a> Audit Plan for #Middle#<br>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#End#&auditedby=#URL.AuditedBy#">Add</a> Audit Plan for #End#<br><br>
</cfoutput>
<cfelse>

<cflock scope="SESSION" timeout="60">
<cfoutput>						  
<b><u>3 Year Audit Plan - #URL.OfficeName# (#URL.Start# - #End#) - #URL.AuditedBy#</u></b><br><br>

<div align="Left" class="blog-time">
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

<a href="Audit_plan2.cfm?officename=#url.officename#&start=#URL.Start#&auditedby=#URL.AuditedBy#">View</a> audit plan and audit coverage together (Plan vs Actual)<br><br>

<cfquery name="A" Datasource="Corporate"> 
SELECT * FROM Plan
WHERE OfficeName = '#URL.OfficeName#' 
AND START_ = #URL.Start# 
AND YEAR_ = #URL.Start#
<CFIF SESSION.Auth.AccessLevel is "SU" 
	OR SESSION.Auth.AccessLevel is "Admin" 
	or SESSION.Auth.AccessLevel is "IQAAuditor" 
	or SESSION.Auth.AccessLevel is "Auditor"> 
AND AuditedBy = 'IQA'
<cfelse>
AND AuditedBy = '#SESSION.Auth.SubRegion#'
</cfif>
</cfquery>

<u>Enter Plans</u><br>
<cfif A.recordcount is 1>
<a href="Audit_plan_edit.cfm?officename=#url.officename#&start=#URL.Start#&year=#URL.Start#&auditedby=#URL.AuditedBy#">Edit</a> Audit Plan for #URL.Start#<br>
<cfelse>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#URL.Start#&auditedby=#URL.AuditedBy#"><b>Add</b></a> Audit Plan for #URL.Start#<br>
</cfif>

<cfquery name="B" Datasource="Corporate"> 
SELECT * FROM Plan
WHERE OfficeName='#URL.OfficeName#' 
AND START_ = #URL.Start# 
AND YEAR_ = #Middle#
<CFIF SESSION.Auth.AccessLevel is "SU" 
	OR SESSION.Auth.AccessLevel is "Admin" 
	or SESSION.Auth.AccessLevel is "IQAAuditor" 
	or SESSION.Auth.AccessLevel is "Auditor"> 
AND AuditedBy = 'IQA'
<cfelse>
AND AuditedBy = '#SESSION.Auth.SubRegion#'
</cfif>
</cfquery>

<cfif B.recordcount is 1>
<a href="Audit_plan_edit.cfm?officename=#url.officename#&start=#URL.Start#&year=#middle#&auditedby=#URL.AuditedBy#">Edit</a> Audit Plan for #Middle#<br>
<cfelse>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#middle#&auditedby=#URL.AuditedBy#"><b>Add</b></a> Audit Plan for #Middle#<br>
</cfif>

<cfquery name="C" Datasource="Corporate"> 
SELECT * FROM Plan
WHERE OfficeName='#URL.OfficeName#' 
AND START_ = #URL.Start# 
AND YEAR_ = #End#
<CFIF SESSION.Auth.AccessLevel is "SU" 
	OR SESSION.Auth.AccessLevel is "Admin" 
	or SESSION.Auth.AccessLevel is "IQAAuditor" 
	or SESSION.Auth.AccessLevel is "Auditor"> 
AND AuditedBy = 'IQA'
<cfelse>
AND AuditedBy = '#SESSION.Auth.SubRegion#'
</cfif>
</cfquery>

<cfif C.recordcount is 1>
<a href="Audit_plan_edit.cfm?officename=#url.officename#&start=#URL.Start#&year=#End#&auditedby=#URL.AuditedBy#">Edit</a> Audit Plan for #End#<br><br>
<cfelse>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#End#&auditedby=#URL.AuditedBy#"><b>Add</b></a> Audit Plan for #End#<br><br>
</cfif>

<u>Comments</u><br>
<cfif A.recordcount is 1>
<cfif A.Comments is "Null" or A.Comments is "">
<a href="audit_plan_comments.cfm?officename=#url.officename#&start=#URL.Start#&year=#url.start#&auditedby=#URL.AuditedBy#"><b>Add</b></a> Audit Plan Comments for #url.start#<br>
<cfelse>
<a href="audit_plan_comments.cfm?officename=#url.officename#&start=#URL.Start#&year=#url.start#&auditedby=#URL.AuditedBy#">Edit</a> Audit Plan Comments for #url.start#<br>
</cfif>
</cfif>

<cfif B.recordcount is 1>
<cfif B.Comments is "Null" or B.Comments is "">
<a href="audit_plan_comments.cfm?officename=#url.officename#&start=#url.start#&year=#middle#&auditedby=#URL.AuditedBy#"><b>Add</b></a> Audit Plan Comments for #middle#<br>
<cfelse>
<a href="audit_plan_comments.cfm?officename=#url.officename#&start=#url.start#&year=#middle#&auditedby=#URL.AuditedBy#">Edit</a> Audit Plan Comments for #middle#<br>
</cfif>
</cfif>

<cfif C.recordcount is 1>
<cfif C.Comments is "Null" or C.Comments is "">
<a href="audit_plan_comments.cfm?officename=#url.officename#&start=#URL.Start#&year=#end#&auditedby=#URL.AuditedBy#"><b>Add</b></a> Audit Plan Comments for #end#<br>
<cfelse>
<a href="audit_plan_comments.cfm?officename=#url.officename#&start=#URL.Start#&year=#end#&auditedby=#URL.AuditedBy#">Edit</a> Audit Plan Comments for #end#<br>
</cfif>
<cfelse>
<br>
</cfif>
</cfoutput>
</cflock>

<cfoutput query="Plan">
<cfif Comments is "Null" or Comments is "">
<cfelse>
<b><u>Comments - #year_#</u></b><br>
#Comments#<br><br>
</cfif>
</cfoutput>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses_2010SEPT1
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
<cfset n = 1>
<cfoutput query="plan">
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b>#year_#</b></td></tr>
<cfloop list="#plan.ColumnList#" index="col">
<cfif col is "Start_" or col is "Placeholder" or col is "Year_" or col is "OfficeName" or col is "Comments" or col is "AuditedBy">
<cfelse>
<tr>
 <td class="blog-content" align="center">
 <cfif year_ is #middle# and b.recordcount is 0>--<br>
 <cfelseif year_ is #End# and c.recordcount is 0>--<br>
 <cfelse>
  <cfif plan[col][n] IS "1">
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
 </cfif>
</td></tr> 
</cfif>  
</cFLOOP>
</TABLE>

</td>
<cfset n = n+1>
</cfoutput>
</tr>
</TABLE>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
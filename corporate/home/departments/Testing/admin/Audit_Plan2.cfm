<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Audit Plan and Coverage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset Start = #url.Start#>
<cfset Middle = #url.start# + 1>
<cfset End = #url.Start# + 2>

<cflock scope="SESSION" timeout="60">
    <cfquery name="plan" Datasource="Corporate"> 
    SELECT * FROM Plan
    WHERE OfficeName='#URL.OfficeName#' AND START_=#URL.Start#
    <CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor"> AND  AuditedBy = 'IQA'
    <cfelse>
    AND  AuditedBy = '#SESSION.Auth.Region#'
    </cfif>
    ORDER BY YEAR_,START_
    </cfquery>
</cflock>

<cfif plan.recordcount is 0>
<cfoutput>						  
<b><u>3 Year Audit Plan and Actual Coverage- #URL.OfficeName# (#URL.Start# - #End#) - #AuditedBy#</u></b><br><br>
There is currently no Audit Plan data available.<br><br>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#URL.Start#&auditedby=#URL.AuditedBy#">Add</a> Audit Plan for #URL.Start#<br>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#middle#&auditedby=#URL.AuditedBy#">Add</a> Audit Plan for #Middle#<br>
<a href="Audit_plan_add.cfm?officename=#url.officename#&start=#URL.Start#&year=#End#&auditedby=#URL.AuditedBy#">Add</a> Audit Plan for #End#<br><br>
</cfoutput>
<cfelse>

<cflock scope="SESSION" timeout="60">
<cfoutput>						  
<b><u>3 Year Audit Plan and Actual Coverage - #URL.OfficeName# (#URL.Start# - #End#) - #url.AuditedBy#</u></b><br><br>

<div align="Left" class="blog-time">
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

<a href="Audit_plan.cfm?officename=#url.officename#&start=#URL.Start#&auditedby=#URL.AuditedBy#">View</a> Audit Plan Separately<br><br>

<cfquery name="A" Datasource="Corporate"> 
SELECT * FROM Plan
WHERE OfficeName='#URL.OfficeName#' 
AND START_=#URL.Start# AND YEAR_=#URL.Start#
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor"> AND  AuditedBy = 'IQA'
<cfelse>
AND  AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>

<cfquery name="B" Datasource="Corporate"> 
SELECT * FROM Plan
WHERE OfficeName='#URL.OfficeName#' 
AND START_=#URL.Start# AND YEAR_=#Middle#
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor"> AND  AuditedBy = 'IQA'
<cfelse>
AND  AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>

<cfquery name="C" Datasource="Corporate"> 
SELECT * FROM Plan
WHERE OfficeName='#URL.OfficeName#' 
AND START_=#URL.Start# AND YEAR_=#End#
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor"> AND  AuditedBy = 'IQA'
<cfelse>
AND  AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cfoutput>
</cflock>

<cfoutput query="plan">
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
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b><br>&nbsp;</td></tr>
<cfoutput query="Clauses">
<tr>
<td class="blog-content">
#title#
</td></tr> 
</cfoutput>

</table>

</td>

<!--- first year, plan --->

<cfset n = 1>
<cfoutput query="A">
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b>Plan<br>#year_#</b></td></tr>
<cfloop list="#A.ColumnList#" index="col">
<cfif col is "Start_" or col is "Placeholder" or col is "Year_" or col is "OfficeName" or col is "Comments" or col is "auditedby">
<cfelse>
<tr>
 <td class="blog-content" align="center">
  <cfif A[col][n] IS "1">
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
</cfif>  
</cFLOOP>
</TABLE>

</td>
<cfset n = n+1>
</cfoutput>

<!--- first year, actual --->

<cflock scope="SESSION" timeout="60">
<cfquery name="D" Datasource="Corporate">
SELECT * FROM Query
WHERE OfficeName='#URL.OfficeName#' AND Year_='#URL.Start#'
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor">
AND AuditedBy = 'IQA'
<cfelse>
AND AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cflock>

<cfset i = 1>
<cfset C=ArrayNew(1)>
<cfloop index="j" from="1" to="37">
<CFSET C[j] = 0>
</cfloop>

<cfset j = 1>
<cfoutput query="D" group="ID">
<cfloop list="#D.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby">
<cfelse>
  <cfif D[col][i] IS "1">
  	<cfset C[j]= C[j]+1>
	<cfelse>
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
<tr><td class="blog-content" align="center"><b><a href="Audit_Coverage.cfm?Year=#A.Year_#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">Actual</a><br>#A.year_#</b></td></tr>
<cfloop index="j" from="1" to="37">
<tr>
 <td class="blog-content" align="center">
 <cfif D.recordcount is 0>
 --
 <cfelse>
  <cfif c[j] gte 1>
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
  </cfif>
</td></tr> 
</cfloop>
</TABLE>

</td>
</cfoutput>

<!--- second year, Plan --->

<cfset n = 1>
<cfoutput query="B">
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b>Plan<br>#year_#</b></td></tr>
<cfloop list="#B.ColumnList#" index="col">
<cfif col is "Start" or col is "Placeholder" or col is "Year_" or col is "OfficeName" or col is "Comments" or col is "auditedby">
<cfelse>
<tr>
 <td class="blog-content" align="center">
 <cfif year_ is #middle# and b.recordcount is 0>--<br>
 <cfelse>	
  <cfif B[col][n] IS "1">
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

<!--- second year, actual --->

<cfif curyear LT middle>
<cfelse>

<cflock scope="SESSION" timeout="60">
<cfquery name="E" Datasource="Corporate">
SELECT * FROM Query
WHERE OfficeName='#URL.OfficeName#' AND Year_='#Middle#'
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor">
AND AuditedBy = 'IQA'
<cfelse>
AND AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cflock>

<cfset i = 1>
<cfset C=ArrayNew(1)>
<cfloop index="j" from="1" to="37">
<CFSET C[j] = 0>
</cfloop>

<cfset j = 1>
<cfoutput query="E" group="ID">
<cfloop list="#E.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby">
<cfelse>
  <cfif E[col][i] IS "1">
  	<cfset C[j]= C[j]+1>
	<cfelse>
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
<tr><td class="blog-content" align="center"><b>Actual<br>#B.year_#</b></td></tr>
<cfloop index="j" from="1" to="37">
<tr>
 <td class="blog-content" align="center">
 <cfif E.recordcount is 0>
 --
 <cfelse>
  <cfif c[j] gte 1>
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
  </cfif>
</td></tr> 
</cfloop>
</TABLE>

</td>
</cfoutput>

</cfif>

<!--- third year, plan --->

<cflock scope="SESSION" timeout="60">
<cfquery name="c2" Datasource="Corporate"> 
SELECT *
 FROM Plan
 WHERE OfficeName='#URL.OfficeName#' 
 AND START_=#URL.Start# AND YEAR_=#End#
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor"> AND  AuditedBy = 'IQA'
<cfelse>
 AND  AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cflock>

<cfset n = 1>
<cfoutput query="c2">
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b>Plan<br>#year_#</b></td></tr>
<cfloop list="#c2.ColumnList#" index="col">
<cfif col is "Start" or col is "Placeholder" or col is "Year_" or col is "OfficeName" or col is "Comments" or col is "auditedby">
<cfelse>
<tr>
 <td class="blog-content" align="center">
 <cfif year_ is #end# and c2.recordcount is 0>--<br>
 <cfelse>	
  <cfif c2[col][n] IS "1">
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

<!--- third year, actual --->

<cfif curyear LT end>
<cfelse>

<cflock scope="SESSION" timeout="60">
<cfquery name="F" Datasource="Corporate">
SELECT * FROM Query
WHERE OfficeName='#URL.OfficeName#' AND Year_='#End#'
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor">
AND AuditedBy = 'IQA'
<cfelse>
AND AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cflock>

<cfset i = 1>
<cfset C=ArrayNew(1)>
<cfloop index="j" from="1" to="37">
<CFSET C[j] = 0>
</cfloop>

<cfset j = 1>
<cfoutput query="F" group="ID">
<cfloop list="#F.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby">
<cfelse>
  <cfif F[col][i] IS "1">
  	<cfset C[j]= C[j]+1>
	<cfelse>
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
<tr><td class="blog-content" align="center"><b>Actual<br>#c2.year_#</b></td></tr>
<cfloop index="j" from="1" to="37">
<tr>
 <td class="blog-content" align="center">
 <cfif F.recordcount is 0>
 --
 <cfelse>
  <cfif c[j] gte 1>
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
  </cfif>
</td></tr> 
</cfloop>
</TABLE>

</td>
</cfoutput>

</cfif>

</tr>
</TABLE>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
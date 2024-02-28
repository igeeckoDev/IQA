<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Edit Plan">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset Start = #url.Start#>
<cfset End = #url.Start# + 2>
<cfset Middle = #url.start# + 1>

<cflock scope="SESSION" timeout="60">
    <cfquery name="plan" Datasource="Corporate"> 
    SELECT *
     FROM Plan
     WHERE OfficeName='#URL.OfficeName#' 
     AND START_=#URL.Start# AND YEAR_=#URL.Year#
    <CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor"> AND  AuditedBy = 'IQA'
    <cfelse>
     AND  AuditedBy = '#SESSION.Auth.Region#'
    </cfif>
     ORDER BY YEAR_,START_
    </cfquery>
</cflock>
	  
<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Audit_Plan_Submit.cfm?Officename=#URL.Officename#&Year=#URL.Year#&Start=#URL.Start#&auditedby=#Url.AuditedBy#">
	
<b><u>3 Year Audit Plan - #URL.OfficeName# (#URL.Start# - #End#) - #URL.AuditedBy#</u></b><br><br>
</cfoutput>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses_2010SEPT1
ORDER BY ID
</cfquery>

<Table width="750" valign="top">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="650" valign="top">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="Clauses">
<tr><td class="blog-content2" valign="top">
#title#
</td></tr> 
</cfoutput>

</table>

</td>
<td class="blog-content" valign="top">

<Table border="1" width="100">
<tr><td class="blog-content" valign="top" align="center"><b><cfoutput>#year#</cfoutput></b></td></tr>
<cfloop list="#plan.ColumnList#" index="col">
<cfif col is "Start_" or col is "Placeholder" or col is "Year_" or col is "OfficeName" or col is "Comments" or col is "AuditedBy">
<cfelse>
 <cfoutput query="plan" group="Start_">
<tr><td class="blog-content2" valign="top">

<cfset colName1 = #replace(col, "A00", "", "All")#>
<cfset colName = #replace(colName1,"A0", "", "All")#>

  <cfif plan[col][1] IS "1">
   Yes <input type="Radio" name="#colName#" Value="1" checked> 
   No <INPUT TYPE="Radio" name="#colName#" value="0">	
  <cfelse>
   Yes <input type="Radio" name="#colName#" Value="1">
   No <INPUT TYPE="Radio" name="#colName#" value="0" checked>
  </cfif>
</td></tr> 
 </cfoutput>
</cfif>  
</cfloop>
</TABLE>

</td>
</tr>
</TABLE>

<INPUT TYPE="Submit" value="Save and Continue">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->


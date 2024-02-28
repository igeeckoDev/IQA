<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Edit Report Page 5 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfquery name="Input" Datasource="Corporate">
UPDATE Report4
SET 

<cfloop index="x" list="#form.fieldnames#">
<cfoutput>
<cfif x is "Comments">
<cfset C1 = #ReplaceNoCase(Form.Comments,chr(13),"<br>", "ALL")#>
Comments='#C1#',
<cfelse>
#x# = #form[x]#,
</cfif>
</cfoutput>
</cfloop>
Placeholder='N/A'

WHERE
Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID=#URL.ID#
</cfquery>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A></div><br>

<b><u>Field Service ISO/IEC 17020 Audit Coverage</u></b><br>
<br><br>

<cfquery name="Output" Datasource="Corporate">
SELECT * FROM Report5
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID = #URL.ID#
</cfquery>

<cfquery name="View" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID = #URL.ID#
</cfquery>

<cfquery name="Clauses" Datasource="Corporate"> 
SELECT * FROM  A17020  "17020" ORDER BY ID
</cfquery>

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report_edit5_submit.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
</cfoutput>

<Table width="700" valign="top">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="600" valign="top">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="Clauses">
<tr><td class="blog-content2" valign="top">
<cfif view.year lt 2008>
	#Clause#
<cfelseif view.year eq 2008 AND view.month lt 10>
	#Clause#
<cfelse>
	#NewClause#
</cfif>
</td></tr> 
</cfoutput>

</table>

</td>
<td class="blog-content" valign="top">

<Table border="1" width="100">
<tr>
<td class="blog-content" valign="top">
<cfset i = 1>
	<b><cfoutput>#url.year#-#url.id#</cfoutput></b></td>
</tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Comments" or col is "Year_" or col is "ID" or col is "AuditedBy" or col is "Placeholder">
<cfelse>
 <cfoutput query="Output">
<tr><td class="blog-content2" valign="top">
  <cfif output[col][1] IS "1">
   Yes <input type="Radio" name="#col#" Value="1" checked> 
   No <INPUT TYPE="Radio" name="#col#" value="0">	
  <cfelse>
   Yes <input type="Radio" name="#col#" Value="1"> 
   No <INPUT TYPE="Radio" name="#col#" value="0" checked>
  </cfif>
    <cfif i eq 22><cfif view.year gt 2008 OR view.year eq 2008 AND view.month gte 10><br></cfif></cfif>
</td></tr> 
<cfset i = i+1>
 </cfoutput>
</cfif>  
</cfloop>
</Table>
</td>
</tr>
</table>

<table>
<tr>
<td colspan="2" class="blog-content">
<br>Audit Coverage Comments: (Not Required)<br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="85" NAME="Comments" Value="" displayname="Audit Coverage Comments">
<cfoutput query="output">
<cfset C1 = #ReplaceNoCase(Comments, "<br>", chr(13), "ALL")#>
#C1#
</cfoutput>
</textarea>
<br><br>
</td>
</tr>
</TABLE>

<INPUT TYPE="Submit" value="Save and Continue">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
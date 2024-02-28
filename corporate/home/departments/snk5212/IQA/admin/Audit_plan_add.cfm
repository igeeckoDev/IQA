<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Add Audit Plan">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset Start = #url.Start#>
<cfset End = #url.Start# + 2>
<cfset middle = #url.start# + 1>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses_2010SEPT1
ORDER BY ID
</cfquery>

<cfoutput>
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
		<cfset AuditedBy = "IQA">
	<cfelse>
		<cfset AuditedBy = #SESSION.Auth.Region#>
	</cfif>
</cflock>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Audit_Plan_Submit.cfm?Officename=#URL.Officename#&Year=#URL.Year#&Start=#URL.Start#&AuditedBy=#AuditedBy#">

<table width="750">
<tr>
<td valign="top" class="blog-content">
<b><u>3 Year Audit Plan - #URL.OfficeName# (#URL.Start# - #End#) - #AuditedBy#</u></b><br><br>
Add <b>#URL.Year#</b> Data<br><br>
</cfoutput>

<table border="1" valign="top">
<tr>
<td class="blog-title"><a href="../matrix.cfm" target="_blank">View</a> Matrix</td>
<td class="blog-title"><cfoutput>#URL.Year#</cfoutput> Plan</td>
</tr>
<cfoutput query="Clauses">
<tr>
<td class="blog-content">#title#</td>
<td class="blog-content">
Yes <INPUT TYPE="Radio" NAME="#ID#" value="1"> 
No <INPUT TYPE="Radio" NAME="#ID#" value="0" Checked>
</td>
</tr>
</cfoutput>
</table>

</td>
</tr>
</table>

<INPUT TYPE="Submit" value="Save and Continue">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
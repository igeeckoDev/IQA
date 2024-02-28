<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "File Uploads - Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>						  
<!---
:: <a href="car_response.cfm?ID=#URL.ID#&Year=#URL.year#&auditedby=#url.auditedby#">Upload</a> Follow Up/Close Out Letter<br>
--->
:: <a href="addReport.cfm?ID=#URL.ID#&Year=#URL.year#">Upload</a> Audit Report<br>
:: <a href="addScopeLetter.cfm?ID=#URL.ID#&Year=#URL.year#">Upload</a> Scope Letter<br><br>
</cfoutput>
Note - This is for uploading Reports and Scopes in the old format (pdf file).
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Auditor List - Assign Auditor - Request New Auditors - Search">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#IQADir#TechnicalAudits_AssignAuditor_Request.cfm?#CGI.Query_String#">
</cfoutput>

Request Auditor - Search by Last Name:<br>
<input name="Last_Name" type="Text" size="70" value="">
<br><br>

<input name="Submit" type="Submit" value="Search for Employee"> 
</form><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Request to be an Auditor - Submitted">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM AuditorList
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addID">
INSERT INTO AuditorList(ID,Auditor)
VALUES (#ID.newid#,'#FORM.Auditor#')
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

LastName='#Form.LastName#',
Email='#Form.Email#',
Phone='#Form.Phone#',
<cfif Form.Corporate is "Yes">
SubRegion='Corporate',
Region='Corporate',
<cfelse>
SubRegion='#ListGetAt(Form.OfficeName, 2, "!")#',
Region='#ListLast(Form.OfficeName, "!")#',
</cfif>
Comments=<CFQUERYPARAM VALUE="#Form.Comments#" CFSQLTYPE="CF_SQL_CLOB">,
Location='#ListFirst(Form.OfficeName, "!")#',
Status='#Form.Status#',
Qualified='#Form.AuditType#',
Expertise=<CFQUERYPARAM VALUE="#Form.Expertise#" CFSQLTYPE="CF_SQL_CLOB">,
Training=<CFQUERYPARAM VALUE="#Form.Training#" CFSQLTYPE="CF_SQL_CLOB">

WHERE ID=#ID.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddProfile" Datasource="Corporate">
SELECT * FROM AuditorList, IQAtblOffices
WHERE AuditorList.ID = #ID.newid#
AND AuditorList.Location = IQAtbloffices.OfficeName
</CFQUERY>

<cfif Form.DAP eq "Yes">
	<cfset Recipients = "Cheryl.Adams@ul.com">
<cfelse>
	<cfif AddProfile.Region eq "Asia Pacific">
		<cfset Recipients = "#Request.RQMAP#">

	<cfelseif AddProfile.Region eq "Corporate">
		<cfset Recipients = "#Request.RQMCorporate#">

	<cfelseif AddProfile.Region eq "Europe">
		<cfset Recipients = "#Request.RQMEULA#">

	<cfelseif AddProfile.Region eq "Latin America">
		<cfset Recipients = "#Request.RQMEULA#">

	<cfelseif AddProfile.Region eq "North America">
		<cfset Recipients = "#Request.RQMNA#">
	</cfif>
</cfif>

<CFOUTPUT query="AddProfile">
Your request has been sent to #Recipients# for review. You will be contacted shorty regarding your request.<br><br>
<B>Name</B>: #Auditor#<br>
<B>Email</b>: #Email#<br>
<B>Phone</b>: #Phone#<br>
<B>Location</b>: #Location#, #SubRegion#, #Region#<br><Br>
<B>Qualified Audit Types</b>:<br>
<cfset dump = #replace(Qualified, ",", "<br>", "All")#>
#Dump#<br><br>

<B>Expertise:</b><br>
<cfset Dump = #replace(Expertise, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<B>Training:</b><br>
<cfset Dump = #replace(Training, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<B>Comments:</b><br>
<cfset Dump = #replace(Comments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<cfif Form.Corporate is "Yes">
#Auditor# requested to be a Corporate Quality Auditor.
</cfif>

<cfif Form.DAP is "Yes">
#Auditor# requested to be a DAP, CTF, and/or CBTL Auditor.
</cfif>

</CFOUTPUT>

<cfmail
	query="AddProfile"
	from="Internal.Quality_Audits@ul.com"
	to="#Recipients#"
	cc="#Email#"
	bcc="Christopher.J.Nicastro@ul.com"
	subject="Auditor Request - #Auditor#"
	Mailerid="Reminder"
	type="HTML">
#Auditor# has submitted an Auditor Request on the IQA web site.<br><br>

To the Requestor - #Recipients# will contact you soon regarding your request.<br><br>

<B>Name</b>: #Auditor#<br>
<B>Email</b>: #Email#<br>
<B>Phone</b>: #Phone#<br>
<B>Location</b>: #Location#, #SubRegion#, #Region#<br>
<B>Qualified Audit Types</b>:<br>
<cfset dump = #replace(Qualified, ",", "<br>", "All")#>
#Dump#<br><br>

<B>Expertise:</b><br>
<cfset Dump = #replace(Expertise, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<B>Training:</b><br>
<cfset Dump = #replace(Training, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<B>Comments:</b><br>
<cfset Dump = #replace(Comments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<cfif Form.Corporate is "Yes">The Requestor has indicated they would like to be a Corporate Internal Quality Auditor.</cfif><br><br>

<cfif Form.DAP is "Yes">The Requestor has requested to be a DAP, CTF, and/or CBTL Auditor.</cfif><br><Br>

#Recipients# - You can accept or deny this auditor request on the IQA website. Please login and select 'Auditor Requests' to view pending requests.
</cfmail>
<br><br>

<a href="Aprofiles.cfm">Return to the Auditor Profiles</a>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
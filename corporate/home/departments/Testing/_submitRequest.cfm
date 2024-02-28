<CFQUERY BLOCKFACTOR="100" NAME="AddProfile" Datasource="Corporate">
SELECT * FROM AuditorList, IQAtblOffices
WHERE AuditorList.ID = 193
AND AuditorList.Location = IQAtbloffices.OfficeName
</CFQUERY>

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

#Auditor# requested to be a Corporate Quality Auditor.
 </CFOUTPUT>

<cfmail 
	query="AddProfile"
	from="Internal.Quality_Audits@ul.com" 
	to="#Recipients#"
	cc="#Email#"
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

The Requestor has indicated they would like to be a Corporate Internal Quality Auditor.<br><br>
	
#Recipients# - You can accept or deny this auditor request on the IQA website. Please login and select 'Auditor Requests' to view pending requests.	
</cfmail>
<br><br>
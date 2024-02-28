<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor Request Processed">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="AddAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

<cfif URL.Action is "approved">
Status='Active'
<cfelse>
Status='Denied'
</cfif>

WHERE ID=#URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddProfile" Datasource="Corporate">
SELECT * 
FROM AuditorList, IQAtblOffices
WHERE AuditorList.ID = #URL.ID#
AND AuditorList.Location = IQAtbloffices.OfficeName
</CFQUERY>
						  
<CFOUTPUT query="AddProfile">
<cfif URL.Action is "approved">
Status='Active'
<cfelse>
Status='Denied'
</cfif>

<B>#Auditor#</B> has been #URL.Action#<cfif URL.Action is "Approved"> and added to the <a href="Aprofiles.cfm?view=all">Auditor List</a></cfif>.<br><br>
</CFOUTPUT>	

<cfmail 
	query="AddProfile"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#Email#"
	subject="Auditor Request - #URL.Action#" 
	Mailerid="Reminder">
Your Audit Request has been #URL.Action#.<br /><br />

For any questions pertaining to your auditor status, please contact <cfif AddProfile.Region is "Corporate">#Request.RQMCorporate#<cfelseif AddProfile.Region is "Asia Pacific">#Request.RQMAP#<cfelseif AddProfile.Region is "Europe" OR AddProfile.Region is "Latin America">#Request.RQMEULA#<cfelseif AddProfile.Region is "North America">#Request.RQMNA#</cfif>.
</cfmail>		  

<br><br>
<a href="Aprofiles.cfm?view=all">Return to the Auditor Profiles</a>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
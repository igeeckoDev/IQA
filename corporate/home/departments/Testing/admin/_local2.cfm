<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - #curyear# Local Audits">
<cfinclude template="SOP.cfm">

<!--- / --->

<!--- SUPER LOCATION AUDITS --->
<CFQUERY BLOCKFACTOR="100" name="Locations" Datasource="Corporate">
SELECT OfficeName, SuperLocationID, SuperLocation, ID
FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Physical = 'Yes'
AND SuperLocation = 'Yes'
ORDER BY OfficeName
</cfquery>

<br>
<table border=1>
<tr class="blog-title" align="center" valign="top">
	<td>Super Location Name</td>
	<td>Sites Included</td>
	<td width="50">Jan - Jun</td>
	<td width="50">Jul - Dec</td>
</tr>

<cfoutput query="Locations">
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
	SELECT Year_, ID, AuditArea, Area, LeadAuditor, Month, OfficeName
	FROM AuditSchedule
	WHERE OfficeName = '#OfficeName#'
	AND Year_ = #curyear#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Local Function'
	AND Status IS NULL
	AND (Area = 'Processes' OR Area = 'Processes and Labs')
	</CFQUERY>

<tr class="blog-content" align="left" valign="top">
<!--- Output Office Name --->
	<td>#OfficeName#</td>
<!--- If There is an audit returned from the Audits query --->
<cfif Audits.Recordcount GT 0>
	<td>
	<CFQUERY BLOCKFACTOR="100" name="Sites" Datasource="Corporate">
	SELECT OfficeName FROM IQAtblOffices
	WHERE SuperLocationID = #ID#
	ORDER BY OfficeName
	</CFQUERY>
	
	<cfif Sites.recordcount GT 0>
		<cfloop query="Sites">
			#OfficeName#<br>
		</cfloop>
	</cfif>
	</td>
	<td align="center"><cfif Audits.Month lte 6>#Audits.Year_#-#Audits.ID#<cfelse>--</cfif></td>
	<td align="center"><cfif Audits.Month gt 6>#Audits.Year_#-#Audits.ID#<cfelse>--</cfif></td>	

<!--- If there is no audit returned, and the Office listed is a super location, check if child locations have audits --->
<cfelseif Audits.Recordcount EQ 0>
	<td colspan="3">None</td>
</cfif>
</tr>
</cfoutput>
</table>

<!--- SITE AUDITS --->	
<CFQUERY BLOCKFACTOR="100" name="Locations" Datasource="Corporate">
SELECT OfficeName, SuperLocationID, SuperLocation, ID
FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Physical = 'Yes'
AND SuperLocation = 'No'
ORDER BY OfficeName
</cfquery>

<br><br>
<table border=1>
<tr class="blog-title" align="center" valign="top">
	<td>Location</td>
	<td width="50">Jan - Jun</td>
	<td width="50">Jul - Dec</td>
</tr>
<cfoutput query="Locations">
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
	SELECT Year_, ID, AuditArea, Area, LeadAuditor, Month, OfficeName
	FROM AuditSchedule
	WHERE OfficeName = '#OfficeName#'
	AND Year_ = #curyear#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Local Function'
	AND Status IS NULL
	AND (Area = 'Processes' OR Area = 'Processes and Labs')
	</CFQUERY>

<!--- If There is an audit returned from the Audits query --->
<cfif Audits.Recordcount GT 0>
<tr class="blog-content" align="left" valign="top">
<!--- Output Office Name --->
	<td>#OfficeName#</td>
	<td align="center"><cfif Audits.Month lte 6>#Audits.Year_#-#Audits.ID#<cfelse>--</cfif></td>
	<td align="center"><cfif Audits.Month gt 6>#Audits.Year_#-#Audits.ID#<cfelse>--</cfif></td>	
<!--- No audit returned --->
</cfif>
</tr>

</cfoutput>
</table>	

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
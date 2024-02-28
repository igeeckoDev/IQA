<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Edit Auditor Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT OfficeName 
FROM IQAtbloffices
WHERE Exist = 'Yes'
AND Finance = 'Yes'
AND Physical = 'Yes'
ORDER BY OfficeName
</cfquery>

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<cfif isDefined("URL.msg")>
	<cfoutput>
    	<font class="warning">#url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<b>Edit Auditor Status</b>
<br><br>
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="Auditors_Status.cfm?ID=#URL.ID#&Type=#URL.Type#">
<CFOUTPUT query="Auditors">
<u>Auditor Name</u>:<br>
#Auditor#
<br><br>

<u>Current Location</u>:<br />
#Location#<br /><br />
</cfoutput>

<cfif URL.Type NEQ "TechnicalAudit">
    <u>Select New Location</u>:<br />
    <SELECT NAME="Location" displayname="Auditor Location">
        <OPTION VALUE="">Select Site
        <option value="">---
        <Option Value="NoChanges" selected="selected">No Location Change
    <CFOUTPUT QUERY="OfficeName">
        <OPTION VALUE="#OfficeName#">#OfficeName#
    </CFOUTPUT>
    </SELECT>
    <br><br>
</cfif>

<CFOUTPUT query="Auditors">
<cfif URl.Type eq "TechnicalAudit">
    <u>Department Number</u>:<br />
    #Dept#
    <br /><br />
    <input type="hidden" name="Location" value="#Location#" />
</cfif>

<u>Auditor Email</u>:<br />
#Email#
<br /><br />

<u>Current Status</u>:<br>
<cfif NOT len(status)>Active<cfelse>#Status#</cfif><br><Br>

Select New Status:<br>
<cfSelect Name="Status" required="yes" message="Please select Auditor Status">
	<option>Selet New Status</option>
    <option value="NoChanges" selected="selected">No Status Change
    <option>---</option>
	<cfif Status eq "Removed">
		<Option Value="Active">Active
        <Option Value="Removed">Removed
	<cfelseif NOT len(Status)>
		<Option Value="Removed">Removed
        <Option Value="Active">Active	
	</cfif>
</cfSELECT><br><br>

If Status is changing, please enter the effective date: (format: mm/dd/yyyy)<br>
<cfinput type="datefield" name="StatusDate" size="20" value="#curDate#" required="yes" message="Please Enter Effective Date of Status Change">
<br><br>

</CFOUTPUT>
<cfinput name="submit" type="submit" value="Save Auditor Status"> 
</cfform>
<br /><br />

<CFOUTPUT query="Auditors">
    <b>History</b><br>
    <cfif len(History)>
        #History#
    <cfelse>
        No History
    </cfif>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
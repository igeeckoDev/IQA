<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Edit Auditor Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<b>Edit Auditor Status</b>
<br><br>
<CFOUTPUT query="Auditors">
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="LTA_Auditors_Status.cfm?ID=#URL.ID#">

<u>Auditor Name</u>:<br>
#Auditor#
<br><br>

<u>Auditor Email</u>:<br />
#Email#
<br /><br />

<u>Current Status</u>:<br>
<cfif NOT len(status)>Active<cfelse>#Status#</cfif><br><Br>

Select New Status:<br>
<cfSelect Name="Status" required="yes" message="Please select Auditor Status">
	<option>Selet New Status</option>
    <option>---</option>
	<cfif Status eq "Removed">
		<Option Value="Active">Active
        <Option Value="Removed">Removed
	<cfelseif NOT len(Status)>
		<Option Value="Removed">Removed
        <Option Value="Active">Active	
	</cfif>
</cfSELECT><br><br>

Effective Date of Status Change</b>:<br>
<cfinput name="StatusDate" size="20" value="#curdate#" required="yes" message="Please Enter Effective Date of Status Change">
<br><br>

<cfinput name="submit" type="submit" value="Save Auditor Status"> 
</cfform>
<br /><br />

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
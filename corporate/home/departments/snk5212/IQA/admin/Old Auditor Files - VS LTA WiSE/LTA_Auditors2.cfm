<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Add/Edit Auditors">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="LabAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND Type = 'LTA'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<CFQUERY Name="LabAuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status = 'Removed'
AND Type = 'LTA'
AND ID <> 0
ORDER BY Auditor
</CFQUERY>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="LTA_Auditors_Search.cfm">

Add Auditor - Search by Last Name:<br>
<input name="Last_Name" type="Text" size="70" value="">
<br><br>

<input name="Submit" type="Submit" value="Search for Employee"> 
</form>

<b>Current Auditors by Status</b><br>
<u>Status: Active</u><br>
<CFOUTPUT query="LabAuditor">
- #Auditor# <a href="LTA_Auditors_edit.cfm?ID=#ID#">(edit status)</a><br>
</CFOUTPUT><Br>

<u>Status: Removed</u><br>
<cfif LabAuditorRemoved.recordcount gt 0>
	<cfoutput query="LabAuditorRemoved">
    - #Auditor# <a href="LTA_Auditors_edit.cfm?ID=#ID#">(edit status)</a><br>
    </cfoutput>
<cfelse>
	None listed
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
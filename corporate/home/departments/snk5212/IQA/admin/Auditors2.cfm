<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Add/Edit Auditors">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND Type = '#URL.Type#'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<CFQUERY Name="AuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status = 'Removed'
AND Type = '#URL.Type#'
AND ID <> 0
ORDER BY Auditor
</CFQUERY>

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="Auditors_Search.cfm?Type=#URL.Type#">
</cfoutput>

Add Auditor - Search by Last Name:<br>
<input name="Last_Name" type="Text" size="70" value="">
<br><br>

<input name="Submit" type="Submit" value="Search for Employee"> 
</form><br>

<b>Auditors by Status</b><br><br>

<u>Status: Active</u><br>
<cfif Auditor.recordcount gt 0>
    <CFOUTPUT query="Auditor">
    - #Auditor# <a href="Auditors_Details.cfm?ID=#ID#&Type=#URL.Type#">(view)</a><br>
    </CFOUTPUT>
<cfelse>
	None Listed<Br />
</cfif><Br>

<u>Status: Removed</u><br>
<cfif AuditorRemoved.recordcount gt 0>
	<cfoutput query="AuditorRemoved">
    - #Auditor# <a href="Auditors_Details.cfm?ID=#ID#&Type=#URL.Type#">(view)</a><br>
    </cfoutput>
<cfelse>
	None listed
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
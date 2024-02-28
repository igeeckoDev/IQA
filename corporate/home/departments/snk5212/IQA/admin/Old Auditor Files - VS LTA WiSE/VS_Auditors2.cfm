<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Verification Services - Add/Edit Auditors">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="VSAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND ID <> 0
AND Type = 'VS'
ORDER BY Auditor
</cfquery>

<CFQUERY Name="VSAuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status = 'Removed'
AND ID <> 0
AND Type = 'VS'
ORDER BY Auditor
</CFQUERY>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="VS_Auditors_Search.cfm">

Add Auditor - Search by Last Name:<br>
<input name="Last_Name" type="Text" size="70" value="">
<br><br>

<input name="Submit" type="Submit" value="Search for Employee"> 
</form><br><br>

<b>Current Auditors by Status</b><br>
<u>Status: Active</u><br>
<cfif VSAuditor.recordcount gt 0>
	<CFOUTPUT query="VSAuditor">
        - #Auditor# <a href="VS_Auditors_edit.cfm?ID=#ID#">(edit status)</a>
    </CFOUTPUT>
<cfelse>
	None Listed
</cfif><br /><br />

<u>Status: Removed</u><br>
<cfif VSAuditorRemoved.recordcount gt 0>
	<cfoutput query="VSAuditorRemoved">
    - #Auditor# <a href="VS_Auditors_edit.cfm?ID=#ID#">(edit status)</a>
    </cfoutput>
<cfelse>
	None listed
</cfif><Br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
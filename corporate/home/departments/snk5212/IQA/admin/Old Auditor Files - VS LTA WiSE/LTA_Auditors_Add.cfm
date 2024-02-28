<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Add Auditor - Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="LabAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND Type = 'LTA'
ORDER BY Auditor
</cfquery>

<CFQUERY Name="LabAuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status = 'Removed'
AND Type = 'LTA'
ORDER BY Auditor
</CFQUERY>

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="LTA_Auditors_update.cfm">
<u>Name</u>:<br>
#URL.Auditor#
<input name="Auditor" type="Hidden" size="70" value="#URL.Auditor#">
<br><br>

<u>Location</u>:<br>
#URL.Location#
<input name="Location" type="Hidden" size="70" value="#URL.Location#">
<br><br>

<u>Email</u>:<br>
#URL.Email#
<input name="Email" type="Hidden" size="70" value="#URL.Email#">
<br><br>

<u>Active Date</u>:<Br>
<input name="ActiveDate" Type="text" size="40" value="#dateformat(curdate, "mm/dd/yyyy")#">
<br><Br>

<input name="submit" type="submit" value="Add Auditor"> 
</form>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
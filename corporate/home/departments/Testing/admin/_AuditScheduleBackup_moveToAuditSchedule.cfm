<!---
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Copy Back up data to Audit Schedule">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
ID, Year_, AuditedBy, AuditType, AuditType2, OfficeName, Area, AuditArea, Month, Scope, Email, Email2, Desk, xGUID, lastYear

FROM
UL06046.AuditSchedule_Backup

WHERE Year_ = 2015
AND AuditedBY = 'IQA'
AND ID <> 1

ORDER BY ID
</cfquery>

<cfoutput query="Audit">
xGUID = #xGUID#<br>
lastYear = #lastyear#<br>
#Year_#-#ID#<br /><br>

	<cfquery name="AddNewToSched" datasource="Corporate">
	INSERT INTO AuditSchedule(xGUID, ID, Year_, Approved, AuditedBy, AuditType, AuditType2, OfficeName, Area, AuditArea, Month, Scope, Email, Email2, Desk, lastYear)
	VALUES(#xGUID#, #ID#, #Year_#, 'Yes', '#AuditedBy#', '#AuditType#', '#AuditType2#', '#OfficeName#', '#Area#', '#AuditArea#', #Month#, '#Scope#', '#Email#', '#Email2#', '#Desk#', #lastYear#)
	</cfquery>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
--->
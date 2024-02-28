<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning Publish to Audit Schedule - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="setReadyValue" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update 
	AuditSchedule_Planning_Status
	SET
	ReadyToPublishDate = #CreateODBCDate(curdate)#
	
	WHERE
	Year_ = #URL.Year#
	</cfquery>
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Status" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditSchedule_Planning_Status
WHERE Year_ = #URL.Year#
</cfquery>

<cfdump var="#Status#">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
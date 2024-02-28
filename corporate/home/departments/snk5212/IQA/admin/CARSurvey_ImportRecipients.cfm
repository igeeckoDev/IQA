<!---
Notes:
URL items needed:

dID = distribution ID
Name of the table where the recipients are listed (for the first time we did this, the table was named "CARSurvey2014Q3Recipients"

Instructions and files required are posted here:
\\USNBKD201P\gnk5212x\CJN\GCAR Metrics Reports\GCAR Metrics Survey Recipients\Q3 2014\
--->

<CFQUERY BLOCKFACTOR="100" name="getDistribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Quarter, Year_
FROM CARSurvey_Distribution
WHERE ID = #URL.dID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Import Recipients to #getDistribution.Year_# Q#getDistribution.Quarter# Survey">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="CARSurvey_menuItems.cfm">

<CFQUERY BLOCKFACTOR="100" name="getRecipients" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Email FROM #URL.importTable#
</cfquery>

Emails Found in import table: <cfoutput>#getRecipients.recordcount#</cfoutput><br>

<CFQUERY BLOCKFACTOR="100" name="getMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID
FROM CARSurvey_DistributionDetails
</cfquery>

<cfset i = getMaxID.NewID>
Added to table:<Br>
<cfloop query="getRecipients">
	<CFQUERY BLOCKFACTOR="100" name="inputRecipients" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO CARSurvey_DistributionDetails(ID, dID, Email)
	VALUES(#i#, #URL.dID#, '#Email#')
	</cfquery>
<cfset i = i+1>
</cfloop><br>

<CFQUERY BLOCKFACTOR="100" name="getDistribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Email FROM CARSurvey_DistributionDetails
WHERE dID = 2
ORDER BY Email
</cfquery>

Emails Found in distribution table:<cfoutput>#getDistribution.recordcount#</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
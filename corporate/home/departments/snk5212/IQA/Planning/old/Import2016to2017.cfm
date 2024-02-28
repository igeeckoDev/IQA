<CFQUERY BLOCKFACTOR="100" name="2016Users" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Type, pID, SentTo, SurveyType
FROM AuditPlanning2016_Users
WHERE Type <> 'Site'
ORDER BY ID
</cfquery>

<cfoutput query="2016Users">
	<CFQUERY BLOCKFACTOR="100" name="Insert2017" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO AuditPlanning2017_Users(ID, Type, pID, SentTo, SurveyType)
	VALUES(#ID#, '#Type#', #pID#, '#SentTo#', '#SurveyType#')
	</cfquery>
	
#ID# #SentTo#<br>
</cfoutput><br>

<CFQUERY BLOCKFACTOR="100" name="2017Users" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Type, pID, SentTo, SurveyType
FROM AuditPLanning2017_Users
WHERE Type <> 'Site'
ORDER BY ID
</cfquery>
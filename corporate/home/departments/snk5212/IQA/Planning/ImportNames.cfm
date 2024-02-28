<cfloop from="103" to="115" index="i">
	<CFQUERY BLOCKFACTOR="100" name="Import" Datasource="UL06046">
	INSERT INTO AuditPlanning2015_Users(ID,Type,pID,SentTo,SurveyType)
	VALUES(#i#,'Laboratory',0,'Email','Laboratory')
	</cfquery>
</cfloop>
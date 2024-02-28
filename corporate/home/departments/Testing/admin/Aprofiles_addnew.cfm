<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM AuditorList
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addID">
INSERT INTO AuditorList(ID,Auditor)
VALUES (#ID.newid#,'#FORM.e_Auditor#')
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

LastName='#Form.e_LastName#',
Email='#Form.e_Email#',

<!---
Phone='#Form.e_Phone#',
Manager='#Form.e_Manager#',
--->

Status='#Form.e_Status#',
Lead=#form.Lead#,

<cflock scope="SESSION" timeout="10">
	<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
		Qualified='#Form.e_AuditType#',
		Location='#Form.e_OfficeName#',
	<cfelse>
		Qualified='Field Services',
	</cfif>
</cflock>

Comments=<CFQUERYPARAM VALUE="#Form.Comments#" CFSQLTYPE="CF_SQL_CLOB">,
Expertise=<CFQUERYPARAM VALUE="#Form.Expertise#" CFSQLTYPE="CF_SQL_CLOB">,
Training=<CFQUERYPARAM VALUE="#Form.Training#" CFSQLTYPE="CF_SQL_CLOB">

WHERE ID=#ID.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="SubRegion" Datasource="Corporate">
SELECT AuditorList.ID, AuditorList.Location, IQAtblOffices.OfficeName, IQAtblOffices.SubRegion, IQAtblOffices.Region FROM AuditorList, IQAtblOffices
WHERE AuditorList.ID=#ID.newid#
AND AuditorList.Location = IQAtbloffices.OfficeName
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

<cfif Form.Corporate is "No">
	<CFIF SESSION.Auth.AccessLevel is NOT "Field Services" AND SESSION.Auth.Region NEQ "Medical" AND SESSION.Auth.Region NEQ "UL Environment">
		SubRegion='#SubRegion.SubRegion#',
		Region='#SubRegion.Region#',
		IQA='No'
	<cfelseif SESSION.Auth.Region eq "Medical">
		SubRegion='Medical',
		Region='Medical',
		IQA='No'
	<cfelseif SESSION.Auth.Region eq "UL Environment">
		SubRegion='UL Environment',
		Region='UL Environment',
		IQA='No'
	<cfelseif SESSION.Auth.Region eq "Field Services">
		SubRegion='Field Services',
		Region='Field Services',
		IQA='No'
	</cfif>
<cfelseif Form.Corporate is "Yes">
	SubRegion='Corporate',
	Region='Corporate',
	IQA='Yes'
</cfif>

WHERE ID=#ID.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddProfile" Datasource="Corporate">
SELECT * FROM AuditorList
WHERE ID=#ID.newid#
</CFQUERY>

<cfoutput query="AddProfile">
	<cflocation url="Aprofiles_detail.cfm?ID=#ID#" addtoken="no">
</cfoutput>
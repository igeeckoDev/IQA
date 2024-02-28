<CFQUERY BLOCKFACTOR="100" NAME="DAP" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="UpdateAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

Email='#Form.e_Email#',

<!---
Phone='#Form.e_Phone#',
Manager='#Form.e_Manager#',
--->

Comments=<CFQUERYPARAM VALUE="#Form.Comments#" CFSQLTYPE="CF_SQL_CLOB">,
Status='#Form.e_Status#',

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">

Lead='#form.Lead#',

<cfif form.e_officename is "NoChanges">
<cfelse>
	Location='#Form.e_OfficeName#',
</cfif>

<cfif form.e_audittype is "NoChanges">
<cfelse>
	Qualified='#Form.e_AuditType#',
</cfif>

<cfelse>
	Qualified='Field Services',
	Location='Field Services',
</cfif>
</cflock>

<cfif
	DAP.DAPAuditor eq "Yes"
	OR DAP.IQA eq "Yes" AND DAP.Status eq "In Training">

	Qualified17025 = '#Form.Qualified17025#',
	Qualified17065 = '#Form.Qualified17065#',
	QualifiedSNAP = '#Form.QualifiedSNAP#',
	QualifiedCert = '#Form.QualifiedCert#',
</cfif>

Expertise=<CFQUERYPARAM VALUE="#Form.Expertise#" CFSQLTYPE="CF_SQL_CLOB">,
Training=<CFQUERYPARAM VALUE="#Form.Training#" CFSQLTYPE="CF_SQL_CLOB">

WHERE ID=#URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="SubRegion" Datasource="Corporate">
SELECT AuditorList.ID, AuditorList.Location, IQAtblOffices.OfficeName, IQAtblOffices.SubRegion, IQAtblOffices.Region FROM AuditorList, IQAtblOffices
WHERE AuditorList.ID=#URL.ID#
AND AuditorList.Location = IQAtbloffices.OfficeName
</CFQUERY>

<cflock scope="SESSION" timeout="5">
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

	WHERE ID=#URL.ID#
    </CFQUERY>

</cflock>

<CFQUERY BLOCKFACTOR="100" NAME="AddProfile" Datasource="Corporate">
SELECT * FROM AuditorList
WHERE ID=#url.id#
</CFQUERY>

<cfoutput query="AddProfile">
	<cflocation url="Aprofiles_detail.cfm?ID=#ID#" ADDTOKEN="No">
</cfoutput>
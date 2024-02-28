<CFQUERY Datasource="Corporate" NAME="rowInfo">
SELECT IQANotes FROM AccredLocations
WHERE ID = #URL.ID#
</CFQUERY>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY Datasource="Corporate" NAME="EditRow">
UPDATE AccredLocations
SET

AccredType='#Form.AccredType#',
AccredType2='#Form.AccredType2#',
<cfset Dump = #ReplaceNoCase(Form.AccredScope,chr(13),"<br>", "ALL")#>
AccredScope='#Dump#',
LocalAudit='#Form.LocalAudit#',
AuditFrequency=#Form.AuditFrequency#,
AdditionalRequirements='#Form.AdditionalRequirements#',
AdditionalRequirementsNotes='#Form.AdditionalRequirementsNotes#',
Status='#FORM.Status#',
Posted=#postDate#,
PostedBy='#Form.PostedBy#',
Notes='#Form.Notes#',
IQANotes='Record edited #dateformat(postDate, "mm/dd/yyyy")# by #Form.PostedBy#<br />Edit Notes: #Form.IQANotes#<br /><br />#rowInfo.IQANotes#'

WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="viewItem.cfm?ID=#URL.ID#" addtoken="no">

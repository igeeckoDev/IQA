<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
UPDATE ReportAttach
SET
Status = 'removed'
WHERE rID = #URL.rID#
</CFQUERY>

<cflocation url="#IQARootDir#Report_Output_All.cfm?ID=#URl.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">
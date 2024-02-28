<CFQUERY Name="removeReview" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE DAPReviewForm_Users
SET
Status = 'Removed'
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="#IQAAdminDir#DAPReviewForm_OutputTable.cfm" addtoken="no">
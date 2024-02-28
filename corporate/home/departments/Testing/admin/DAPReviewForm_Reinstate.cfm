<CFQUERY Name="removeReview" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE DAPReviewForm_Users
SET
Status = null
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="#IQAAdminDir#DAPReviewForm_OutputTable.cfm" addtoken="no">
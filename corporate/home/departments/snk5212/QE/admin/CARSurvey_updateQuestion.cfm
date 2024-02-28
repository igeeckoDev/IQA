<CFQUERY Name="Update" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
    CARSurvey_Questions
SET
    Question = '#FORM.Question#'
WHERE 
    ID = #URL.ID#
</CFQUERY>

<cflocation url="CARSurvey_showQuestions.cfm" addtoken="no">
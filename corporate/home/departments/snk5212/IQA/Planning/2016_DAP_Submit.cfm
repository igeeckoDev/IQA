<cfset URL.UserID_Actual = URL.UserID>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY Name="ResponseCheck" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	PostedBy
FROM
	DAPAuditPlanning2016_Users
WHERE
	ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
	DAPAuditPlanning2016_Users
SET
    Responded='Yes',
    Posted=#postDate#,
<cfif len(ResponseCheck.PostedBy)>
	<!--- append new posted info to existing data to handle multiple responses --->
	PostedBy='#ResponseCheck.PostedBy#, #Form.PostedInfo#'
<cfelse>
    PostedBy='#Form.PostedInfo#'
</cfif>

WHERE
	ID = #URL.UserID#
</CFQUERY>

<cfoutput>
<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT
	DAPAuditPlanning2016_Questions.ID, DAPAuditPlanning2016_Users.SurveyType
FROM
	DAPAuditPlanning2016_Questions, DAPAuditPlanning2016_Users
WHERE
	DAPAuditPlanning2016_Users.ID = #URL.UserID#
ORDER BY
	DAPAuditPlanning2016_Questions.ID
</CFQUERY>

<cfdump var="#numQuestions#">

    <cfloop query="numQuestions">
        <cfif isDefined("#ID#_Answer")>
            <!--- if the question exists, add a record in the db --->
            <!--- get record count of Answers table --->
            <CFQUERY Name="CheckRows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID FROM DAPAuditPlanning2016_Answers
            </CFQUERY>

            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID
                FROM DAPAuditPlanning2016_Answers
                </CFQUERY>
            <cfelse>
                <cfset NewID.NewID = 1>
            </cfif>

            <cfif isDefined("#ID#_Notes")>
        		<cfif len(Evaluate("Form.#ID#_Notes"))>
                	<cfset Notes = "#Evaluate("Form.#ID#_Notes")#">
                <cfelse>
                	<cfset Notes = "None Listed">
                </cfif>
        	</cfif>

            <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            INSERT INTO DAPAuditPlanning2016_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #URL.UserID#)
            </CFQUERY>
        </cfif>
    </cfloop>
</cfoutput>

<cflocation url="2016_DAP_Details.cfm?UserID=#URL.UserID#" addtoken="no">
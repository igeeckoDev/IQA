<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<!--- get new ID --->
<CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID
FROM DAPReviewForm_Users
</CFQUERY>

<!--- change cheryl allison to cheryl adams for form.postedby --->

<!--- add new User row --->
<CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO DAPReviewForm_Users(ID, Posted, PostedBy, SurveyID)
VALUES(#NewUserID.NewID#, #postDate#, '#Form.postedBy#', 0)
</CFQUERY>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
	DAPReviewForm_Users
SET
	ReviewerName = '#Form.ReviewerName#',
	DAFileNumber = '#Form.DAFileNumber#',
	ProjectNumber = '#Form.ProjectNumber#',
	ProgramAudited = '#Form.ProgramAudited#',
	MultiplePrograms = '#Form.MultiplePrograms#',
	AuditType = '#Form.AuditType#',
	AuditorName = '#Form.AuditorName#',
	AuditorEmail = '#Form.AuditorEmail#',
	AuditorManagerEmail = '#Form.AuditorManagerEmail#',
	DAPScopeReviews = '#Form.DAPScopeReviews#',
	DAPScopeReviews_Comments = '#Form.DAPScopeReviews_Comments#',
	Confirm = 'No'
WHERE
	ID = #NewUserID.NewID#
</CFQUERY>

<cfset vUserID = NewUserID.NewID>

<cfoutput>
<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT
	*
FROM
	DAPReviewForm_Questions
WHERE
	Status IS NULL
ORDER BY
	ID
</CFQUERY>

    <cfloop query="numQuestions">
        <cfif isDefined("#ID#_Answer")>
            <!--- if the question exists, add a record in the db --->
            <!--- get record count of Answers table --->
            <CFQUERY Name="CheckRows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID FROM DAPReviewForm_Answers
            </CFQUERY>

            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID
                FROM DAPReviewForm_Answers
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
            INSERT INTO DAPReviewForm_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #vUserID#)
            </CFQUERY>
        </cfif>
    </cfloop>
</cfoutput>

<cflocation url="DAPReviewForm_Details.cfm?ID=#vUserID#" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
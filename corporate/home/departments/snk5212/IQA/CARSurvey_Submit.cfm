<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<!--- get new ID --->
   <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
   SELECT MAX(ID)+1 as NewID
   FROM CARSurvey_Users
   </CFQUERY>

<cfif NOT isDefined("NewUserID.NewID")>
	<cfset NewUserID.NewID = 1>
</cfif>

   <cfset vUserID = NewUserID.NewID>

<!--- define "SentTo" and "Distribution_UserID_UserID" values -
if the survey is from GCAR "Closed Awaiting Verification" email, there will be no identifier in the URL.
SentTo = 'GCAR Email'
Distribution_UserID = null

If it is from a quarterly distribution email, there will be a URL.dID and the employee number/email will be passed to the submit page.
The UserID from CARSurvey_DistributionDetails.ID can be stored in the Distribution_UserID row of CARSurvey_Users

SentTo = 'Quarterly Distibution'
Distribution_UserID = CARSurvey_DistributionDetails.ID, which is obtained from URL.dID and the employee email from getEmpNo
--->

<cfif isDefined("URL.dID")>
	<!--- check to see if this person already submitted a survey for this quarterly distribution --->
	<CFQUERY BLOCKFACTOR="100" name="UserCheck" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM CARSurvey_Users, CARSurvey_DistributionDetails, CARSurvey_Distribution
	WHERE CARSurvey_Distribution.ID = #URL.dID#
	AND CARSurvey_Distribution.ID = CARSurvey_DistributionDetails.dID
	AND CARSurvey_DistributionDetails.ID = CARSurvey_Users.Distribution_UserID
	AND PostedBy = '#Form.PostedBy_Name# / #Form.PostedBy_Email# / #Form.PostedBy_EmpNo#'
	</cfquery>

	<cfif UserCheck.RecordCount eq 0>
		<CFQUERY BLOCKFACTOR="100" name="UserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT ID FROM CARSurvey_DistributionDetails
		WHERE dID = #URL.dID#
		AND Email = '#Form.PostedBy_Email#'
		</cfquery>

		<cfset SentTo = "Quarterly Distribution">
		<cfset Distribution_UserID = UserID.ID>
	<cfelse>
		<cfset SentTo = "Ad Hoc Response">
		<cfset Distribution_UserID = "">
	</cfif>
<cfelse>
	<cfset SentTo = "GCAR Email">
	<cfset Distribution_UserID = "">
</cfif>

   <!--- add new User row --->
   <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
   INSERT INTO CARSurvey_Users(ID, SentTo, Posted, PostedBy, Responded, givenName, givenEmail, Distribution_UserID)
   VALUES(#NewUserID.NewID#, '#SentTo#', #postDate#, '#Form.PostedBy_Name# / #Form.PostedBy_Email# / #Form.PostedBy_EmpNo#', 'Yes', '#Form.givenName#', '#Form.givenEmail#', '#Distribution_UserID#')
   </CFQUERY>


<cfoutput>
<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT
	*
FROM
	CARSurvey_Questions
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
            SELECT ID FROM CARSurvey_Answers
            </CFQUERY>

            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID
                FROM CARSurvey_Answers
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
            INSERT INTO CARSurvey_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #vUserID#)
            </CFQUERY>
        </cfif>
    </cfloop>
</cfoutput>

<cflocation url="CARSurvey_Details.cfm?UserID=#vUserID#" addtoken="no">
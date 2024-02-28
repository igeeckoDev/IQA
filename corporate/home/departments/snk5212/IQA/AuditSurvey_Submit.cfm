<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<cfif Form.vReferred eq "yes">
	<!--- get new ID --->
    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID
    FROM AuditSurvey_Users
    </CFQUERY>
    
    <cfset vUserID = NewUserID.NewID>

    <!--- add new User row --->
    <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO AuditSurvey_Users(ID, AuditID, AuditYear, SentTo, Posted, PostedBy, Responded, givenName, givenEmail)
    VALUES(#NewUserID.NewID#, #URL.ID#, #URL.Year#, 'Referred', #postDate#, '#Form.PostedBy_Name# / #Form.PostedBy_Email# / #Form.PostedBy_EmpNo#', 'Yes', '#Form.givenName#', '#Form.givenEmail#')
    </CFQUERY>
<cfelse>
	<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE 
        AuditSurvey_Users
    SET
        Responded = 'Yes',
        Posted = #postDate#,
        PostedBy  = '#Form.PostedBy_Name# / #Form.PostedBy_Email# / #Form.PostedBy_EmpNo#',
        givenName = '#Form.givenName#',
		givenEmail = '#Form.givenEmail#'
    WHERE 
        ID = #Form.UserID#
    </CFQUERY>
    
    <cfset vUserID = Form.UserID>
</cfif>

<cfoutput>
<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT 
	*
FROM 
	AuditSurvey_Questions
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
            SELECT ID FROM AuditSurvey_Answers
            </CFQUERY>
            
            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID 
                FROM AuditSurvey_Answers
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
            INSERT INTO AuditSurvey_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #vUserID#)
            </CFQUERY>
        </cfif>
    </cfloop>
</cfoutput>

<cflocation url="AuditSurvey_Details.cfm?UserID=#vUserID#" addtoken="no">
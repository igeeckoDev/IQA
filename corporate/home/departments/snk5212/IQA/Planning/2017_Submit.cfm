<cfset URL.UserID_Actual = URL.UserID>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<cfif URL.UserID eq "Quality" OR URL.UserID eq "New" OR URL.UserID eq "Quality2">
	<!--- get new ID --->
    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID
    FROM AuditPlanning2017_Users
    </CFQUERY>

    <cfif URL.UserID eq "Quality">
		<!--- extract Type and pID from Form.NameAndType --->
        <cfset Type = ListFirst(Form.NameAndType)>
        <Cfset pID = ListLast(Form.NameAndType)>

		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2017_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, '#Type#', #pID#, 'Quality', 'LQM Response')
        </CFQUERY>
	<Cfelseif URL.UserID eq "Quality2">
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2017_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, 'New', 0, 'Quality2', '#Form.e_SurveyArea#')
        </CFQUERY>
	<cfelseif URL.UserID eq "New">
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2017_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, '#URL.UserID#', '0', '#URL.UserID#', '#Form.e_Request#')
        </CFQUERY>
	</cfif>

	<cfset URL.UserID = NewUserID.NewID>
</cfif>

<CFQUERY Name="ResponseCheck" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	PostedBy
FROM
	AuditPlanning2017_Users
WHERE
	ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
	AuditPlanning2017_Users
SET
<cfif URL.UserID_Actual eq "Quality2">
	<cfif len(Form.SurveyArea_Description) AND Form.SurveyArea_Description NEQ "No Comments Added">
	SurveyArea_Description = '#Form.SurveyArea_Description#',
	</cfif>
</cfif>
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
	AuditPlanning2017_Questions.ID, AuditPlanning2017_Users.SurveyType
FROM
	AuditPlanning2017_Questions, AuditPlanning2017_Users
WHERE
	AuditPlanning2017_Users.ID = #URL.UserID#
ORDER BY
	AuditPlanning2017_Questions.ID
</CFQUERY>

<cfdump var="#numQuestions#">

    <cfloop query="numQuestions">
        <cfif isDefined("#ID#_Answer")>
            <!--- if the question exists, add a record in the db --->
            <!--- get record count of Answers table --->
            <CFQUERY Name="CheckRows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID FROM AuditPlanning2017_Answers
            </CFQUERY>

            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID
                FROM AuditPlanning2017_Answers
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
            INSERT INTO AuditPlanning2017_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #URL.UserID#)
            </CFQUERY>

            <cfif isDefined("#ID#_ExtraField_Text")>
           		<cfif len(Evaluate("Form.#ID#_ExtraField_Text"))>
                	 <CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                     UPDATE AuditPlanning2017_Answers
                     SET
                     ExtraField_Text = '#Evaluate("Form.#ID#_ExtraField_Text")#'
                     WHERE
                     ID = #NewID.NewID#
                     </CFQUERY>
                </cfif>
        	</cfif>

            <cfif isDefined("#ID#_ExtraField_CLOB")>
           		<cfif len(Evaluate("Form.#ID#_ExtraField_CLOB"))>
                	 <CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                     UPDATE AuditPlanning2017_Answers
                     SET
                     ExtraField_CLOB = '#Evaluate("Form.#ID#_ExtraField_CLOB")#'
                     WHERE
                     ID = #NewID.NewID#
                     </CFQUERY>
                </cfif>
        	</cfif>
        </cfif>
    </cfloop>
</cfoutput>

<cflocation url="2017_Details.cfm?UserID=#URL.UserID#" addtoken="no">
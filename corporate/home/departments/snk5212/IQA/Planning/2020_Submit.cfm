<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<!--- get new ID --->
<CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID
FROM AuditPlanning2020_Users
</CFQUERY>


<cfif URL.NewArea eq "Yes" AND URL.Type eq "New">
	<!--- add new User row --->
	
	<CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO AuditPlanning2020_Users(ID, Type, pID, SurveyType)
	VALUES(#NewUserID.NewID#, 'New', 0, 'New Area')
	</CFQUERY>
<Cfelse>
	<!--- add new User row --->
	
	<CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO AuditPlanning2020_Users(ID, Type, pID, SurveyType)
	VALUES(#NewUserID.NewID#, '#URL.Type#', #URL.ID#, '#URL.Type#')
	</CFQUERY>
</cfif>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
	AuditPlanning2020_Users
SET

<cfif URL.NewArea eq "Yes" AND URL.Type eq "New">
	<cfif len(Form.SurveyArea_Description) AND Form.SurveyArea_Description NEQ "No Comments Added">
		SurveyArea_Description = '#Form.SurveyArea_Description#',
	</cfif>
	SurveyArea = '#Form.e_SurveyArea#',
</cfif>

Responded='Yes',
Posted=#postDate#,
PostedBy='#Form.PostedInfo#'

WHERE
	ID = #NewUserID.NewID#
</CFQUERY>

<cfoutput>

<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT AuditPlanning2020_Questions.ID, AuditPlanning2020_Users.SurveyType
FROM AuditPlanning2020_Questions, AuditPlanning2020_Users
WHERE AuditPlanning2020_Users.ID = #NewUserID.NewID#
ORDER BY AuditPlanning2020_Questions.ID
</CFQUERY>

<cfdump var="#numQuestions#">

    <cfloop query="numQuestions">
        <cfif isDefined("#ID#_Answer")>
            <!--- if the question exists, add a record in the db --->
            <!--- get record count of Answers table --->
            <CFQUERY Name="CheckRows" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID FROM AuditPlanning2020_Answers
            </CFQUERY>

            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID
                FROM AuditPlanning2020_Answers
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

            <CFQUERY Name="AddRow" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            INSERT INTO AuditPlanning2020_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #NewUserID.NewID#)
            </CFQUERY>

            <cfif isDefined("#ID#_ExtraField_Text")>
           		<cfif len(Evaluate("Form.#ID#_ExtraField_Text"))>
                	 <CFQUERY Name="UpdateRow" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                     UPDATE AuditPlanning2020_Answers
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
                     UPDATE AuditPlanning2020_Answers
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

<cflocation url="2020_Details.cfm?ID=#NewUserID.NewID#" addtoken="no">
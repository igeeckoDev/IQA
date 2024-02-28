<cfset URL.UserID_Actual = URL.UserID>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<cfif URL.UserID eq "Quality" OR URL.UserID eq "ProgramNew" OR URL.UserID eq "Quality2">
	<!--- get new ID --->
    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID
    FROM AuditPlanning2013_Users
    </CFQUERY>

    <cfif URL.UserID eq "Quality">
		<!--- extract Type and pID from Form.e_NameAndType --->
        <cfset Type = ListFirst(Form.e_NameAndType)>
        <Cfset pID = ListLast(Form.e_NameAndType)>
    
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2013_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, '#Type#', #pID#, 'Quality', 'LQM Response')
        </CFQUERY>
	<Cfelseif URL.UserID eq "Quality2">
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2013_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, '#Form.e_SurveyArea#', 0, 'Quality2', '#Form.PostedInfo#')
        </CFQUERY>
	<cfelseif URL.UserID eq "ProgramNew">
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2013_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, '#URL.UserID#', '0', '#URL.UserID#', 'New Program, Service, or Offering')
        </CFQUERY>
	</cfif>

	<cfset URL.UserID = NewUserID.NewID>
</cfif>

<CFQUERY Name="ResponseCheck" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	PostedBy
FROM 
	AuditPlanning2013_Users
WHERE 
	ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	AuditPlanning2013_Users
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

<cfdump var="#Form#">

<cfoutput>
<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT 
	AuditPlanning2013_Questions.ID, AuditPlanning2013_Users.SurveyType
FROM 
	AuditPlanning2013_Questions, AuditPlanning2013_Users
WHERE 
	<cfif URL.UserID_Actual eq "Quality2">
    	AuditPlanning2013_Questions.QuestionType = 'Quality'
    <cfelse>
    	AuditPlanning2013_Questions.QuestionType = AuditPlanning2013_Users.SurveyType
    </cfif>
    AND AuditPlanning2013_Users.ID = #URL.UserID#
ORDER BY
	AuditPlanning2013_Questions.ID
</CFQUERY>

<cfdump var="#numQuestions#">

    <cfloop query="numQuestions">
        <cfif isDefined("#ID#_Answer")>
            <!--- if the question exists, add a record in the db --->
            <!--- get record count of Answers table --->
            <CFQUERY Name="CheckRows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID FROM AuditPlanning2013_Answers
            </CFQUERY>
            
            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID 
                FROM AuditPlanning2013_Answers
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
            INSERT INTO AuditPlanning2013_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #ID#, '#Evaluate("Form.#ID#_Answer")#', '#Notes#', #URL.UserID#)
            </CFQUERY>
            
            <cfif isDefined("#ID#_ExtraField_Text")>
           		<cfif len(Evaluate("Form.#ID#_ExtraField_Text"))>
                	 <CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                     UPDATE AuditPlanning2013_Answers
                     SET
                     ExtraField_Text = '#Evaluate("Form.#ID#_ExtraField_Text")#'
                     WHERE
                     ID = #NewID.NewID#
                     </CFQUERY>
                </cfif>
        	</cfif>
            
            <!---
            <cfif structKeyExists(form, "evaluate("#ID#_ExtraField_FileName")") AND isDefined("#ID#_ExtraField_FileName")>
                <cfset destination = expandPath("./PlanningFiles/Temp")>
            
	            <cffile 
                	action="upload" 
                    filefield="#ID#_ExtraField_FileName" 
                    destination="#destination#" 
                    nameConflict="overwrite">
               
				<cffile
                    action="rename"
                    source="#destination#\#cffile.clientfile#"
                    destination="#destination#\2013_#URL.UserID#_File.#cffile.ClientFileExt#">
                  
            </cfif>
			--->
            
            <!---
            <cfif isDefined("Form.FileName")>
				<cfif len(Form.File)>
                    <CFFILE ACTION="UPLOAD" 
                    FILEFIELD="Form.File" 
                    DESTINATION="#IQARootPath#Planning\Temp" 
                    NAMECONFLICT="OVERWRITE">
                    
                    <cfset FileName="#Form.Name#">
                    
                    <cfset NewFileName="2013_#URL.UserID#_File.#cffile.ClientFileExt#">
                     
                    <cffile
                        action="rename"
                        source="#FileName#"
                        destination="#IQARootPath#Planning\Temp\#NewFileName#">
                      
                    <cffile
                        action="move"
                        source="#IQARootPath#Planning\Temp\#NewFileName#"
                        destination="#IQARootPath#Planning\">
                      
                    <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
                    Update AuditPlanning2013_Answers
                    SET
                    ExtraField_FileName = '#NewFileName#'
                    
                    WHERE #NewID.NewID#
                    </CFQUERY>
				</cfif>
            </cfif>
            --->
            
            <cfif isDefined("#ID#_ExtraField_CLOB")>
           		<cfif len(Evaluate("Form.#ID#_ExtraField_CLOB"))>
                	 <CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                     UPDATE AuditPlanning2013_Answers
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

<cflocation url="2013_Details.cfm?UserID=#URL.UserID#" addtoken="no">
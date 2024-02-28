<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2013 IQA Audit Planning - Survey Results">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditPlanning2013_Users
WHERE ID = #URL.UserID#
</CFQUERY>

<cfif SurveyType.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #SurveyType.pID#
    </cfquery>
<cfelseif SurveyType.Type eq "Process">
	<cfif SurveyType.pID eq 0>
		<CFQUERY BLOCKFACTOR="100" name="qData" Datasource="UL06046">
        SELECT Type as pName
        FROM AuditPlanning2013_Users
        WHERE ID = #URL.UserID#
        </cfquery>
	<cfelse>
        <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
        SELECT ID, Function as pName
        FROM GlobalFunctions
        WHERE ID = #SurveyType.pID#
        </cfquery>
	</cfif>
<cfelseif SurveyType.Type eq "Site">
	<CFQUERY BLOCKFACTOR="100" Name="qData" datasource="Corporate">
    SELECT OfficeName as pName
    From IQAtblOffices
	WHERE ID = #SurveyType.pID#
    </CFQUERY>
</cfif>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	AuditPlanning2013_Answers.ID as aID,
	AuditPlanning2013_Answers.qID,
    AuditPlanning2013_Answers.Answer,
    AuditPlanning2013_Answers.Notes,
    AuditPlanning2013_Answers.ExtraField_Text as ExtraField_Text_Answer,
    AuditPlanning2013_Answers.ExtraField_FileName as ExtraField_FileName_Answer,
    AuditPlanning2013_Answers.ExtraField_CLOB as ExtraField_CLOB_Answer,

    AuditPlanning2013_Questions.Question,
    AuditPlanning2013_Questions.ID,
    AuditPlanning2013_Questions.ExtraField_Text,
    AuditPlanning2013_Questions.ExtraField_FileName,
    AuditPlanning2013_Questions.ExtraField_CLOB,

    AuditPlanning2013_Users.Type,
    AuditPlanning2013_Users.pID,
    AuditPlanning2013_Users.Posted,
    AuditPlanning2013_Users.PostedBy,
    AuditPlanning2013_Users.LaboratoryNames,
    AuditPlanning2013_Users.SurveyArea_Description,
    AuditPlanning2013_Users.SurveyFile

FROM AuditPlanning2013_Answers, AuditPlanning2013_Questions, AuditPlanning2013_Users

WHERE
AuditPlanning2013_Users.ID = #URL.UserID#
AND AuditPlanning2013_Answers.qID = AuditPlanning2013_Questions.ID
AND AuditPlanning2013_Answers.UserID = AuditPlanning2013_Users.ID
ORDER BY qID, aID
</CFQUERY>

Thank you. Please view the <a href="Distribution_2013.cfm?Type=Lab">Survey Distribution List</a> and respond with information about any Process, Program, or Site you are involved with.<br /><Br />

<cfif SurveyType.SurveyType eq "ProgramNew">
	<cfoutput>
    	<u>New Item</u> - <b>#Output.ExtraField_Text_Answer#</b>
    </cfoutput>
<cfelseif SurveyType.Type eq "Program" OR SurveyType.Type eq "Process" OR SurveyType.Type eq "Site">
	<!--- Program or Process or Site --->
	<cfoutput query="qData">
       	<u>#SurveyType.SurveyType# Name</u> - #qData.pName#
    </cfoutput>
<cfelseif SurveyType.SurveyType eq "Lab">
	<b>Laboratory Operations</b>
<cfelseif SurveyType.SurveyType eq "Operations">
	<b>Operations</b>
<cfelse>
	<cfoutput>
    	<u><cfif SurveyType.SurveyType eq "Quality2">Quality Related<cfelse>#SurveyType.SurveyType#</cfif></u> - <b>#SurveyType.Type#</b>
        <cfif SurveyType.SurveyType eq "Quality2">
        	<cfif len(Output.SurveyArea_Description) AND Output.SurveyArea_Description NEQ "No Comments Added">
        	<br /><br />Description: #Output.SurveyArea_Description#
        	</cfif>
        </cfif>
    </cfoutput>
</cfif><br /><br>

<Cfoutput>
Posted By:<br />
#trim(replace(Output.PostedBy, "," ,"<br />", "All"))#<br><br />

Posted Date:<br />
#dateFormat(Output.Posted, "mm/dd/yyyy")#<br><br>

<cflock scope="session" timeout="5">
	<cfif isDefined("SESSION.Auth.isLoggedIn")>
		<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.AccessLevel eq "Admin">
	    	<b>IQA Only - Planning Survey Update - Upload File</b><Br />
	        <cfif len(Output.SurveyFile)>
	        	:: <a href="SurveyFiles/#Output.SurveyFile#">View File</a><br />
	            :: <A href="2013_UploadFile.cfm?USERID=#URL.USERID#">Upload Replacement File</A>
	        <cfelse>
	        	:: <A href="2013_UploadFile.cfm?USERID=#URL.USERID#">Upload File</A>
	        </cfif><br /><br />
	    </cfif>
	</cfif>
</cflock>

<hr>
<br>
</Cfoutput>

<cfset i = 1>
<cfset k = 1>
<cfset previousQuestionID = 0>

<cfoutput query="Output">
	<!--- to handle multiple responses to survey --->
	<cfif previousQuestionID eq qID AND previousQuestionID NEQ 0>
		<cfset i = i - 1>
        <cfset k = k + 1>
    <cfelse>
    	<cfset k = 1>
    </cfif>

<b>#i#</b> #Question#<br /><br />

<u>Answer</u>: <b>#Answer#</b><br />

<cfif len(ExtraField_Text)>
<u>#ExtraField_Text#</u>: <b>#ExtraField_Text_Answer#</b><br /><br />
</cfif>

<u>Notes</u>:<br />
<cfif Notes EQ "No Comments Added">
	#Notes#
<cfelse>
	<b>#Notes#</b>
</cfif><br /><br />

<cfif listlen(PostedBy) GT 1>
Posted By:<br />
#trim(listGetAt(PostedBy, k))#<br />
</cfif>

<!---
<cfif len(ExtraField_FileName)>
<u>#ExtraField_FileName#</u><br>
<b>#ExtraField_FileName_Answer#</b><br /><br />
</cfif>
--->

<cfif len(ExtraField_CLOB)>
<u>#ExtraField_CLOB#</u>:<br />
#ExtraField_CLOB_Answer#<br /><br />
</cfif>

<hr />
<br />
<cfset i = i+1>
<cfset previousQuestionID = qID>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->
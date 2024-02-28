<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2018 IQA Audit Planning - Survey Results">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditPlanning2018_Users
WHERE ID = #URL.ID#
</CFQUERY>

<cfif SurveyType.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #SurveyType.pID#
    </cfquery>
<cfelseif SurveyType.Type eq "Process">
	<CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
	SELECT ID, Function as pName
	FROM GlobalFunctions
	WHERE ID = #SurveyType.pID#
	</cfquery>
<cfelseif SurveyType.Type eq "Quality" OR SurveyType.Type eq "Certification Body">
	<CFQUERY BLOCKFACTOR="100" Name="qData" datasource="Corporate">
    SELECT OfficeName as pName
    From IQAtblOffices
	WHERE ID = #SurveyType.pID#
    </CFQUERY>
<cfelseif SurveyType.Type eq "New Area">
	<cfset qData.pName = SurveyType.SurveyArea>
</cfif>

<CFQUERY Name="Output" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	AuditPlanning2018_Answers.ID as aID,
	AuditPlanning2018_Answers.qID,
    AuditPlanning2018_Answers.Answer,
    AuditPlanning2018_Answers.Notes,
    AuditPlanning2018_Answers.ExtraField_Text as ExtraField_Text_Answer,
    AuditPlanning2018_Answers.ExtraField_FileName as ExtraField_FileName_Answer,
    AuditPlanning2018_Answers.ExtraField_CLOB as ExtraField_CLOB_Answer,

    AuditPlanning2018_Questions.Question,
    AuditPlanning2018_Questions.ID,
    AuditPlanning2018_Questions.ExtraField_Text,
    AuditPlanning2018_Questions.ExtraField_FileName,
    AuditPlanning2018_Questions.ExtraField_CLOB,

    AuditPlanning2018_Users.Type,
    AuditPlanning2018_Users.pID,
    AuditPlanning2018_Users.SentTo,
    AuditPlanning2018_Users.Posted,
    AuditPlanning2018_Users.PostedBy,
    AuditPlanning2018_Users.LaboratoryNames,
    AuditPlanning2018_Users.SurveyArea_Description,
    AuditPlanning2018_Users.SurveyFile,
	AuditPlanning2018_Users.SurveyType,
	AuditPlanning2018_Users.SurveyArea

FROM AuditPlanning2018_Answers, AuditPlanning2018_Questions, AuditPlanning2018_Users

WHERE
AuditPlanning2018_Users.ID = #URL.ID#
AND AuditPlanning2018_Answers.qID = AuditPlanning2018_Questions.ID
AND AuditPlanning2018_Answers.UserID = AuditPlanning2018_Users.ID
ORDER BY qID, aID
</CFQUERY>

Thank you.<br><br>

<Cfoutput>
Please view the <a href="Distribution_2018.cfm?Type=#Output.SurveyType#">Survey Distribution Lists</a> and respond with information about any Process, Program, or Site you are involved with.<br /><Br />
</cfoutput>

<cfif SurveyType.SurveyType eq "New Area">
	<cfoutput>
    	<u>New Item</u> - <b>#Output.SurveyArea#</b>
		
		<cfif len(Output.SurveyArea_Description) AND Output.SurveyArea_Description NEQ "No Comments Added">
        	<br /><u>Description</u>: #Output.SurveyArea_Description#
        </cfif>
    </cfoutput>
<cfelseif SurveyType.Type eq "Program" 
	OR SurveyType.Type eq "Process" 
	OR SurveyType.Type eq "Quality"
	OR SurveyType.Type eq "Certification Body">
	
	<!--- Program or Process or Site --->
	<cfoutput query="qData">
       	<u>#SurveyType.SurveyType# Survey Subject</u> - <b>#qData.pName#</b>
    </cfoutput>
</cfif>
<br /><br>

<Cfoutput>
Posted By:<br />
#trim(replace(Output.PostedBy, "," ,"<br />", "All"))#<br><br />

Posted Date:<br />
#dateFormat(Output.Posted, "mm/dd/yyyy")#<br><br>

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
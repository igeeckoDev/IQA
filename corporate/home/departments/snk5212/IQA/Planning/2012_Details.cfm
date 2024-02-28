<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2012 IQA Audit Planning - Survey Results">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditPlanning_Users
WHERE ID = #URL.UserID#
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
<cfelseif SurveyType.Type eq "Site">
	<CFQUERY BLOCKFACTOR="100" Name="qData" datasource="Corporate">
    SELECT OfficeName as pName
    From IQAtblOffices
	WHERE ID = #SurveyType.pID#
    </CFQUERY>
</cfif>

<cfif SurveyType.Type eq "WiSE" OR SurveyType.Type eq "VS" OR SurveyType.Type eq "ULE">
	<cfoutput>
    	<u>Organization Name</u> - <b>#SurveyType.Type#</b>
    </cfoutput>
<cfelseif SurveyType.Type eq "New">
	<cfoutput>
    	<u>New Item</u> - <b>#SurveyType.Request#</b>
    </cfoutput>
<cfelseif SurveyType.Type eq "Lab">
	<b>Laboratory Operations</b>
<cfelse>
	<!--- Program or Process or Site --->
	<cfoutput query="qData">
		<u>#SurveyType.Type# Name</u> - #qData.pName# <!--- Program or Process name from query above --->
	</cfoutput>
</cfif><br />

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	AuditPlanning_Answers.ID as aID,
	AuditPlanning_Answers.qID,
    AuditPlanning_Answers.Answer,
    AuditPlanning_Answers.Notes,
    AuditPlanning_Answers.ExtraField_Text as ExtraField_Text_Answer,

    AuditPlanning_Questions.Question,
    AuditPlanning_Questions.ID,
    AuditPlanning_Questions.ExtraField_Text,

    AuditPlanning_Users.Type,
    AuditPlanning_Users.pID,
    AuditPlanning_Users.Posted,
    AuditPlanning_Users.PostedBy

FROM AuditPlanning_Answers, AuditPlanning_Questions, AuditPlanning_Users

WHERE
AuditPlanning_Users.ID = #URL.UserID#
AND AuditPlanning_Answers.qID = AuditPlanning_Questions.ID
AND AuditPlanning_Answers.UserID = AuditPlanning_Users.ID
ORDER BY qID, aID
</CFQUERY>

<Cfoutput>
Posted By: #Output.PostedBy#<br>
Posted Date: #dateFormat(Output.Posted, "mm/dd/yyyy")#<br><br>
<hr>
<br>
</Cfoutput>

<cfset i = 1>
<cfset previousQuestionID = 0>
<cfoutput query="Output">
	<!--- to handle multiple responses to survey --->
	<cfif previousQuestionID eq qID AND previousQuestionID NEQ 0>
		<cfset i = i - 1>
    </cfif>
<b>#i#</b> #Question#<br /><br />

<u>Answer</u>: <b>#Answer#</b><br />

<cfif len(ExtraField_Text)>
<u>#ExtraField_Text#</u>: <b>#ExtraField_Text_Answer#</b><br />
</cfif>

<u>Notes</u>:<br />
<cfif Notes EQ "No Comments Added">
	#Notes#
<cfelse>
	<b>#Notes#</b>
</cfif>
<br /><br />
<hr />
<br />
<cfset i = i+1>
<cfset previousQuestionID = qID>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->
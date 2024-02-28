<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2016 DAP Audit Planning - Survey Results">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPAuditPlanning2016_Users
WHERE ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	DAPAuditPlanning2016_Answers.ID as aID,
	DAPAuditPlanning2016_Answers.qID,
    DAPAuditPlanning2016_Answers.Answer,
    DAPAuditPlanning2016_Answers.Notes,

    DAPAuditPlanning2016_Questions.Question,
    DAPAuditPlanning2016_Questions.ID,
    DAPAuditPlanning2016_Questions.ExtraField_Text,
    DAPAuditPlanning2016_Questions.ExtraField_FileName,
    DAPAuditPlanning2016_Questions.ExtraField_CLOB,

    DAPAuditPlanning2016_Users.Type,
    DAPAuditPlanning2016_Users.pID,
    DAPAuditPlanning2016_Users.SentTo,
    DAPAuditPlanning2016_Users.Posted,
    DAPAuditPlanning2016_Users.PostedBy,
    DAPAuditPlanning2016_Users.LaboratoryNames,
    DAPAuditPlanning2016_Users.SurveyArea_Description,
    DAPAuditPlanning2016_Users.SurveyFile

FROM DAPAuditPlanning2016_Answers, DAPAuditPlanning2016_Questions, DAPAuditPlanning2016_Users

WHERE
DAPAuditPlanning2016_Users.ID = #URL.UserID#
AND DAPAuditPlanning2016_Answers.qID = DAPAuditPlanning2016_Questions.ID
AND DAPAuditPlanning2016_Answers.UserID = DAPAuditPlanning2016_Users.ID
ORDER BY qID, aID
</CFQUERY>

Please view the <a href="DAP_Distribution_2016.cfm">Survey Distribution List</a><br /><Br />

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

<cfif i lte 3>
<u>Answer</u>: <b>#Answer#</b><br />
</cfif>

<u>Comments</u>:<br />
<cfif Notes EQ "No Comments Added">
	#Notes#
<cfelse>
	<b>#Notes#</b>
</cfif><br /><br />

<cfif listlen(PostedBy) GT 1>
Posted By:<br />
#trim(listGetAt(PostedBy, k))#<br />
</cfif>

<hr />
<br />
<cfset i = i+1>
<cfset previousQuestionID = qID>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->
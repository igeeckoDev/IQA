<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Survey - Survey Results">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM AuditSurvey_Users
WHERE ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	AuditSurvey_Answers.ID as aID,
	AuditSurvey_Answers.qID, 
    AuditSurvey_Answers.Answer, 
    AuditSurvey_Answers.Notes, 
    
    AuditSurvey_Questions.Question, 
    AuditSurvey_Questions.ID, 
    
    AuditSurvey_Users.AuditID,
    AuditSurvey_Users.AuditYear,
    AuditSurvey_Users.SentTo,
    AuditSurvey_Users.Posted,
    AuditSurvey_Users.PostedBy,
	AuditSurvey_Users.SentDate,
    AuditSurvey_Users.GivenName,
    AuditSurvey_Users.GivenEmail

FROM AuditSurvey_Answers, AuditSurvey_Questions, AuditSurvey_Users

WHERE 
AuditSurvey_Users.ID = #URL.UserID#
AND AuditSurvey_Answers.qID = AuditSurvey_Questions.ID
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
AND AuditSurvey_Questions.Status IS NULL
ORDER BY qID, aID
</CFQUERY>

<Cfoutput>
<!---
<b>Posted By</b>:<br />
#trim(replace(Output.PostedBy, " / " ,"<br />", "All"))#<br><br />
--->

<b>Posted By</b>:<br />
<cfif isDefined("Output.givenName") AND len(Output.givenName)>
    #Output.givenName#
<cfelse>
	No Name listed
</cfif><br />

<cfif isDefined("Output.givenEmail") AND len(Output.givenEmail)>
	#Output.givenEmail#
<cfelse>
	No Email listed
</cfif><br /><br />

<b>Posted Date</b>:<br />
#dateFormat(Output.Posted, "mm/dd/yyyy")#<br><br>
</Cfoutput>

<CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
FROM AuditSchedule
WHERE ID = #Output.AuditID#
AND Year_ = #Output.AuditYear#
</CFQUERY>

<cfoutput query="Audit">
This survey is in reference to audit <b>#Year#-#ID#-IQA</b>:<br>
<u>Type of Audit</u>: #AuditType2# / #OfficeName#<br>
<u>Audit Area</u>: #Area#<br><br>
</cfoutput>

<hr>
<br>

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

<u>Answer</u>: <b>#Answer# <cfif Answer eq "0">- N/A<cfelseif Answer eq "1">- Extremely Dissatisfied<cfelseif Answer eq "2">- Dissatisfied<cfelseif Answer eq "3">- Neither Dissatisfied nor Satisfied<cfelseif Answer eq "4">- Satisfied<cfelseif Answer eq "5">- Extremely Satisfied</cfif></b><br />

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
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
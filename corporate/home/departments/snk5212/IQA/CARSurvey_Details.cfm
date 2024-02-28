<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Survey - Survey Results">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Thanks for participating in the CAR survey! Your feedback will help us as we continue to help CAR Owners.<br><br>

<CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM CARSurvey_Users
WHERE ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	CARSurvey_Answers.ID as aID,
	CARSurvey_Answers.qID,
    CARSurvey_Answers.Answer,
    CARSurvey_Answers.Notes,

    CARSurvey_Questions.Question,
    CARSurvey_Questions.ID,

    CARSurvey_Users.Quarter,
    CARSurvey_Users.Year_,
	CARSurvey_Users.Focus,
    CARSurvey_Users.SentTo,
    CARSurvey_Users.Posted,
    CARSurvey_Users.PostedBy,
	CARSurvey_Users.SentDate,
    CARSurvey_Users.GivenName,
    CARSurvey_Users.GivenEmail

FROM CARSurvey_Answers, CARSurvey_Questions, CARSurvey_Users

WHERE
CARSurvey_Users.ID = #URL.UserID#
AND CARSurvey_Answers.qID = CARSurvey_Questions.ID
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID
AND CARSurvey_Questions.Status IS NULL
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
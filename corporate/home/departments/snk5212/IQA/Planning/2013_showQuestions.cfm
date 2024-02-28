<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Questions">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT 
	* 
FROM 
	AuditPlanning2013_Questions
    WHERE 
    <cfif URL.SurveyType eq "All">
    1=1
	<cfelse>
    QuestionType = '#URL.SurveyType#'
	</cfif>
ORDER BY 
	QuestionType, ID
</CFQUERY>

<a href="2013_showQuestions.cfm?SurveyType=ProgramNew">New Programs, Services, and Offerings</a><br>
<a href="2013_showQuestions.cfm?SurveyType=Program">Programs, Services, and Offerings</a><br>
<a href="2013_showQuestions.cfm?SurveyType=Process">Process</a><br>
<a href="2013_showQuestions.cfm?SurveyType=Quality">Quality / Site</a><br>
<a href="2013_showQuestions.cfm?SurveyType=Lab">Laboratory</a><br>
<a href="2013_showQuestions.cfm?SurveyType=Operations">Operations</a><br>
<a href="2013_showQuestions.cfm?SurveyType=Other Sites">Sites Outside of Public Safety</a><br><Br>

Currently Viewing: <cfoutput><b>#URL.SurveyType#</b></cfoutput><br><br>

<hr><br><br>

<cfif URL.SurveyType eq "Program">
<!--- use progID from URL when page is ready to go --->
    <cfset ProgramID = 71>
    <cfoutput>
    	Current Program Name = [Will go Here]<br>
        Current Program Details = [<a href="../IQA/_prog_Detail.cfm?progID=#ProgramID#">Link</a>]<br>
        To Add a new Program = [<a href="2013.cfm?SurveyType=ProgramNew" target="_blank">New Program Survey</a>]<br><br>
    </cfoutput>
</cfif>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="2013_Submit.cfm?#CGI.QUERY_STRING#">

<cfset i = 1>
<cfoutput query="Questions">

<!---
[ID = #ID#]<br />
#QuestionType#<br />
--->

<b>#i#</b> : #Question#<br /><Br />

Yes / No:<br />
<cfselect 
    queryposition="below" 
    name="#ID#_Answer"
    data-bvalidator="required" 
    data-bvalidator-msg="Question #i#: Select Yes or No">
        <option value="">--</option>
        <option value="Yes">Yes</option>
        <option value="No">No</option>
</cfselect>
<br /><br />

Notes:<br />
<cftextarea 
	name="#ID#_Notes" 
    cols="60" 
    rows="6"
    data-bvalidator="required" 
    data-bvalidator-msg="Question #i#: Notes">No Comments Added</cftextarea>
<br /><br />

<cfif len(ExtraField_Text)>
#ExtraField_Text#:<Br />
<cfinput name="#ID#_ExtraField_Text" 
	type="text" 
    size="50" 
    maxlength="50"
    value="Trainer's Name"
    data-bvalidator="required" 
    data-bvalidator-msg="Question #i#: #ExtraField_Text#">
<Br /><br />
</cfif>

<cfif len(ExtraField_FileName)>
#ExtraField_FileName#:<Br />
<cfinput name="#ID#_ExtraField_FileName" 
	type="File">
<Br /><br />
</cfif>

<cfif len(ExtraField_CLOB)>
#ExtraField_CLOB#:<br />
<cftextarea 
	name="#ID#_ExtraField_CLOB" 
    cols="60" 
    rows="6"
    data-bvalidator="required" 
    data-bvalidator-msg="Question #i# #ExtraField_CLOB#">No Comments Added</cftextarea>
<br /><br />
</cfif>

<cfif i LT Questions.RecordCount>
<hr>
</cfif>

<br><br>

<cfset i = i+1>
</cfoutput>

<input type="submit" value="Submit Survey">
<input type="reset" value="Reset Form"><br /><br />

</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->
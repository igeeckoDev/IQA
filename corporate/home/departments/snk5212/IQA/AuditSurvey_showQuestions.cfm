<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Survey - Questions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT 
	ID, Question
FROM 
	AuditSurvey_Questions
WHERE
	Status IS NULL
ORDER BY 
	ID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="">

Please provide your name (Optional):<Br />
<cfinput type="text" size="60" name="Name"><br /><br />

Please provide your email (Ooptional):<br />
<cfinput type="text" size="60" name="Email"><br /><br />

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
    data-bvalidator-msg="Question #i#: Select a Value">
        <option value="">--</option>
        <option value="0">N/A</option>
        <option value="1">1 - Extremely Satisfied</option>
        <option value="2">2 - Dissastisfied</option>
        <option value="3">3 - Neither Satisfied or Dissatisfied</option>
        <option value="4">4 - Satisfied</option>
        <option value="5">5 - Extremely Satisified</option>
</cfselect>
<br /><br />

Notes:<br />
<cftextarea 
	name="#ID#_Notes" 
    cols="60" 
    rows="6">No Comments Added</cftextarea>
<br /><br />

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
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
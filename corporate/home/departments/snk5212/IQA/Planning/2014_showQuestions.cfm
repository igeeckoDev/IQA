<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Questions">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT 
	ID, Question
FROM 
	AuditPlanning2014_Questions
ORDER BY 
	ID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="">

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
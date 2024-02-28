<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2019 IQA Audit Planning - Questions">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfset SurveyYear = 2019>
<cfset SurveyType.SurveyType = URL.Type>

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT
	*
FROM
	AuditPlanning2019_Questions
ORDER BY
	ID
</CFQUERY>

<!---
<a href="2019.cfm?SurveyType=New">New Programs, Services, and Offerings</a><br>
<a href="2019.cfm?SurveyType=Program">Programs, Services, and Offerings</a><br>
<a href="2019.cfm?SurveyType=Process">Process</a><br>
<a href="2019.cfm?SurveyType=Quality">Local Quality Managers</a><br>
<a href="2019.cfm?SurveyType=Laboratory">Laboratory</a><br>
<a href="2019.cfm?SurveyType=Operations">Operations</a><br>
<a href="2019.cfm?SurveyType=Other Sites">Sites Outside of Public Safety</a><br><Br>

Currently Viewing: <cfoutput><b>#URL.SurveyType#</b></cfoutput><br><br>

<hr><br><br>
--->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="2019_Submit.cfm?#CGI.QUERY_STRING#" enctype="multipart/form-data">

<cfif URL.NewArea eq "Yes">
	<b>Identify the Survey Area</b><br><br>
	
    New Process, Site, Accreditor, Certification Scheme, Certification Body, Business Unit, Calibration Laboratory, Testing Laboratory, etc. (100 characters max)<br />
    <cfinput type="text" name="e_SurveyArea" size="80" maxlength="100" data-bvalidator="required" data-bvalidator-msg="Survey Area" /><br><br>

    Detailed description of Survey Area: (optional):<br />
    <cftextarea
        name="SurveyArea_Description"
        cols="60"
        rows="6">No Comments Added</cftextarea>
<cfelse>
	Please Enter Survey Information below<br><br>

	<cfif URL.Type eq "Quality">
		<CFQUERY Name="Survey" datasource="Corporate">
		SELECT OfficeName as Name
		From IQAtblOffices
		WHERE ID = #URL.ID#
		</CFQUERY>
	<cfelseif URL.Type eq "Certification Body">
		<CFQUERY Name="Survey" datasource="Corporate">
		SELECT OfficeName as Name
		From IQAtblOffices
		WHERE ID = #URL.ID#
		</CFQUERY>
	<cfelseif URL.Type eq "Process">
		<CFQUERY Name="Survey" datasource="Corporate">
		SELECT Function as Name
		From GlobalFunctions
		WHERE ID = #URL.ID#
		</CFQUERY>
	<cfelseif URL.Type eq "Program">
		<CFQUERY Name="Survey" datasource="Corporate">
		SELECT Program as Name
		From ProgDev
		WHERE ID = #URL.ID#
		</CFQUERY>
	</cfif>
	
	<cfoutput query="Survey">
	Survey Subject: <b>#Name#</b>
	
	<cfinput size="80" type="hidden" name="TypeID"  />
	<cfinput size="80" type="hidden" name="Type" />
	</cfoutput>
</cfif>
<br><br>

Please Input Your Name<br />
<cfinput size="80" type="text" name="PostedInfo" data-bvalidator="required" data-bvalidator-msg="Name" />

<br /><br />
Please Input Your Email (@ul.com)<br />
<cfinput size="80" type="text" name="PostedBy" data-bvalidator="required" data-bvalidator-msg="Email" />

<br /><br />
<hr />
<br />

Note - These questions are generic in nature to allow Engineering, Laboratory, Certification Body, Scheme/Program/Process, and Quality staff to respond. Not all questions may apply to your area.<br><br>

For <u>Operations</u> and <u>Laboratory</u> staff - the primary scheme involved in this survey is <u>US and Canada safety scheme</u>, in addition to any other schemes conducted in your group (Energy Star, D, GS, CB, etc).<br><br>

<hr><br>

<cfset i = 1>
<cfoutput query="Questions">

<!---
[ID = #ID#]<br />
#QuestionType#<br />
--->

<cfif i eq 12>
	<b>New Audit Areas</b><br><br>
<cfelseif i eq 11>
	<b>Cancelled or Withdrawn Audit Areas</b><br><br>
</cfif>

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
        <option value="NA">Not Applicable</option>
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
    value="#ExtraField_Text#"
    data-bvalidator="required"
    data-bvalidator-msg="Question #i#: #ExtraField_Text#">
<Br /><br />
</cfif>

<!---
<cfif len(ExtraField_FileName)>
#ExtraField_FileName#:<Br />
<input name="#ID#_ExtraField_FileName"
	type="File">
<Br /><br />
</cfif>
--->

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
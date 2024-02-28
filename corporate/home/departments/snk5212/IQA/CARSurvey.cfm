<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Survey - Questions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.EmpNo")>
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, preferred_name, employee_email, employee_number
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
    WHERE employee_number='#form.EmpNo#'
    </CFQUERY>

	<cfif QEmpLookup.recordcount gt 0>
    	<cfset EmpFieldType="Hidden">
    	<cfif len(QEmpLookup.preferred_name)>
	       <cfset v_name = #QEmpLookup.preferred_name# & " " & #QEmpLookup.last_name# >
		<cfelse>
			<cfset v_name = #QEmpLookup.first_n_middle# & " " & #QEmpLookup.last_name# >
        </cfif>
        <cfset v_email = #QEmpLookup.employee_email#>
   		<cfset qresult = 0>
        <cfset Form.PostedBy = #QEmpLookup.employee_number#>
    <cfelse>
		<cfset Form.PostedBy = "00000">
    	<cfset EmpFieldType="Text">
    	<cfset v_name = ''>
      	<cfset qresult = 1>
    </cfif>
<cfelse>
	<cfset Form.PostedBy = "00000">
	<cfset EmpFieldType="Text">
	<cfset v_name = ''>
    <cfset qresult = 1>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT
	ID, Question
FROM
	CARSurvey_Questions
WHERE
	Status IS NULL
ORDER BY
	ID
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" name="Users" Datasource="UL06046">
SELECT
	SentTo
FROM
	CARSurvey_Users
WHERE
	ID = #URL.ID#
</CFQUERY>
--->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="CARSurvey_Submit.cfm?#CGI.QUERY_STRING#" enctype="multipart/form-data">

Please provide your name (Optional):<Br />
<cfinput type="text" size="60" name="givenName"><br /><br />

Please provide your email (Optional):<br />
<cfinput type="text" size="60" name="givenEmail"><br /><br />

<cfif isDefined("Form.EmpNo") AND Form.PostedBy NEQ "00000">
	<cfinput type="hidden" value="#v_name#" name="PostedBy_Name">
	<cfinput type="hidden" value="#v_email#" name="PostedBy_Email">
	<cfinput type="hidden" value="#Form.PostedBy#" name="PostedBy_EmpNo">

    <!---
	<cfset SurveyUsers = valueList(Users.SentTo, ",")>
	<cfset Referred = find(v_email, SurveyUsers)>

	<cfif Referred eq 0>
        <cfinput type="hidden" name="vReferred" value="Yes">
    <cfelse>
        <cfinput type="hidden" name="vReferred" value="No">

        <CFQUERY BLOCKFACTOR="100" name="Users" Datasource="UL06046">
        SELECT
            ID
        FROM
            CARSurvey_Users
        WHERE
            ID = #URL.ID#
            AND SentTo = '#v_email#'
        </CFQUERY>

        <cfinput type="hidden" value="#Users.ID#" name="UserID">
    </cfif>
	--->
<cfelse>
	<cfinput type="hidden" value="None" name="PostedBy_Name">
	<cfinput type="hidden" value="None" name="PostedBy_Email">
	<cfinput type="hidden" value="0000" name="PostedBy_EmpNo">

	<cfinput type="hidden" name="vReferred" value="Yes">
</cfif>

<!---
<cfinput type="hidden" name="AuditID" value="#URL.ID#">
<cfinput type="hidden" name="AuditYear" value="#URL.year#">
--->

<b>Note</b>: If any of your comments are specific to a certain CAR Administrator/Champion, please include their name.<br><br>

<hr><br><br>

<cfset i = 1>
<cfoutput query="Questions">

<b>#i#</b> : #Question#<br /><Br />

<cfselect
    queryposition="below"
    name="#ID#_Answer"
    data-bvalidator="required"
    data-bvalidator-msg="Question #i#: Select a Value">
        <option value="">--</option>
	    <option value="5">5 - Extremely Satisfied</option>
        <option value="4">4 - Satisfied</option>
        <option value="3">3 - Neither Satisfied or Dissatisfied</option>
        <option value="2">2 - Dissatisfied</option>
        <option value="1">1 - Extremely Dissatisfied</option>
        <option value="0">N/A</option>
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
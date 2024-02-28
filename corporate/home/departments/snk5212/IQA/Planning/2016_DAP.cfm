<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2016 DAP Audit Planning - Questions">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.PostedBy")>
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, preferred_name
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
    WHERE employee_number='#form.PostedBy#'
    </CFQUERY>

	<cfif QEmpLookup.recordcount gt 0>
    	<cfset EmpFieldType="Hidden">
    	<cfif len(QEmpLookup.preferred_name)>
	       <cfset v_name = #QEmpLookup.preferred_name# & " " & #QEmpLookup.last_name# >
		<cfelse>
			<cfset v_name = #QEmpLookup.first_n_middle# & " " & #QEmpLookup.last_name# >
        </cfif>
   		<cfset qresult = 0>
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
	DAPAuditPlanning2016_Questions
ORDER BY
	ID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

Dear BU managers, Industry Coordinators, and Operations Staff:<br><br>

Assignment of DAP Audits for 2016 has begun. Our ultimate goal is to ensure that your BU based Auditor supply (capacity) meets your BU Audit
needs (Audit demand / quality).<br><br>

To help us in the process, we are requesting your input in meeting our shared goal for the 2016 audit year. This information will be included
in our audit and training plans.<br><br>

Please contact <a href="mailto:Linda.M.Ziemnick@ul.com">Linda Ziemnick</a> (North America) or <a href="mailto:Larisa.Aoyagi@ul.com">Larisa Aoyagi</a>
(EULA, AP) for questions about this Survey.<br /><br />
<hr />
<br />

<cfform method ="post" id="myform" name="myform" action="2016_DAP_Submit.cfm?#CGI.QUERY_STRING#" enctype="multipart/form-data">

<cfoutput>
    <cfif isDefined("Form.PostedBy") AND Form.PostedBy NEQ "00000">
    	<u>Posted By</u> - #v_name# (#Form.PostedBy#)
	</cfif>

	<cfif isDefined("Form.PostedBy") AND Form.PostedBy EQ "00000">
       	<br />Please Input Your Name<br />
	    <cfinput size="80" type="#EmpFieldType#" name="PostedInfo" value="#v_name#" />
	</cfif>

	<cfif isDefined("Form.PostedBy") AND Form.PostedBy NEQ "00000">
       	<cfinput type="hidden" name="PostedInfo" value="#v_name# (#Form.PostedBy#)" />
    </cfif>
</cfoutput>
<br /><br />
<hr />
<br />

<cfset i = 1>
<cfoutput query="Questions">

<b>#i#</b> : #Question#<br /><Br />

<cfif i lte 3>
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
<cfelseif i eq 4>
	<cfinput type="hidden" name="#ID#_Answer" value="N/A">
</cfif>

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
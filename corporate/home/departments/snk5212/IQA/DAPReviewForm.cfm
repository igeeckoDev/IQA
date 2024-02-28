<!--- http://usnbkiqas100p/departments/snk5212/IQA/getEmpNo.cfm?page=DAPReviewForm --->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfparam name="form.empNo" default="">

<cfif isDefined("Form.EmpNo")>
	<cftry>
		<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
		SELECT first_n_middle, last_name, preferred_name, employee_email
		FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
		WHERE employee_number='#form.EmpNo#'
		</CFQUERY>

	<cfcatch type="any">
		<cfset querySuccess = "No">
	</cfcatch>
	</cftry>
	
	<cfif isDefined("QempLookup.RecordCount") AND QEmpLookup.recordcount gt 0>
		<cfset querySuccess = "Yes">		
		<cfset EmpFieldType="Hidden">
		
		   <cfif len(QEmpLookup.preferred_name)>
				<cfset v_name = #QEmpLookup.preferred_name# & " " & #QEmpLookup.last_name# >
		   <cfelse>
				<cfset v_name = #QEmpLookup.first_n_middle# & " " & #QEmpLookup.last_name# >
		   </cfif>
		  
		  <cfset v_email = #QEmpLookup.employee_email#>
		  <cfset qresult = 0>
		<cfelse>
			<cfset querySuccess = "No">
			<cfset EmpFieldType="Text">
			<cfset v_name = ''>
			<cfset v_email = ''>
			<cfset qresult = 1>
		</cfif>
<cfelse>
	<cfset querySuccess = "No">
	<cfset EmpFieldType="Text">
	<cfset v_name = ''>
    <cfset v_email = ''>
    <cfset qresult = 1>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT
	ID, Question, ProgramType
FROM
	DAPReviewForm_Questions
WHERE
	Status IS NULL
ORDER BY
	ID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="DAPReviewForm_Submit.cfm">

<b>Lead Auditor Name</b><Br />
<cfinput type="text" size="60" name="AuditorName" data-bvalidator="required" data-bvalidator-msg="Lead Auditor Name: Required"><br /><br />

<b>Lead Auditor Email</b> (format: @ul.com) [<A href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_blank">Lookup</a>]<Br />
<cfinput type="text" size="60" name="AuditorEmail" data-bvalidator="required" data-bvalidator-msg="Lead Auditor Email: Required"><br /><br />

<b>Lead Auditor's Manager Email</b> (format: @ul.com) [<A href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_blank">Lookup</a>]<Br />
<cfinput type="text" size="60" name="AuditorManagerEmail" data-bvalidator="required" data-bvalidator-msg="Lead Auditor Email: Required"><br /><br />

<cfif querySuccess eq "Yes">
	<cfoutput query="QEmpLookup">
		<b>Reviewer Name/Email</b><br>
		#v_name# / #v_email#<br><br>

		<cfinput type="hidden" name="EmpNo" value="#form.EmpNo#">
		<cfinput type="hidden" name="ReviewerName" value="#v_name#">
		<cfinput type="hidden" name="PostedBy" value="#v_email#">
	</cfoutput>
<cfelse>
	<b>Reviewer Name</b><br>
	<cfinput type="text" size="60" name="ReviewerName" data-bvalidator="required" data-bvalidator-msg="Reviewer Name: Required"><br /><br />
	
	<b>Reviewer Email</b> (format: @ul.com) [<A href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_blank">Lookup</a>]<Br />
	<cfinput type="text" size="60" name="PostedBy" data-bvalidator="required" data-bvalidator-msg="Reviewer Email: Required"><br /><br />

	<b>Reviewer Employee Number</b><Br />
	<cfinput type="text" size="60" name="EmpNo" data-bvalidator="required" data-bvalidator-msg="Reviewer Employee Number: Required"><br /><br />
</cfif>

<cfoutput>
	<b>Date</b><br>
	#curDate#<br><br>
</cfoutput>

<b>DA File Number</b> (Examples: DA2000, DA200, DA20, DA2)<br>
<cfinput type="text" size="60" name="DAFileNumber" data-bvalidator="required" data-bvalidator-msg="DA File Number: Required"><br /><br />

<b>Project Number</b><br>
<cfinput type="text" size="60" name="ProjectNumber" data-bvalidator="required" data-bvalidator-msg="Project Number: Required"><br /><br />

<b>Program Audited</b><br>
<cfselect
    queryposition="below"
    name="ProgramAudited"
    data-bvalidator="required"
    data-bvalidator-msg="Program Audited: Select a Value">
        <option value="">Select from list below</option>
			<option value="CBTL">CBTL</option>
	        <option value="CTDP">CTDP</option>
	        <option value="CTF">CTF</option>
	        <option value="PPP">PPP</option>
	        <option value="TCP">TCP</option>
	        <option value="TPTDP">TPTDP</option>
			<option value="Multiple Programs">Multiple Programs</option>
</cfselect><br><br>

<b>Multiple Programs</b><br>
If you selected "Multiple Programs" above, please list them here:<Br>
<cftextarea
	name="MultiplePrograms"
    cols="60"
    rows="6">No Comments Added</cftextarea>
<br /><br />

<b>Assessment Type</b><br>
<cfselect
    queryposition="below"
    name="AuditType"
    data-bvalidator="required"
    data-bvalidator-msg="Assessment Type: Select a Value">
        <option value="">Select from list below</option>
        <option value="Annual">Annual</option>
        <option value="Gap">Gap</option>
        <option value="Initial">Initial</option>
        <option value="Relocation">Relocation</option>
        <option value="On Site Scope Expansion">On Site Scope Expansion</option>
        <option value="Technical">Technical</option>
</cfselect><br><br>

<b>DAP Scope Reviews</b><br>
<cfselect
    queryposition="below"
    name="DAPScopeReviews"
    data-bvalidator="required"
    data-bvalidator-msg="DAP Scope Reviews: Select a Value">
        <option value="">Select from list below</option>
        <option value="1 scope completed">1 scope completed</option>
        <option value="2 scopes completed">2 scopes completed</option>
</cfselect><br><br>

DAP Scope Reviews - Comments:<br />
<cftextarea
	name="DAPScopeReviews_Comments"
    cols="60"
    rows="6">No Comments Added</cftextarea>
<br /><br />

<cfset i = 1>
<cfoutput query="Questions">

<b>#i#</b> : #Question#
<font class="warning">
	<cfif i eq 4><br><br>Select N/A for CTF and CBTL<cfelseif i eq 8><br><br>Select N/A for CTDP, TCP, TPTDP, and PPP</cfif>
</font>
<br /><Br />

Yes / No:<br />
<cfselect
    queryposition="below"
    name="#ID#_Answer"
    data-bvalidator="required"
    data-bvalidator-msg="Question #i#: Select a Value">
        <option value="">--</option>
        <option value="1">Yes</option>
		<option value="0">No</option>       
		
		<cfif i eq 4 
			or i eq 7 
			or i eq 6
			or i eq 8>
			<option value="2">N/A</option>
		</cfif>
</cfselect>
<br /><br />

Comments:<br />
<cftextarea
	name="#ID#_Notes"
    cols="60"
    rows="6">No Comments Added</cftextarea>
<br /><br />

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
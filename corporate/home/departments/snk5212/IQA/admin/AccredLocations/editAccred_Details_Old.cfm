<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<cfif isDefined("Form.PostedBy")>
    <CFQUERY NAME="QEmpLookup_New" datasource="OracleNet">
    SELECT first_n_middle, last_name, preferred_name
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE employee_number='#Form.PostedBy#' 
    </CFQUERY>
    
	<cfif QEmpLookup_New.recordcount gt 0> 
    	<cfset EmpFieldType_New="Hidden">
    	<cfif len(QEmpLookup_New.preferred_name)>
	       <cfset v_name_New = #QEmpLookup_New.preferred_name# & " " & #QEmpLookup_New.last_name# >
		<cfelse>
			<cfset v_name_New = #QEmpLookup_New.first_n_middle# & " " & #QEmpLookup_New.last_name# >
        </cfif>
   		<cfset qresult_New = 0>
    <cfelse>
    	<cfset EmpFieldType_New="Text">
    	<cfset v_name_New = ''>
      	<cfset qresult_New = 1>
    </cfif>
<cfelse>
	<cfset EmpFieldType_New="Text">
	<cfset v_name_New = ''>
    <cfset qresult_New = 1>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="EditAccreditation" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, IQAtblOffices.Region, IQAtblOffices.SubRegion, Accreditors.Accreditor, Accreditors.ID, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	AccredLocations.ID = #URL.ID#
	AND IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<CFQUERY NAME="QEmpLookup_Query" datasource="OracleNet">
SELECT first_n_middle, last_name, preferred_name
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_number='#EditAccreditation.PostedBy#' 
</CFQUERY>

<cfif QEmpLookup_Query.recordcount gt 0> 
    <cfset EmpFieldType="Hidden">
    <cfif len(QEmpLookup_Query.preferred_name)>
       <cfset v_name_Query = #QEmpLookup_Query.preferred_name# & " " & #QEmpLookup_Query.last_name# >
    <cfelse>
        <cfset v_name_Query = #QEmpLookup_Query.first_n_middle# & " " & #QEmpLookup_Query.last_name# >
    </cfif>
    <cfset qresult_Query = 0>
<cfelse>
    <cfset EmpFieldType_Query="Text">
    <cfset v_name_Query = ''>
    <cfset qresult_Query = 1>
</cfif>

<cfform 
	timeout="10000"
	method="post" 
    name="loginForm" 
    format="flash" 
    skin="haloorange"    
    height="950" 
    width="650" 
    preloader="true" 
    Action="EditAccred_Details_Submit.cfm?#CGI.Query_String#" 
    preservedata="yes">

<cfformgroup type="page">
	<cfformitem type="html" height="140">
    <b>Please Enter Accreditation Information Below</b><br />
    <font color="red">* - Field Required</font><br /><br />
    
		<cfoutput query="EditAccreditation">
        <u>Location</u> #Region# / #SubRegion# / #OfficeName#<br />
		<u>Accreditor</u> #Accreditor#<br />
        <u>Posted By</u> #v_name_Query# (#PostedBy#) on #dateformat(posted, "mm/dd/yyyy")#<br />
        <u>Current Editor</u> #v_name_New# (#Form.PostedBy#)<br />
        <cfinput type="hidden" name="postedBy" value="#Form.PostedBy#">
    	</cfoutput>
    </cfformitem>
</cfformgroup>

<cfformgroup type="hdividedbox" >
<!--- Group the box contents, aligned vertically. --->
</cfformgroup>

<cfoutput>

	<cfselect 
    	queryposition="below" 
        label="Type of Accreditation"
        name="AccredType" 
        width="400"
        required="yes"
        message="Please Select Type of Accreditation">
            <option value="#EditAccreditation.AccredType#" selected>#EditAccreditation.AccredType#</option>
			<option></option>
        	<option value="Certification">Certification</option>
         	<option value="Inspection">Inspection</option>
            <option value="Testing">Testing</option>
            <option value="Other">Other (Describe the type of Accreditation in 'Accreditation Detail')</option>
            <option>* Please use 'Accreditation Detail' field to define the accreditation</option>
	</cfselect>

	<cfinput type="text" value="#EditAccreditation.AccredType2#" name="AccredType2" required="yes" label="Accreditation Type (Specific)" width="400" tooltip="Please enter a brief description of the Accreditation Type/Scope" message="Please enter Accreditation Detail"></cfinput>
    
    <cftextarea name="AccredScope" value="#EditAccreditation.AccredScope#" required="yes" label="Scope of Accreditation" width="400" height="100" tooltip="Please describe the Scope of the Accreditation" message="Please enter Scope of Accreditation"></cftextarea>

	<cfselect 
    	queryposition="below" 
        label="Status"
        name="Status" 
        width="400"
        required="yes"
        message="Please select the Status of the Accreditation">
	        <option value="#EditAccreditation.Status#" selected>#EditAccreditation.Status#</option>
			<option></option>
        	<option value="Active">Active</option>
         	<option value="Inactive">Inactive</option>
            <option value="Suspended">Suspended</option>
	</cfselect>

	<cfselect 
    	queryposition="below" 
        label="Local Audit Conducted"
        name="LocalAudit" 
        width="400"
        tooltip="Is a local audit conducted for this accreditation?"
        required="Yes"
        message="Local Audit Yes/No">
            <option value="#EditAccreditation.LocalAudit#" selected>#EditAccreditation.LocalAudit#</option>
			<option></option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect>
    
	<cfselect 
    	queryposition="below" 
        label="Accreditor Audit Frequency"
        name="AuditFrequency" 
        width="400"
        tooltip="How often does an Accreditor audit occur? (in Years)"
        required="Yes"
        message="Audit Frequency">
        	<cfif EditAccreditation.AuditFrequency eq 0>
            	<option value="#EditAccreditation.AuditFrequency#" selected>Unknown</option>
            <cfelse>
            	<option value="#EditAccreditation.AuditFrequency#">#EditAccreditation.AuditFrequency# Year<cfif EditAccreditation.AuditFrequency neq 1>s</cfif></option>
            </cfif>
			<option></option>
			<cfloop index="i" from="1" to="10">
            	<cfoutput>
	            	<option value="#i#">#i# Year<cfif i gt 1>s</cfif></option>
    			</cfoutput>
            </cfloop>
            	<option value="0">Unknown</option>
	</cfselect>

	<cfselect 
    	queryposition="below" 
        label="Additional Requirements"
        name="AdditionalRequirements" 
        width="400"
        tooltip="Does this accreditation have additional requirements beyond 17025, etc?"
        required="yes"
        message="Additional Requirements">
            <option value="#EditAccreditation.AdditionalRequirements#" selected>#EditAccreditation.AdditionalRequirements#</option>
			<option></option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect>
    
	<cftextarea name="AdditionalRequirementsNotes" value="#EditAccreditation.AdditionalRequirementsNotes#" label="Additional Requirements Notes" width="400" height="100"></cftextarea>
    
	<cftextarea name="Notes" value="#EditAccreditation.Notes#" label="Other Notes" width="400" height="100"></cftextarea>

	<cftextarea name="IQANotes" required="yes" message="Change History Notes" label="Add Change History" width="400" height="100"></cftextarea>

</cfoutput>

<cfformgroup type="horizontal">
	<cfinput type="submit" name="Submit" value="Submit"></cfinput>
</cfformgroup>
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->
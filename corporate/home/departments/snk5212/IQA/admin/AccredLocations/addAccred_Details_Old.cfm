<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

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
    	<cfset EmpFieldType="Text">
    	<cfset v_name = ''>
      	<cfset qresult = 1>
    </cfif>
<cfelse>
	<cfset EmpFieldType="Text">
	<cfset v_name = ''>
    <cfset qresult = 1>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Office" Datasource="Corporate">
SELECT ID, OfficeName
FROM IQAtblOffices
WHERE OfficeName = '#URL.OfficeName#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Accreditor" Datasource="Corporate">
SELECT * FROM Accreditors
WHERE Status IS NULL
ORDER BY Accreditor
</cfquery>

<cfform 
	timeout="10000"
	method="post" 
    name="loginForm" 
    format="flash" 
    skin="haloblue" 
    height="800" 
    width="650" 
    preloader="true" 
    Action="AddAccred_Details_Submit.cfm" 
    preservedata="yes">

<cfformgroup type="page">
	<cfformitem type="html" height="100">
    <b>Please Enter Accreditation Information Below</b><br />
    <font color="red">* - Field Required</font><br /><br />
    
		<cfoutput>
        <u>Location</u> #URL.Region# / #URL.SubRegion# / #URL.OfficeName#<br />
            <cfinput type="hidden" name="OfficeID" value="#Office.ID#">
        <u>Posted By</u> #v_name# (#Form.PostedBy#)<br />
        	<cfinput type="#EmpFieldType#" name="PostedBy" value="#v_name#" />
    	</cfoutput>
    </cfformitem>
</cfformgroup>

<cfformgroup type="hdividedbox" >
<!--- Group the box contents, aligned vertically. --->
</cfformgroup>

<cfformgroup type="vertical">
	<cfselect 
    	queryposition="below" 
        label="Accreditor"
        name="AccredID" 
        query="Accreditor" 
        value="ID" 
        display="Accreditor" 
        width="400"
        required="yes"
        message="Please Select Accreditor">
			<option></option>
	</cfselect>

	<cfselect 
    	queryposition="below" 
        label="Type of Accreditation"
        name="AccredType" 
        width="400"
        required="yes"
        message="Please Select Type of Accreditation">
			<option></option>
        	<option value="Certification">Certification</option>
         	<option value="Inspection">Inspection</option>
            <option value="Testing">Testing</option>
            <option value="Other">Other (Describe the type of Accreditation in 'Accreditation Detail')</option>
	</cfselect>

	<cfinput type="text" name="AccredType2" required="yes" label="Accreditation Type (Specific)" width="400" tooltip="Please enter a brief description of the Accreditation Type/Scope" message="Please enter Accreditation Detail"></cfinput>
    
    <cftextarea name="AccredScope" required="yes" label="Scope of Accreditation" width="400" height="100" tooltip="Please describe the Scope of the Accreditation" message="Please enter Scope of Accreditation"></cftextarea>
    
	<cfselect 
    	queryposition="below" 
        label="Status"
        name="Status" 
        width="400"
        required="yes"
        message="Please select the Status of the Accreditation">
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
			<option></option>
			<cfloop index="i" from="1" to="10">
            	<cfoutput>
	            	<option value="#i#">#i# Year<cfif i gt 1>s</cfif></option>
    			</cfoutput>
            </cfloop>
            	<option value="0">Unknown
	</cfselect>

	<cfselect 
    	queryposition="below" 
        label="Additional Accreditor Requirements"
        name="AdditionalRequirements" 
        width="400"
        tooltip="Does this accreditation have additional requirements beyond 17025, etc?"
        required="yes"
        message="Additional Requirements">
			<option></option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect>
    
	<cftextarea name="AdditionalRequirementsNotes" label="Additional Requirements Notes" width="400" height="100"></cftextarea>
    
	<cftextarea name="Notes" label="Notes" width="400" height="100"></cftextarea>

</cfformgroup>

<cfformgroup type="horizontal">
	<cfinput type="submit" name="Submit" value="Submit"></cfinput>
</cfformgroup>
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->
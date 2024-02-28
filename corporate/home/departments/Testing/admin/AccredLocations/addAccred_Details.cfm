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
    height="800" 
    width="650" 
    Action="AddAccred_Details_Submit.cfm" 
    preservedata="yes">

    <b>Enter Accreditation Information Below</b><br />
    <font color="red">* - Field Required</font><br /><br />
  
    <cfoutput>
        <u>Location</u> #URL.Region# / #URL.SubRegion# / #URL.OfficeName#
        <cfinput type="hidden" name="OfficeID" value="#Office.ID#">
        <br /><br />
        
		<u>Posted By</u> #v_name# (#Form.PostedBy#)<br />
        <cfinput type="#EmpFieldType#" name="PostedBy" value="#v_name#" />
        <br /><br />
    </cfoutput>
    
	Accreditor Name <b><font color="red">*</font></b><br />
	<cfselect 
    	queryposition="below" 
        label="Accreditor"
        name="AccredID" 
        query="Accreditor" 
        value="ID" 
        display="Accreditor" 
        width="400"
        required="yes"
        message="Accreditor Name">
	<option>Select Accreditor Name</option>
    <option>--</option>
	</cfselect>
    <br /><br />

	Type of Accreditation <b><font color="red">*</font></b><br>
	<cfselect 
    	queryposition="below" 
        label="Type of Accreditation"
        name="AccredType" 
        width="400"
        required="yes"
        message="Type of Accreditation">
		<option>Select Type of Accreditation</option>
    		<option>--</option>
       		<option value="Certification">Certification</option>
       		<option value="Inspection">Inspection</option>
        	<option value="Testing">Testing</option>
        	<option value="Other">Other (Describe the type of Accreditation in 'Accreditation Detail')</option>
	</cfselect>
    <br /><br />

	Enter a brief description of the Accreditation Type/Scope <b><font color="red">*</font></b><br>
	<cfinput type="text" 
    	name="AccredType2" 
        required="yes" 
        label="Accreditation Type (Specific)" 
        size="80" 
        message="Accreditation Type - Detail">
    </cfinput>
    <br /><br />
    
	Describe the Scope of the Accreditation <b><font color="red">*</font></b><br>
    <cftextarea name="AccredScope" 
    	required="yes" 
        label="Scope of Accreditation" 
    	cols="60" 
    	rows="6"
        message="Scope of Accreditation"></cftextarea>
    <br /><br />
    
	Status of Accreditation <b><font color="red">*</font></b><br />
	<cfselect 
    	queryposition="below" 
        label="Status"
        name="Status" 
        required="yes"
        message="Status of the Accreditation">
			<option>Select the Status of the Accreditation</option>
        	<option>--</option>
            <option value="Active">Active</option>
         	<option value="Inactive">Inactive</option>
            <option value="Suspended">Suspended</option>
	</cfselect>
    <br /><br />

	Is a local audit conducted for this accreditation? <b><font color="red">*</font></b><br>
	<cfselect 
    	queryposition="below" 
        label="Local Audit Conducted"
        name="LocalAudit" 
        required="Yes"
        message="Local Audit Conducted">
			<option>Select Yes/No</option>
            <option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect>
	<br /><br />
    
	How often does an Accreditor audit occur? (in Years) <b><font color="red">*</font></b><br>
    <cfselect 
    	queryposition="below" 
        label="Accreditor Audit Frequency"
        name="AuditFrequency" 
        required="Yes"
        message="Accreditor Audit Frequency">
        	<option>Select frequency of Accreditor Audit (in Years)</option>
			<option>--</option>
			<cfloop index="i" from="1" to="10">
            	<cfoutput>
	            	<option value="#i#">#i# Year<cfif i gt 1>s</cfif></option>
    			</cfoutput>
            </cfloop>
            	<option value="0">Unknown
	</cfselect>
    <br /><br />

	Does this accreditor have additional requirements for this accreditation beyond ISO 17020, 17021, 17025, Guide 65, etc? <b><font color="red">*</font></b><br>
	<cfselect 
    	queryposition="below" 
        label="Additional Accreditor Requirements"
        name="AdditionalRequirements" 
        required="yes"
        message="Accreditor Additional Requirements">
			<option>Select Yes/No</option>
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect>
	<br /><br />
    
    Additional Requirements Notes<br />
	<cftextarea name="AdditionalRequirementsNotes" 
    	label="Additional Requirements Notes" 
    	cols="60" 
    	rows="6"></cftextarea>
    <br /><br />
    
    Notes<br />
	<cftextarea name="Notes" 
    	label="Notes" 
        rows="6"
        cols="60"></cftextarea>
	<br /><Br />

	<cfinput type="submit" name="Submit" value="Submit"></cfinput>
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->
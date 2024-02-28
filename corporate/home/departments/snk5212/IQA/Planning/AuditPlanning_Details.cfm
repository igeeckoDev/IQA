<!--- Start of Page File --->
<cfset subTitle = "Audit Request and Audit Planning Form">
<cfinclude template="shared/StartOfPage.cfm">

<script type="text/javascript"> 
<!--
	_CF_checkloginForm = function(_CF_this){
        //reset on submit
        _CF_error_exists = false;
        _CF_error_messages = new Array();
        _CF_error_fields = new Object();
        _CF_FirstErrorField = null;
 
 		// Question 1
        //form element Focus required check
        if( !_CF_hasValue(_CF_this['Focus'], "TEXTAREA", false ) )
        {
            _CF_onError(_CF_this, "Focus", _CF_this['Focus'].value, "Question 1 - Comments");
            _CF_error_exists = true;
        }
		
 		// Question 2
        //form element AccredRequirements required check
        if( !_CF_hasValue(_CF_this['AccredRequirements'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "AccredRequirements", _CF_this['AccredRequirements'].value, "Question 2 Yes/No");
            _CF_error_exists = true;
        }
		
		if (document.loginForm.AccredRequirements.selectedIndex == 1) 
		{
			if (document.loginForm.AccredRequirementsNotes.value == "") 
			{
				_CF_onError(_CF_this, "AccredRequirementsNotes", _CF_this['AccredRequirementsNotes'].value, "Question 2 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
 
		// Question 3
        //form element TrainingRequirements required check
        if( !_CF_hasValue(_CF_this['TrainingRequirements'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "TrainingRequirements", _CF_this['TrainingRequirements'].value, "Question 3 Yes/No");
            _CF_error_exists = true;
        }

		if (document.loginForm.TrainingRequirements.selectedIndex == 1) 
		{
			if (document.loginForm.TrainingRequirementsNotes.value == "") 
			{
				_CF_onError(_CF_this, "TrainingRequirementsNotes", _CF_this['TrainingRequirementsNotes'].value, "Question 3 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
		
		if (document.loginForm.TrainingRequirements.selectedIndex == 1) 
		{
			if (document.loginForm.TrainingRequirementsTrainer.value == "") 
			{
				_CF_onError(_CF_this, "TrainingRequirementsTrainer", _CF_this['TrainingRequirementsTrainer'].value, "Question 3 selected Yes - Please add the Trainer's Name");
				_CF_error_exists = true;
			}
		}
 
		// Question 4
        //form element DocChangesPending required check
        if( !_CF_hasValue(_CF_this['DocChangesPending'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "DocChangesPending", _CF_this['DocChangesPending'].value, "Question 4 Yes/No");
            _CF_error_exists = true;
        }
		
		if (document.loginForm.DocChangesPending.selectedIndex == 1) 
		{
			if (document.loginForm.DocChangesPendingNotes.value == "") 
			{
				_CF_onError(_CF_this, "DocChangesPendingNotes", _CF_this['DocChangesPendingNotes'].value, "Question 4 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
 
 		// Question 5
        //form element CertificationOfficeChanges required check
        if( !_CF_hasValue(_CF_this['CertificationOfficeChanges'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "CertificationOfficeChanges", _CF_this['CertificationOfficeChanges'].value, "Question 5 Yes/No");
            _CF_error_exists = true;
        }
		
		if (document.loginForm.CertificationOfficeChanges.selectedIndex == 1) 
		{
			if (document.loginForm.CertificationOfficeChangesNote.value == "") 
			{
				_CF_onError(_CF_this, "CertificationOfficeChangesNote", _CF_this['CertificationOfficeChangesNote'].value, "Question 5 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
 
 		// Question 6
        //form element LabLocationChanges required check
        if( !_CF_hasValue(_CF_this['LabLocationChanges'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "LabLocationChanges", _CF_this['LabLocationChanges'].value, "Question 6 Yes/No");
            _CF_error_exists = true;
        }
		
		if (document.loginForm.LabLocationChanges.selectedIndex == 1) 
		{
			if (document.loginForm.LabLocationChangesNotes.value == "") 
			{
				_CF_onError(_CF_this, "LabLocationChangesNotes", _CF_this['LabLocationChangesNotes'].value, "Question 6 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
 
 		// Question 7
        //form element ScopeChangesPending required check
        if( !_CF_hasValue(_CF_this['ScopeChangesPending'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "ScopeChangesPending", _CF_this['ScopeChangesPending'].value, "Question 7 Yes/No");
            _CF_error_exists = true;
        }
		
		if (document.loginForm.ScopeChangesPending.selectedIndex == 1) 
		{
			if (document.loginForm.ScopeChangesPendingNotes.value == "") 
			{
				_CF_onError(_CF_this, "ScopeChangesPendingNotes", _CF_this['ScopeChangesPendingNotes'].value, "Question 7 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
		
 		// Question 8
        //form element EMCChanges required check
        if( !_CF_hasValue(_CF_this['EMCChanges'], "SELECT", false ) )
        {
            _CF_onError(_CF_this, "EMCChanges", _CF_this['EMCChanges'].value, "Question 8 Yes/No");
            _CF_error_exists = true;
        }
		
		if (document.loginForm.EMCChanges.selectedIndex == 1) 
		{
			if (document.loginForm.EMCChangesNotes.value == "") 
			{
				_CF_onError(_CF_this, "EMCChangesNotes", _CF_this['EMCChangesNotes'].value, "Question 8 selected Yes - Please add Comments");
				_CF_error_exists = true;
			}
		}
 
        //display error messages and return success
        if( _CF_error_exists )
        {
            if( _CF_error_messages.length > 0 )
            {
                // show alert() message
                _CF_onErrorAlert(_CF_error_messages);
                // set focus to first form error, if the field supports js focus().
                if( _CF_this[_CF_FirstErrorField].type == "text" )
                { _CF_this[_CF_FirstErrorField].focus(); }
 
            }
            return false;
        }else {
            return true;
        }
    }
//-->
</script>

<cfif isDefined("Form.Submit")>

<CFQUERY Name="Rows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID FROM AuditPlanning2011
</CFQUERY>

<cfif Rows.RecordCount gte 1>
	<CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID 
    FROM AuditPlanning2011
    </CFQUERY>
<cfelse>
	<cfset NewID.NewID = 1>
</cfif>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY Name="Rows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO AuditPlanning2011(ID, pID, Type, Posted, PostedBy)
VALUES(#NewID.NewID#, #Form.pID#, '#Form.Type#', #postDate#, '#Form.PostedInfo#')
</CFQUERY>

<CFQUERY Name="Rows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE AuditPlanning2011
SET

Focus='#Form.Focus#',
AccredRequirements='#Form.AccredRequirements#',
AccredRequirementsNotes='#Form.AccredRequirementsNotes#',
TrainingRequirements='#Form.TrainingRequirements#',
TrainingRequirementsNotes='#Form.TrainingRequirementsNotes#',
TrainingRequirementsTrainer='#Form.TrainingRequirementsTrainer#',
DocChangesPending='#Form.DocChangesPending#',
DocChangesPendingNotes='#Form.DocChangesPendingNotes#',
ScopeChangesPending='#Form.ScopeChangesPending#',
ScopeChangesPendingNotes='#Form.ScopeChangesPendingNotes#',
CertificationOfficeChanges='#Form.CertificationOfficeChanges#',
CertificationOfficeChangesNote='#Form.CertificationOfficeChangesNote#',
LabLocationChanges='#Form.LabLocationChanges#',
LabLocationChangesNotes='#Form.LabLocationChangesNotes#',
EMCChanges='#Form.EMCChanges#',
EMCChangesNotes='#Form.EMCChangesNotes#',
Posted=#postDate#

WHERE
ID = #NewID.NewID#
</CFQUERY>

<cflocation url="AuditPlanning_Details_Review.cfm?ID=#NewID.NewID#" addtoken="No">

<cfelse>

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

<cfif URL.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #URL.ID#
    </cfquery>
<cfelseif URL.Type eq "Process">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Function as pName
    FROM GlobalFunctions
    WHERE ID = #URL.ID#
    </cfquery>
</cfif>

<cfform 
	timeout="10000"
	method="post" 
    name="loginForm" 
    format="html" 
    width="650" 
    preservedata="yes"  
    Action="AuditPlanning_Details.cfm?PostedBy=#Form.postedBy#&Type=#URL.Type#&ID=#URL.ID#">

<cfoutput>
    <b>Please Enter #URL.Type# Information Below</b><br /><br>
    
    <!--- URL.Type = Program or Process --->
    <u>#URL.Type# Name</u> - #qData.pName# <!--- Program or Process name from query above ---><br />
        <cfinput type="hidden" name="pID" value="#URL.ID#">
        <cfinput type="hidden" name="Type" value="#URL.Type#">

    <cfif isDefined("Form.PostedBy") AND Form.PostedBy NEQ "00000">
    	<u>Posted By</u> #v_name# (#Form.PostedBy#)
	</cfif>
    
	<cfif isDefined("Form.PostedBy") AND Form.PostedBy EQ "00000">
       	<br />Please Input Your Name<br />
	    <cfinput size="80" type="#EmpFieldType#" name="PostedInfo" value="#v_name#" />
	</cfif>
        
	<cfif isDefined("Form.PostedBy") AND Form.PostedBy NEQ "00000">
       	<cfinput type="hidden" name="PostedInfo" value="#v_name# (#Form.PostedBy#)" />
    </cfif>
</cfoutput><br><br>

1. Are there any specific items you want us to concentrate on in 2011?<br>
	<cftextarea name="Focus" cols="60" rows="6"></cftextarea><br><br>

2. Are there any new/pending accreditor requirements affecting your <cfoutput>#URL.Type#</cfoutput>?<br>
	<cfselect 
    	queryposition="below" 
        name="AccredRequirements">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="AccredRequirementsNotes" cols="60" rows="6"></cftextarea><br><br>

3. IQA auditors are trained to ISO 17025, Guide 65, ISO 17021, ISO 17020, 510K requirements and ISO 9001. Are there any program specific training requirements that the auditor needs to complete to support your <cfoutput>#URL.Type#</cfoutput>? If so, who can provide the training?<br>

	<cfselect 
    	queryposition="below" 
        name="TrainingRequirements">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect><br><br>
	
    If Yes, please list the Trainer's name:<br>
	<cftextarea name="TrainingRequirementsTrainer" cols="60" rows="1"></cftextarea><br><br>

	If Yes, please describe the training requirements:<br>
	<cftextarea name="TrainingRequirementsNotes" cols="60" rows="6"></cftextarea><br><br>

4. Are any major <cfoutput>#URL.Type#</cfoutput> documentation changes pending/planned?<br>
	<cfselect 
    	queryposition="below" 
        name="DocChangesPending">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="DocChangesPendingNotes" cols="60" rows="6"></cftextarea><br><Br>

5. Are any Certification Office changes pending/planned for 2011?<br>
	<cfselect 
    	queryposition="below" 
        name="CertificationOfficeChanges">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
    </cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="CertificationOfficeChangesNote" cols="60" rows="6"></cftextarea><br><br>

6. Are any Laboratory changes pending/planned for 2011?<br>
	<cfselect 
    	queryposition="below" 
        name="LabLocationChanges">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:
	<cftextarea name="LabLocationChangesNotes" cols="60" rows="6"></cftextarea><br><br>

7. Are there any scope of accreditation or scope of operations changes pending/planned?<br>
	<cfselect 
    	queryposition="below" 
        name="ScopeChangesPending">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="ScopeChangesPendingNotes" cols="60" rows="6"></cftextarea><br><Br>
    
8. Are there any EMC related changes pending/planned?<br>
	<cfselect 
    	queryposition="below" 
        name="EMCChanges">
			<option>--</option>
        	<option value="Yes">Yes</option>
         	<option value="No">No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="EMCChangesNotes" cols="60" rows="6"></cftextarea><br><Br>

	<INPUT TYPE="Submit" value="Submit" name="Submit" > 

</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->
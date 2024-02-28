<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<script type="text/javascript"> 
<!--
	_CF_checkloginForm = function(_CF_this){
        //reset on submit
        _CF_error_exists = false;
        _CF_error_messages = new Array();
        _CF_error_fields = new Object();
        _CF_FirstErrorField = null;
 
  		// Program / Process Name
        //form element New_PName required check
        if( !_CF_hasValue(_CF_this['New_PName'], "TEXTAREA", false ) )
        {
            _CF_onError(_CF_this, "New_PName", _CF_this['New_PName'].value, "Program / Process Name");
            _CF_error_exists = true;
        }
		
 		// Type
        //form element Type required check
        if( !_CF_hasValue(_CF_this['Type'], "TEXTAREA", false ) )
        {
            _CF_onError(_CF_this, "Type", _CF_this['Type'].value, "Type - Program or Process");
            _CF_error_exists = true;
        }
		
 		// Owner / Manager
        //form element New_OwnerManager required check
        if( !_CF_hasValue(_CF_this['New_OwnerManager'], "TEXTAREA", false ) )
        {
            _CF_onError(_CF_this, "New_OwnerManager", _CF_this['New_OwnerManager'].value, "Program / Process Owner and Manager");
            _CF_error_exists = true;
        }
 
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

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY Name="Rows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE AuditPlanning2011
SET

New_PName='#Form.New_PName#',
Type='#Form.Type#',
New_OwnerManager='#Form.New_OwnerManager#',
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
ID = #URL.ID#
</CFQUERY>

<cflocation url="AuditPlanning_New_Details_Review.cfm?ID=#ID#" addtoken="No">

<cfelse>

<CFQUERY Name="qData" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM AuditPlanning2011
WHERE ID = #URL.ID#
</CFQUERY>

<cfoutput query="qData">
<cfform 
	timeout="10000"
	method="post" 
    name="loginForm" 
    format="html" 
    width="650" 
    preservedata="yes"
    Action="AuditPlanning_New_Details_Edit.cfm?ID=#URL.ID#">

<b>Please Enter #Type# Information Below</b><br /><br>

<cfif New_PName EQ "UL Verification Services (VS)">
Program Name: 
	<b>Verification Services (VS)</b>
    <cfinput type="hidden" name="New_PName" value="UL Verification Services (VS)">
    <cfinput type="hidden" name="Type" value="Program">
<cfelseif  New_PNAME EQ "UL Environment (ULE)">
Program Name: 
	<b>UL Environment (ULE)</b>
    <cfinput type="hidden" name="New_PName" value="UL Environment (ULE)">
    <cfinput type="hidden" name="Type" value="Program">
<cfelse>
Enter the Program / Process Name:<br />
   	<cftextarea name="New_PName" cols="60" rows="1" value="#New_PName#"></cftextarea>
</cfif><br><br>

<cfif New_PName NEQ "UL Verification Services (VS)" AND New_PNAME NEQ "UL Environment (ULE)">
<!--- Type = Program or Process --->
Select the Type: (Program or Process)<br />
<cfselect 
    queryposition="below" 
    name="Type">
        <option>--</option>
        <option value="Program" <cfif Type eq "Program">selected</cfif>>Program</option>
        <option value="Process" <cfif Type eq "Process">selected</cfif>>Process</option>
</cfselect><br><br>
</cfif>

<u>Posted By</u> - #PostedBy#<br><br />

List the Program / Process Owner and Manager, if known.<br />
<cftextarea name="New_OwnerManager" cols="60" rows="3" value="#New_OwnerManager#"></cftextarea><br><br>

1. Are there any specific items you want us to concentrate on in 2011?<br>
	<cftextarea name="Focus" cols="60" rows="6" value="#Focus#"></cftextarea><br><br>

2. Are there any new/pending accreditor requirements affecting your #Type#?<br>
	<cfselect 
    	queryposition="below" 
        name="AccredRequirements">
			<option>--</option>
        	<option value="Yes" <cfif AccredRequirements eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif AccredRequirements eq "No">selected</cfif>>No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="AccredRequirementsNotes" cols="60" rows="6" value="#AccredRequirementsNotes#"></cftextarea><br><br>

3. IQA auditors are trained to ISO 17025, Guide 65, ISO 17021, ISO 17020, 510K requirements and ISO 9001. Are there any program specific training requirements that the auditor needs to complete to support your #Type#? If so, who can provide the training?<br>

	<cfselect 
    	queryposition="below" 
        name="TrainingRequirements">
			<option>--</option>
        	<option value="Yes" <cfif TrainingRequirements eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif TrainingRequirements eq "No">selected</cfif>>No</option>
	</cfselect><br><br>
	
    If Yes, please list the Trainer's name:<br>
	<cftextarea name="TrainingRequirementsTrainer" cols="60" rows="1" value="#TrainingRequirementsTrainer#"></cftextarea><br><br>

	If Yes, please describe the training requirements:<br>
	<cftextarea name="TrainingRequirementsNotes" cols="60" rows="6" value="#TrainingRequirementsNotes#"></cftextarea><br><br>

4. Are any major #Type# documentation changes pending/planned?<br>
	<cfselect 
    	queryposition="below" 
        name="DocChangesPending">
			<option>--</option>
        	<option value="Yes" <cfif DocChangesPending eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif DocChangesPending eq "No">selected</cfif>>No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="DocChangesPendingNotes" cols="60" rows="6" value="#DocChangesPendingNotes#"></cftextarea><br><Br>

5. Are any Certification Office changes pending/planned for 2011?<br>
	<cfselect 
    	queryposition="below" 
        name="CertificationOfficeChanges">
			<option>--</option>
        	<option value="Yes" <cfif CertificationOfficeChanges eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif CertificationOfficeChanges eq "No">selected</cfif>>No</option>
    </cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="CertificationOfficeChangesNote" cols="60" rows="6" value="#CertificationOfficeChangesNote#"></cftextarea><br><br>

6. Are any Laboratory changes pending/planned for 2011?<br>
	<cfselect 
    	queryposition="below" 
        name="LabLocationChanges">
			<option>--</option>
        	<option value="Yes" <cfif LabLocationChanges eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif LabLocationChanges eq "No">selected</cfif>>No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:
	<cftextarea name="LabLocationChangesNotes" cols="60" rows="6" value="#LabLocationChangesNotes#"></cftextarea><br><br>

7. Are there any scope of accreditation or scope of operations changes pending/planned?<br>
	<cfselect 
    	queryposition="below" 
        name="ScopeChangesPending">
			<option>--</option>
        	<option value="Yes" <cfif ScopeChangesPending eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif ScopeChangesPending eq "No">selected</cfif>>No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="ScopeChangesPendingNotes" cols="60" rows="6" value="#ScopeChangesPendingNotes#"></cftextarea><br><Br>
    
8. Are there any EMC related changes pending/planned?<br>
	<cfselect 
    	queryposition="below" 
        name="EMCChanges">
			<option>--</option>
        	<option value="Yes" <cfif EMCChanges eq "Yes">selected</cfif>>Yes</option>
         	<option value="No" <cfif EMCChanges eq "No">selected</cfif>>No</option>
	</cfselect><br><br>

	If Yes, please describe the changes:<br>
	<cftextarea name="EMCChangesNotes" cols="60" rows="6" value="#EMCChangesNotes#"></cftextarea><br><Br>

	<INPUT TYPE="Submit" value="Submit" name="Submit"> 

</cfform>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->
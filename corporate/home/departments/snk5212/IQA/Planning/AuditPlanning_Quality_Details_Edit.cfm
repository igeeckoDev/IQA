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
 
  		// NameAndType
        //form element Type required check
        if( !_CF_hasValue(_CF_this['NameAndType'], "TEXTAREA", false ) )
        {
            _CF_onError(_CF_this, "NameAndType", _CF_this['NameAndType'].value, "Select a Program / Process / Site");
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

<cfif Form.NameAndType NEQ "No Change">
	<cfset Type = ListFirst(Form.NameAndType, ",")>
	<Cfset pID = ListLast(Form.NameAndType, ",")>
</cfif>

<CFQUERY Name="Rows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE AuditPlanning2011
SET

<cfif Form.NameAndType NEQ "No Change">
Type='#Type#',
pID=#pID#,
</cfif>
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

<cflocation url="AuditPlanning_Details_Review.cfm?ID=#ID#" addtoken="No">

<cfelse>

<CFQUERY Name="qData" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM AuditPlanning2011
WHERE ID = #URL.ID#
</CFQUERY>

<cfif qData.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qPName" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #qData.pID#
    </cfquery>
<cfelseif qData.Type eq "Process">
    <CFQUERY BLOCKFACTOR="100" name="qPName" Datasource="Corporate">
    SELECT ID, Function as pName
    FROM GlobalFunctions
    WHERE ID = #qData.pID#
    </cfquery>
<cfelseif qData.Type eq "Site">
    <CFQUERY BLOCKFACTOR="100" name="qPName" Datasource="Corporate">
    SELECT OfficeName as pName 
    FROM IQAtblOffices
    WHERE ID = #qData.pID#
    </CFQUERY>
</cfif>

<cfform 
	timeout="10000"
	method="post" 
    name="loginForm" 
    format="html" 
    width="650" 
    preservedata="yes"
    Action="AuditPlanning_Quality_Details_Edit.cfm?ID=#URL.ID#">

<cfoutput query="qData">
    <b>Please Enter #Type# Information Below</b><br /><br>
    <!--- Type = Program or Process --->
    <u>#Type# Name</u> - <b>#qPName.pName#</b> <!--- Program or Process name from query above ---><br />
    <u>Posted By</u> - #PostedBy#<br><br>
</cfoutput>

<cfquery Datasource="Corporate" name="qDropDownProgram"> 
SELECT DISTINCT ProgDev.Program, ProgDev.ID
FROM AuditSchedule, ProgDev
WHERE AuditSchedule.Area = Program
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.Year_ = 2010
ORDER BY ProgDev.Program
</cfquery>

<CFQUERY Name="qDropDownProcess" datasource="Corporate">
SELECT Function, ID
FROM GlobalFunctions
WHERE Status IS NULL
ORDER BY Function
</CFQUERY>

<CFQUERY Name="qDropDownSite" datasource="Corporate">
SELECT ID, OfficeName, Region, SubRegion
From IQAtblOffices
WHERE Exist = 'Yes' 
AND Finance = 'Yes'
ORDER By Region, SubRegion, OfficeName
</CFQUERY>

<!--- Drop Down Program / Process / Site --->
Select a Program, Process or Site:<br />
<cfselect 
    name="NameAndType">
    	<cfoutput>
    		<option value="No Change" selected>#qPName.pName#</option>
        </cfoutput>
        <option>--</option>    
		<option>Programs</option>
        <option>--</option>
	<cfoutput query="qDropDownProgram">
    	<option value="Program, #ID#">#Program#
    </cfoutput>
    	<option>--</option>
        <option>Processes</option>
        <option>--</option>
	<cfoutput query="qDropDownProcess">
    	<option value="Process, #ID#">#Function#
    </cfoutput>
    	<option>--</option>
        <option>Sites</option>
        <option>--</option>
	<cfoutput query="qDropDownSite">
    	<option value="Site, #ID#">#Region# / #SubRegion# / #OfficeName#
    </cfoutput>
</cfselect><br><br>

<cfoutput query="qData">
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
</cfoutput>

	<INPUT TYPE="Submit" value="Submit" name="Submit"> 

</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->
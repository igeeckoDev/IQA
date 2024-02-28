<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Questions">
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

<cfif URL.UserID EQ "Quality">
	<cfset SurveyType.SurveyType = "Quality">
    
	<!--- show programs, processes, offices --->
    <cfquery name="qDropDownProgram" Datasource="Corporate"> 
    SELECT DISTINCT ProgDev.Program as Program, ProgDev.ID as ID
    FROM AuditSchedule, ProgDev
    WHERE AuditSchedule.Area = Program
    AND AuditSchedule.AuditedBy = 'IQA'
    AND AuditSchedule.Status IS NULL
    AND AuditSchedule.Year_ = 2012
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
<cfelseif URL.UserID EQ "ProgramNew">
	<cfset SurveyType.SurveyType = "ProgramNew">
<cfelseif URL.UserID EQ "Quality2">
	<cfset SurveyType.SurveyType = "Quality">
<cfelse>
    <CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    FROM AuditPlanning2013_Users
    WHERE ID = #URL.UserID#
    </CFQUERY>
</cfif>

<cfif SurveyType.SurveyType eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #SurveyType.pID#
    </cfquery>
<cfelseif SurveyType.SurveyType eq "Process">
	<cfif SurveyType.pID eq 0>
		<CFQUERY BLOCKFACTOR="100" name="qData" Datasource="UL06046">
        SELECT Type as pName
        FROM AuditPlanning2013_Users
        WHERE ID = #URL.UserID#
        </cfquery>
	<cfelse>
        <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
        SELECT ID, Function as pName
        FROM GlobalFunctions
        WHERE ID = #SurveyType.pID#
        </cfquery>
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT 
	* 
FROM 
	AuditPlanning2013_Questions
WHERE 
    QuestionType = '#SurveyType.SurveyType#'
ORDER BY 
	QuestionType, ID
</CFQUERY>

<!---
<a href="2013.cfm?SurveyType=ProgramNew">New Programs, Services, and Offerings</a><br>
<a href="2013.cfm?SurveyType=Program">Programs, Services, and Offerings</a><br>
<a href="2013.cfm?SurveyType=Process">Process</a><br>
<a href="2013.cfm?SurveyType=Quality">Local Quality Managers</a><br>
<a href="2013.cfm?SurveyType=Lab">Laboratory</a><br>
<a href="2013.cfm?SurveyType=Operations">Operations</a><br>
<a href="2013.cfm?SurveyType=Other Sites">Sites Outside of Public Safety</a><br><Br>

Currently Viewing: <cfoutput><b>#URL.SurveyType#</b></cfoutput><br><br>

<hr><br><br>
--->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="2013_Submit.cfm?#CGI.QUERY_STRING#" enctype="multipart/form-data">

<cfoutput>
	<cfif isDefined("URL.Request")>
    	<cfif URL.Request eq "Yes">
        	<input type="hidden" name="Request" value="Yes">
        </cfif>
    </cfif>
   
    <b>Please Enter <cfif SurveyType.SurveyType eq "Lab">Laboratory Operations
					<cfelseif SurveyType.SurveyType eq "Other Sites">Location
					<cfelseif SurveyType.SurveyType eq "ProgramNew">New Process, Program, Service, or Offering
					<cfelse>#SurveyType.SurveyType#</cfif> Information Below</b><br /><br>
    
    <cfif SurveyType.SurveyType eq "Program" OR SurveyType.SurveyType eq "Process">
		<!--- SurveyType.SurveyType = Program or Process --->
        <!--- Program or Process name from query above --->
        <u>#SurveyType.SurveyType# Name</u> - #qData.pName#
        <cfif SurveyType.SurveyType eq "Program">&nbsp;
        [<a href="../_prog_Detail.cfm?progID=#qData.ID#" target="_blank">Program Details</a>]<br /><br>
        
        To add information on a new Process, Program, Service or Offering, please use the [<a href="2013.cfm?SurveyType=ProgramNew" target="_blank">New Program Survey</a>]
        </cfif>
        <br><br>
        
        <cfinput type="hidden" name="pID" value="#SurveyType.pID#">
        <cfinput type="hidden" name="Type" value="#SurveyType.SurveyType#">
    <cfelseif SurveyType.SurveyType eq "ProgramNew">
    	<cfinput type="hidden" name="pID" value="0"> 
        <cfinput type="hidden" name="Type" value="#SurveyType.SurveyType#">
        
        <!---
        If your Process or Program is listed in one of the links below, please follow the link to the appropriate survey. Otherwise please use this survey to provide information about a new UL Process, Program, Service, or Offering.<br /><br />
        
        :: <a href="Distribution_2013.cfm?Type=Program" target="_blank">Programs Audited by IQA</a> [<a href="getEmpNo.cfm?UserID=Program">Go to Program Survey</a>]<br>
        :: <a href="Distribution_2013.cfm?Type=Process" target="_blank">Processes Audited by IQA</a> [<a href="getEmpNo.cfm?UserID=Process">Go to Process Survey</a>]<br /><br />
         --->
         
        Please enter new Process, Program, Service, or Offering Name:<br />
        <cfinput type="text" name="e_Request" data-bvalidator="required" data-bvalidator-msg="Program, Service, or Offering Name" size="75"><br /><br />
	<cfelse>
    	<cfif SurveyType.SurveyType neq "Operations" AND SurveyType.SurveyType neq "Lab" AND SurveyType.SurveyType neq "Quality" AND SurveyType.SurveyType neq "ProgramNew">
    	<u>#SurveyType.SurveyType# Name</u> - #SurveyType.Type#<br><br>
        </cfif>
        
		<cfinput type="hidden" name="pID" value="0">
        <cfinput type="hidden" name="Type" value="#SurveyType.SurveyType#">
	</cfif>

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

<cfif SurveyType.SurveyType eq "Quality" AND URL.UserID NEQ "Quality2">
	<!--- Drop Down Program / Process / Site --->
    Select a Program, Process or Site:<br />
    <cfselect 
        name="e_NameAndType"
        data-bvalidator="required" 
   		data-bvalidator-msg="Program, Process or Site">
            <option>--</option>
            <option>Programs</option>
            <option>--</option>
        <cfoutput query="qDropDownProgram">
            <option value="Program,#ID#">#Program#
        </cfoutput>
            <option>--</option>
            <option>Processes</option>
            <option>--</option>
        <cfoutput query="qDropDownProcess">
            <option value="Process,#ID#">#Function#
        </cfoutput>
            <option>--</option>
            <option>Sites</option>
            <option>--</option>
        <cfoutput query="qDropDownSite">
            <option value="Site,#ID#">#Region# / #SubRegion# / #OfficeName#
        </cfoutput>
    </cfselect><br><br>
<cfelseif SurveyType.SurveyType eq "Quality" AND URL.UserID eq "Quality2">
	Identify the Survey Area (Accreditor, Program, Business Unit, etc - 40 characters max)<br />
    <cfinput type="text" name="e_SurveyArea" size="80" maxlength="40" data-bvalidator="required" data-bvalidator-msg="Survey Area" /><br><br>

    Detailed description of Survey Area: (optional):<br />
    <cftextarea 
        name="SurveyArea_Description" 
        cols="60" 
        rows="6"></cftextarea><br /><br />
</cfif>

<cfset i = 1>
<cfoutput query="Questions">

<!---
[ID = #ID#]<br />
#QuestionType#<br />
--->

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
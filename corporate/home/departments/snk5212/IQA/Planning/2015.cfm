<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2015 Audit Planning - Questions">
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
    AND AuditSchedule.Year_ = 2015
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
<cfelseif URL.UserID EQ "Quality2">
	<cfset SurveyType.SurveyType = "Quality">
<cfelse>
    <CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT *
    FROM AuditPlanning2015_Users
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
        FROM AuditPlanning2015_Users
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
	AuditPlanning2015_Questions
ORDER BY
	ID
</CFQUERY>

<!---
<a href="2014.cfm?SurveyType=New">New Programs, Services, and Offerings</a><br>
<a href="2014.cfm?SurveyType=Program">Programs, Services, and Offerings</a><br>
<a href="2014.cfm?SurveyType=Process">Process</a><br>
<a href="2014.cfm?SurveyType=Quality">Local Quality Managers</a><br>
<a href="2014.cfm?SurveyType=Laboratory">Laboratory</a><br>
<a href="2014.cfm?SurveyType=Operations">Operations</a><br>
<a href="2014.cfm?SurveyType=Other Sites">Sites Outside of Public Safety</a><br><Br>

Currently Viewing: <cfoutput><b>#URL.SurveyType#</b></cfoutput><br><br>

<hr><br><br>
--->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="2015_Submit.cfm?#CGI.QUERY_STRING#" enctype="multipart/form-data">

<cfoutput>
	<cfif isDefined("URL.Request")>
    	<cfif URL.Request eq "Yes">
        	<input type="hidden" name="Request" value="Yes">
        </cfif>
    </cfif>

    <b>Please Enter <cfif SurveyType.SurveyType eq "Laboratory">Laboratory Operations
    				<cfelseif SurveyType.SurveyType eq "Quality">Survey Area
					<cfelse>#SurveyType.SurveyType#</cfif> Information Below</b><br /><br>

    <cfif SurveyType.SurveyType eq "Program" OR SurveyType.SurveyType eq "Process">
		<!--- SurveyType.SurveyType = Program or Process --->
        <!--- Program or Process name from query above --->
        <u>#SurveyType.SurveyType# Name</u> - #qData.pName#
        <cfif SurveyType.SurveyType eq "Program">&nbsp;
        [<a href="../_prog_Detail.cfm?progID=#qData.ID#" target="_blank">Program Details</a>]

        <!---
		To add information on a new Process, Program, Service or Offering, please use the [<a href="getEmpNo.cfm?UserID=Quality2" target="_blank">Survey</a>]
        --->
		</cfif>
        <br><br>

        <cfinput type="hidden" name="pID" value="#SurveyType.pID#">
        <cfinput type="hidden" name="Type" value="#SurveyType.SurveyType#">
    <!---
    <cfelseif SurveyType.SurveyType eq "New">
    	<cfinput type="hidden" name="pID" value="0">
        <cfinput type="hidden" name="Type" value="#SurveyType.SurveyType#">

        If your Process or Program is listed in one of the links below, please follow the link to the appropriate survey. Otherwise please use this survey to provide information about a new UL Process, Program, Service, or Offering.<br /><br />

        :: <a href="Distribution_2014.cfm?Type=Program" target="_blank">Programs Audited by IQA</a> [<a href="getEmpNo.cfm?UserID=Program">Go to Program Survey</a>]<br>
        :: <a href="Distribution_2014.cfm?Type=Process" target="_blank">Processes Audited by IQA</a> [<a href="getEmpNo.cfm?UserID=Process">Go to Process Survey</a>]<br /><br />

        Please enter new Process, Program, Service, or Offering Name:<br />
        <cfinput type="text" name="e_Request" data-bvalidator="required" data-bvalidator-msg="Program, Service, or Offering Name" size="75"><br /><br />
    --->
	<cfelse>
    	<cfif SurveyType.SurveyType neq "Operations" AND SurveyType.SurveyType neq "Laboratory" AND SurveyType.SurveyType neq "Quality" AND SurveyType.SurveyType neq "New">
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
    <b>Select a Program, Process or Site</b>:<br />
    <cfselect
        name="NameAndType"
        data-bvalidator="required"
   		data-bvalidator-msg="Program, Process or Site">
            <option value="">--</option>
            <option value="">Programs</option>
            <option value="">--</option>
        <cfoutput query="qDropDownProgram">
            <option value="Program,#ID#">#Program#
        </cfoutput>
            <option value="">--</option>
            <option value="">Processes</option>
            <option value="">--</option>
        <cfoutput query="qDropDownProcess">
            <option value="Process,#ID#">#Function#
        </cfoutput>
            <option value="">--</option>
            <option value="">Sites</option>
            <option value="">--</option>
        <cfoutput query="qDropDownSite">
            <option value="Site,#ID#">#Region# / #SubRegion# / #OfficeName#
        </cfoutput>
    </cfselect><br><br>
<cfelseif SurveyType.SurveyType eq "Quality" AND URL.UserID eq "Quality2">
	Identify the Survey Area<br>
    (New Process, Program, Service, Offering, Accreditor, Program, Business Unit, etc - 40 characters max)<br />
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

<cfif i eq 13>
	<b>New Audit Areas</b><br><br>
<cfelseif i eq 12>
	<b>Existing Audit Areas</b><br><br>
</cfif>


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
        <option value="NA">Not Applicable</option>
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
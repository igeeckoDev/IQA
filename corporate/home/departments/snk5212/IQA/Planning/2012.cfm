<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Questions">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

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
	<cfset SurveyType.Type = "Quality">

    <cfquery name="qDropDownProgram" Datasource="Corporate"> 
    SELECT DISTINCT ProgDev.Program, ProgDev.ID
    FROM AuditSchedule, ProgDev
    WHERE AuditSchedule.Area = Program
    AND AuditSchedule.AuditedBy = 'IQA'
    AND AuditSchedule.Status IS NULL
    AND AuditSchedule.Year_ = 2011
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
<cfelseif URL.UserID EQ "New">
	<cfset SurveyType.Type = "#URL.UserID#">
<cfelse>
    <CFQUERY BLOCKFACTOR="100" name="SurveyType" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    FROM AuditPlanning_Users
    WHERE ID = #URL.UserID#
    </CFQUERY>
</cfif>

<cfif SurveyType.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Program as pName
    FROM ProgDev
    WHERE ID = #SurveyType.pID#
    </cfquery>
<cfelseif SurveyType.Type eq "Process">
    <CFQUERY BLOCKFACTOR="100" name="qData" Datasource="Corporate">
    SELECT ID, Function as pName
    FROM GlobalFunctions
    WHERE ID = #SurveyType.pID#
    </cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	* 
FROM 
	AuditPlanning_Questions
    <cfif SurveyType.Type NEQ "New">
		<cfif SurveyType.Type eq "ULE" OR SurveyType.Type eq "VS" OR SurveyType.Type eq "WiSE">
            WHERE 
            QuestionType <> 'Quality' AND QuestionType <> 'Program'
        <cfelse>
            WHERE 
            QuestionType LIKE '%#SurveyType.Type#%' 
            OR QuestionType = 'All'
        </cfif>
	</cfif>
ORDER BY 
	ID
</CFQUERY>

<cfform 
	method="post" 
    name="Audit"  
    width="650" 
    Action="2012_Submit.cfm?#cgi.QUERY_STRING#">

<cfoutput>
	<cfif isDefined("URL.Request")>
    	<cfif URL.Request eq "Yes">
        	<input type="hidden" name="Request" value="Yes">
        </cfif>
    </cfif>
   
    <b>Please Enter <cfif SurveyType.Type eq "Lab">Laboratory Operations<cfelse>#SurveyType.Type#</cfif> Information Below</b>
    <br /><br>
    
    <cfif SurveyType.Type eq "Program" OR SurveyType.Type eq "Process">
		<!--- SurveyType.Type = Program or Process --->
        <!--- Program or Process name from query above --->
        <u>#SurveyType.Type# Name</u> - #qData.pName#<br />
        <cfinput type="hidden" name="pID" value="#SurveyType.pID#">
        <cfinput type="hidden" name="Type" value="#SurveyType.Type#">
	<cfelseif SurveyType.Type eq "ULE" OR SurveyType.Type eq "VS" OR SurveyType.Type eq "WiSE">
		<cfinput type="hidden" name="pID" value="0">
        <cfinput type="hidden" name="Type" value="#SurveyType.Type#">
    <cfelseif SurveyType.Type eq "New">
    	<cfinput type="hidden" name="pID" value="0"> 
        <cfinput type="hidden" name="Type" value="#SurveyType.Type#">
        
        Please enter new Site, Laboratory, Program or Process Name:<br />
        <cfinput type="text" name="e_Request" displayname="Site, Laboratory, Program or Process Name" size="75"><br /><br />
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

<cfif SurveyType.Type eq "Quality">
	<!--- Drop Down Program / Process / Site --->
    Select a Program, Process or Site:<br />
    <cfselect 
        name="e_NameAndType"
        displayname="Program, Process or Site">
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
</cfif>

<cfset i = 1>
<cfoutput query="Questions">
<b>#i#</b> #Question#<br /><br />
<!---[Type: #QuestionType#, Question Number: #ID#]<br /><br />--->

Yes / No:<br />
<cfselect 
    queryposition="below" 
    name="e_#ID#_Answer"
    displayname="Question #i# Yes/No">
        <option>--</option>
        <option value="Yes">Yes</option>
        <option value="No">No</option>
</cfselect>
<br /><br />

<cfif len(ExtraField_Text)>
#ExtraField_Text#:<Br />
<cfinput name="e_#ID#_ExtraField_Text" 
	type="text" 
    size="50" 
    maxlength="50"
    displayname="Question #i# #ExtraField_Text#"
    Value="None Listed">
<Br /><br />
</cfif>

Notes:<br />
<cftextarea 
	name="e_#ID#_Notes" 
    cols="60" 
    rows="6"
    displayname="Question #i# Notes">No Comments Added</cftextarea>
<br /><br />
<hr />
<br />

<cfset i = i + 1>
</cfoutput>

<INPUT TYPE="button" value="Submit" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->
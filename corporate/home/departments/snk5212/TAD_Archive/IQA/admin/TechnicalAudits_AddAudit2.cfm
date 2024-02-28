<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Add Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language=javascript>
	window.name = "doUpLoadProc";
</script>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=450,left = 200,top = 200');");
}
// End -->
</script>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.YeaR#
</cfquery>

<div align="Left" class="blog-time">
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.2 Add an audit<br /><br />
</cfoutput>
</div>

<b>Audit Details</b><br />
<cfoutput query="Audit">
<u>Audit Number</u>: #URL.Year#-#URL.ID#-#AuditedBy#<br />
<u>Industry</u>: #Industry#<br />
<u>Office Name</u>: #OfficeName#<br />
<cfif len(SNAP)>SNAP Site Status: [#SNAP#]</cfif><Br />
<u>Regional Operations Manager</u>: #ROM#<br />
<cfif len(TAM)>
<u>Technical Audit Manager/Deputy</u>: #TAM#<br />
</cfif>
<u>Audit Type</u>: #AuditType2# <cfif AuditType2 eq "In-Process">(Phase: #AuditPhase#)</cfif><br />
<u>E2E Audit?</u>: <cfif NOT len(E2E)>Not Selected<cfelse>#E2E#</cfif><br />
<cfif AuditType2 eq "Full">
	<u>Quarter Scheduled</u>: Quarter #Month#
<cfelseif AuditType2 eq "In-Process">
	<u>Month Scheduled</u>: #MonthAsString(Month)#
</cfif><br />
<u>Audit Due Date</u>: <cfif len(AuditDueDate)>#dateformat(AuditDueDate, "mm/dd/yyyy")#<cfelse>None Specified</cfif><br /><br />

<cfif AuditType2 eq "Full">
    <u>Project Evaluator</u>: 
        <cfif len(ProjectHandler)>
            #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept# / #ProjectHandlerEmail# <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandler&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        <cfelse>
            <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandler&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        </cfif><br />
    
    <u>Project Evaluator's Manager</u>: 
        <cfif len(ProjectHandlerManager)>
            #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept# / #ProjectHandlerManagerEmail# <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandlerManager&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        <cfelse>
            <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandlerManager&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        </cfif>
    <br />
    
    <u>Test Data Validator</u>:
        <cfif len(TDV)>
            #TDV# / #TDVOffice# / #TDVDept# / #TDVEmail# <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=TDV&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        <cfelse>
            <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=TDV&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        </cfif><br />
        
    <u>Test Data Validator's Manager</u>:
        <cfif len(TDVManager)>
            #TDVManager# / #TDVManagerOffice# / #TDVManagerDept# / #TDVManagerEmail# <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=TDVManager&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        <cfelse>
            <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=TDVManager&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        </cfif>
    <Br /><Br />
<cfelseif AuditType2 eq "In-Process">
    <u>Project Handler</u>: 
        <cfif len(ProjectHandler)>
            #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept# / #ProjectHandlerEmail# <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandler&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        <cfelse>
            <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandler&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        </cfif><br />
    
    <u>Project Handler's Manager</u>: 
        <cfif len(ProjectHandlerManager)>
            #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept# / #ProjectHandlerManagerEmail# <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandlerManager&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        <cfelse>
            <a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandlerManager&pageName=TechnicalAudits_AddAudit2.cfm')">Select</a>
        </cfif>
    <br />
</cfif>

<cfif isDefined("Form.Role")>
    <cfset RoleValue = "#Form.Role#"> 

	<cfif isDefined("Form.Selection")>
		<!--- find the location of the FIRST ! in the Form.Selection String, findat is the count including the ! symbol --->
        <!--- the first part of this string is the name, then location_code, then dept --->
        <cfset FindAt = "#Find("!", Form.Selection) - 1#">
        
		<!--- set the NameValue variable to everything left of the FIRST ! symbol --->
        <cfset NameValue = "#left(Form.Selection, FindAt)#">
        
        <!--- identify length of string after first ! symbol --->
        <cfset FindAt = "#Find("!", Form.Selection)#">
        
		<!--- length of the rest of the string --->
        <cfset newString = len(Form.Selection) - FindAt>
        
		<!--- the rest of the string needs to be evaluated for Dept and Location Code --->
        <cfset newValue = "#right(Form.Selection, newString)#">
    
        <!--- find the location of the ! in the newValue String, findat is the count including the ! symbol --->
        <cfset FindAt = "#Find("!", newValue) - 1#">
        
		<!--- set the OfficeNameValue variable to everything left of the ! symbol --->
        <cfset OfficeNameValue = "#left(newValue, FindAt)#">
        
        <!--- find the location of the ! in the newValue String, this time to get the Dept to the RIGHT of the ! symbol --->
        <cfset FindAt = "#Find("!", newValue)#">
        
		<!--- length of the rest of the string --->
        <cfset newString = len(newValue) - FindAt>
        
		<!--- set the DeptValue variable to everything right of the ! symbol --->
        <cfset DeptAndEmailValue = "#right(newValue, newString)#">
        
        <!--- find the ! in the string above --->
        <cfset FindAt = "#Find("!", DeptAndEmailValue)- 1#">
        
        <!--- set the DeptValue variable to everything left of the ! symbol --->
        <cfset DeptValue = "#left(DeptAndEmailValue, FindAt)#">
        
        <!--- find the location of the ! in the newValue String, this time to get the Dept to the RIGHT of the ! symbol --->
        <cfset FindAt = "#Find("!", DeptAndEmailValue)#">
        
        <!--- length of the rest of the string --->
        <cfset newString = len(DeptAndEmailValue) - FindAt>
		
		<!--- the rest should be EmailValue --->
        <cfset EmailValue = "#right(DeptAndEmailValue, newString)#">
	<cfelse>
		<cfset NameValue = "#Form.Name#">
        <cfset OfficeNameValue = "#Form.Location#">
        <cfset DeptValue = "#Form.DepartmentNumber#">
        <cfset EmailValue = "#Form.Email#">
	</cfif>
       
    <cfform action="TechnicalAudits_AddAudit2_Action.cfm?ID=#URL.ID#&Year=#URL.Year#">
         <cfinput
         	type="hidden"
            name="Role"
            value="#Form.Role#">
         
         <cfinput
            type="hidden" 
            name="#Form.Role#" 
            value="#NameValue#">
 
         <cfinput
            type="hidden" 
            name="#Form.Role#Dept" 
            value="#DeptValue#">        

         <cfinput
            type="hidden" 
            name="#Form.Role#Office" 
            value="#OfficeNameValue#">
            
        <cfinput
        	type="hidden"
            name="#Form.Role#Email"
            value="#EmailValue#">
            
            <br><u>Current Selection for #Form.Role#</u>: #NameValue# / #OfficeNameValue# / #DeptValue# / #EmailValue#<Br><br>
        
        <cfinput type="Submit" name="Submit" value="Save #Form.Role#">
    </cfform>
</cfif>

<!---
<cfif AuditType2 eq "Full">
	<cfif len(ProjectHandler) AND len(ProjectPR) AND len(ProjectFR)>
    	<a href="TechnicalAudits_AddAudit2_Confirm.cfm?ID=#URL.ID#&Year=#URL.Year#">Save and Continue</a>
    </cfif>
<cfelse>
--->
	<cfif AuditType2 eq "Full">
		<cfif len(ProjectHandler) AND len(ProjectHandlerManager) AND len(TDV) AND len(TDVManager)>
            <a href="TechnicalAudits_AddAudit2_Confirm.cfm?ID=#URL.ID#&Year=#URL.Year#">Save and Continue</a>
        </cfif>
    <cfelseif AuditType2 eq "In-Process">
		<cfif len(ProjectHandler) AND len(ProjectHandlerManager)>
            <a href="TechnicalAudits_AddAudit2_Confirm.cfm?ID=#URL.ID#&Year=#URL.Year#">Save and Continue</a>
        </cfif>
	</cfif>
<!---
</cfif>
--->

</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Audit Roles">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<script language=javascript>
	window.name = "doUpLoadProc";
</script>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=350,left = 200,top = 200');");
}
// End -->
</script>

<cfoutput>
Project Handler/Evaluator:
<a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectHandler&pageName=TechnicalAudits_Roles.cfm')">Select</a>
<Br>

Project Prime Reviewer:
<a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectPrimeReviewer&pageName=TechnicalAudits_Roles.cfm')">Select</a>
<Br>

Project Preliminary Reviewer:
<a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectPR&pageName=TechnicalAudits_Roles.cfm')">Select</a>
<Br>

Project Final Reviewer:
<a href="javascript:popUp('TechnicalAudits_Roles_Lookup.cfm?ID=#URL.ID#&Year=#URL.Year#&Role=ProjectFR&pageName=TechnicalAudits_Roles.cfm')">Select</a>
<Br>

<cfif isDefined("Form.Role")>
	<cfif isDefined("Form.Role")>
        <cfset RoleValue = "#Form.Role#">
    <cfelse>
        <cfset RoleValue = "">
    </cfif>
    
    <cfif isDefined("Form.Dept")>
        <cfset DeptValue = "#Form.Dept#">
    <cfelse>
        <cfset DeptValue = "">
    </cfif>
    
    <cfif isDefined("Form.OfficeName")>
        <cfset OfficeNameValue = "#Form.OfficeName#">
    <cfelse>
        <cfset OfficeNameValue = "">
    </cfif>
    
    <cfif isDefined("Form.Name")>
        <cfset NameValue = "#Form.Name#">
    <cfelse>
        <cfset NameValue = "">
    </cfif>
    
    <cfform action="TechnicalAudits_Roles_Action.cfm">
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
            name="#Form.Role#OfficeName" 
            value="#OfficeNameValue#">
            
            <br><u>Current Selection for #Form.Role#</u>: #NameValue# / #OfficeNameValue# / #DeptValue#<Br><br>
        
        <cfinput type="Submit" name="Submit" value="Save #Form.Role#">
    </cfform>
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
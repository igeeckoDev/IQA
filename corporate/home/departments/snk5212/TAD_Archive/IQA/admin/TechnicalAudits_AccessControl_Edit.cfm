<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Access Control - Edit Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>View User</b><br><br>

<cfif IsDefined("URL.ID") 
	AND IsDefined("URL.verifyID") 
    AND Hash(URL.ID) IS "#URL.verifyID#">

    <CFQUERY Name="User" Datasource="Corporate">
    SELECT *
    From IQADB_Login
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cfoutput query="User">
    <u>Name</u>: #Name#<br>
    <u>Email</u>: #Email#<br><br>
    
    <u>Change Status</u>: (Current Status: <cfif len(Status)>#Status#<cfelse>Active</cfif>)<Br><br>

    <!--- included for Form Validation and Formatted Form Textarea boxes --->
    <!--- form name and id must be "myform" --->
    <cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

	<form action="TechnicalAudits_AccessControl_Update.cfm?ID=#ID#&verifyID=#Hash(ID)#" method="post" name="myform" id="myform">
        <cfif Status eq "Removed">
            Active <input type="radio" name="Status" value="Active"> 
            Removed <input type="radio" name="Status" value="Removed" data-bvalidator="required" data-bvalidator-msg="Please Select Active or Removed" checked>
        <cfelse>
            Active <input type="radio" name="Status" value="Active" checked> 
            Removed <input type="radio" name="Status" value="Removed" data-bvalidator="required" data-bvalidator-msg="Please Select Active or Removed">
        </cfif>
        <Br><br>
    
        <input type="submit" name="upload" value="Submit Form and Continue">
        <input type="reset" name="upload" value="Reset Form"><br /><br />
    </form>
    
    <!--- required for form validation --->
	<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">
    
    </cfoutput>
<cfelse>
	Access Denied.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Assign Appeals">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- select auditor info --->
<CFQUERY Name="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
From 
	TechnicalAudits_AuditSchedule
WHERE 
	ID = #URL.ID# 
    AND Year_ = #URL.Year#
</CFQUERY>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<b>Current Action</b><br />
<cfoutput>
Assign Appeals<br /><br />
</cfoutput>

<cfif isDefined("Form.Submit")>
	<cfoutput>
	    <b>Select Employee - Search Results (#Form.Last_Name#)</b><br />
    </cfoutput>
    
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, employee_email, Person_ID
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE UPPER(last_name) LIKE UPPER('#form.last_name#%')
    ORDER BY last_name, first_n_middle
    </CFQUERY>
    
    <cfoutput query="QEmpLookup">
    #first_n_middle# #last_name# - #employee_email# <A href="TechnicalAudits_AssignAppeals_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Person_ID#">[Select]</A><br>
    </cfoutput><br>
    
    The following email will be sent when you assign an employee to this Audit's appeals:<br><br>
    
    <cfoutput>
    <Cfset DueDate = DateAdd('d', 14, curdate)>
    Appeal Due Date = #dateformat(DueDate, "mm/dd/yyyy")#<br><br>
    </cfoutput>
    
    To: Appeal Assignee<Br>
    From: Technical Audit Manager<br>
    Subject: Internal Technical Auditor - Appeal Assignment<br><br>
    
    <cfoutput query="Audit">
    	<cfinclude template="TechnicalAudits_EmailText_AssignAppeals.cfm"> 
    </cfoutput>   
<cfelse>
	<cfoutput>
    <FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#CGI.Script_Name#?#CGI.Query_String#">
    </cfoutput>
    
    <b>Select Employee - Search by Last Name</b><br />
    <input name="Last_Name" type="Text" size="70" value="">
    <br><br>
    
    <input name="Submit" type="Submit" value="Search for Employee"> 
    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
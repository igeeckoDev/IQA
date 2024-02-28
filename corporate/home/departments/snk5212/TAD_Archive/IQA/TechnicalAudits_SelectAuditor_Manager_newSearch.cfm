<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Assign Engineering Manager">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- select auditor info --->
<CFQUERY Name="Roles" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	Auditor, AuditorEmail, AuditorDept, AuditorOfficeName,
	AuditorManager, AuditorManagerEmail, AuditorManagerDept, AuditorManagerOfficeName
From 
	TechnicalAudits_AuditSchedule
WHERE 
	ID = #URL.ID# AND Year_ = #URL.Year#
</CFQUERY>

<cfoutput query="Roles">
<b>Assigned Auditor</b><br />
#Auditor#<br />
#AuditorDept#<Br />
#AuditorOfficeName#<br /><br />

<b>Auditor's Manager</b><br />
#AuditorManager#<br />
#AuditorManagerDept#<Br />
#AuditorManagerOfficeName#<br /><br />
</cfoutput>

<cfif isDefined("Form.Submit")>
	<cfoutput>
	    <b>Select Engineering Manager - Search Results (#Form.Last_Name#)</b><br />
    </cfoutput>
    
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, employee_email, Person_ID
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE UPPER(last_name) LIKE UPPER('#form.last_name#%')
    ORDER BY last_name, first_n_middle
    </CFQUERY>
    
    <cfoutput query="QEmpLookup">
    #first_n_middle# #last_name# - #employee_email# <A href="TechnicalAudits_SelectAuditor_Manager_newSearch_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Person_ID#">[Select]</A><br>
    </cfoutput>
<cfelse>
	<cfoutput>
    <FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#CGI.Script_Name#?#CGI.Query_String#">
    </cfoutput>
    
    <b>Select Engineering Manager - Search by Last Name</b><br />
    <input name="Last_Name" type="Text" size="70" value="">
    <br><br>
    
    <input name="Submit" type="Submit" value="Search for Employee"> 
    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
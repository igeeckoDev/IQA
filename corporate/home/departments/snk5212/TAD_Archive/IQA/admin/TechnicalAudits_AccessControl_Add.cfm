<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Access Control - Add Account">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>Add User</b><br><br>

<cfif isDefined("Form.Submit")>
	<cfoutput>
	    <b>Select Name - Search Results (#Form.Last_Name#)</b><br />
    </cfoutput>
    
    <CFQUERY NAME="QEmpLookup" datasource="OracleNet">
    SELECT first_n_middle, last_name, employee_email, Person_ID
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE UPPER(last_name) LIKE UPPER('#form.last_name#%')
    ORDER BY last_name, first_n_middle
    </CFQUERY>
    
    <cfoutput query="QEmpLookup">
    #first_n_middle# #last_name# - #employee_email# <A href="TechnicalAudits_AccessControl_Add_Update.cfm?Person_ID=#Person_ID#">[Select]</A><br>
    </cfoutput>
<cfelse>
	<cfoutput>
    <FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#CGI.Script_Name#?#CGI.Query_String#">
    </cfoutput>
    
    <b>Select Name - Search by Last Name</b><br />
    <input name="Last_Name" type="Text" size="70" value="">
    <br><br>
    
    <input name="Submit" type="Submit" value="Search for Employee"> 
    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
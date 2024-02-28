<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Check Credentials">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT * 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
<cfif isDefined("url.EmpNo")>
	WHERE employee_number = '#url.EmpNo#'
<cfelseif isDefined("url.Person_ID")>
	WHERE Person_ID = '#url.Person_ID#'
</cfif>
</CFQUERY>

<Cfoutput query="qEmpLookup">
Name: #First_N_Middle# #Last_name#<Br>
Email: #Employee_Email#<Br>
Dept No: #Department_Number#<br>
Dept Name: #Department_Name#<Br>
Organization: #Organization#<Br>
Employee Number: #Employee_Number#<Br>
Title: #Employee_Title#<Br>
Location Code: #Location_Code#<Br><Br>

Supervisor Name: <a href="#CGI.SCRIPT_NAME#?Person_ID=#Supervisor_Person_ID#">#Supervisor_Name#</a><Br>
Supervisor Email: #Supervisor_Email#<Br>
Supervisor Title: #Supervisor_Title#<br><br />
</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
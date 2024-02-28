<!---
<cfdump var="#form#">
--->

<cfif isDefined("Form.EmpNo")>
	<cflocation url="http://dap.us.ul.com:8300/DAPAdminForms/faces/xxul_dap/projectAssoc/jspx/TestByStandards.jspx?userId=#Form.EmpNo#" addtoken="no">
<cfelse>
	Please enter your employee number (5 digits)<br><br>
		
	<cfform name="getEmpNo" action="getEmpNo_DAPScopeLink2_Submit.cfm" method="post">
		<cfinput type=text name=EmpNo required="yes" Message="Employee Number is required (xxxxx)">
		
		<input type="submit" value="Submit">
	</cfform>
</cfif>
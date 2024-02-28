<cfif isDefined("Form.EmpNo")>

<!--- query GCAR_Metrcs_QReports_Users to see if EmpNo is valid --->
<cfquery name="checkUser" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT EmpNo, Status, Name, AccessLevel, ID
FROM GCAR_METRICS_QREPORTS_USERS
WHERE EmpNo = '#form.EmpNo#'
</cfquery>

	<!--- if found, and active, establish session below. If not found, show 'Access Denied' Message --->
    <cfif checkUser.recordcount eq 1 AND checkUser.Status eq "Active">
        <!--- Establish Session and create Session Variables --->
        <cflock scope="SESSION" timeout="60">
            <cfset SESSION.Auth = StructNew()>
            <cfset SESSION.Auth.IsLoggedIn = "Yes">
            <cfset SESSION.Auth.IsLoggedInApp = "#this.Name#">
            <cfset SESSION.Auth.EmpNo = "#checkUser.EmpNo#">
            <cfset SESSION.Auth.Name = "#checkUser.Name#">
            <cfset SESSION.Auth.AccessLevel = "#checkUser.AccessLevel#">
        </cflock>
        
        <!--- User is Active --->
        <!---<cfset checkLogin = "Active">--->
        <!---<cfset varEmpNo = "#form.EmpNo#">--->
		<cflocation url="AdminMenu.cfm" addtoken="no">

	<cfelseif checkUser.recordCount eq 1 AND checkUser.Status NEQ "Active">
		<!--- User is not active --->
		<!---<cfset checkLogin = "Not Active">--->

		<cfset subTitle = "Login Attempt - User Not Active">
		<!--- Start of Page File --->
		<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

		Access Denied - User Not Active<br /><br />
        
        If you have recieved this message in error, please use the Error Reporting Form.<Br /><br />
        
        <cfoutput>
        <a href="#GCARMetricsDir#">Return</a> to GCAR Metrics website
		</cfoutput>

		<!--- Footer, End of Page HTML --->
		<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
		<!--- /// --->

	<cfelseif checkUser.recordCount eq 0>
		<!--- User is not found --->
<!---<cfset checkLogin = "User Not Found">--->

		<cfset subTitle = "Login Attempted - User Not Found">
		<!--- Start of Page File --->
		<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

		Access Denied - User Not Found<br /><br />
        
        If you have recieved this message in error, please use the Error Reporting Form.<Br /><br />
        
        <cfoutput>
        <a href="#GCARMetricsDir#">Return</a> to GCAR Metrics website
		</cfoutput>

		<!--- Footer, End of Page HTML --->
		<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
		<!--- /// --->
	</cfif>

<cfelse>

<script language="VBScript">
	Class GetLoginID
		private varLoginID

		Property Get LoginID
			varLoginID = GetUserID1.LogonUserID
			LoginID = varLoginID
		End Property
	End Class
</script>
<script src="../../IQA/Scripts/AC_ActiveX.js" type="text/javascript"></script>
<script src="../../IQA/Scripts/AC_RunActiveContent.js" type="text/javascript"></script>

<script type="text/javascript">
AC_AX_RunContent( 'id','GetUserID1','width','320','height','169','classid','CLSID:2E5FD423-86E4-404B-AB80-76659DD1AF4D','codebase','http://usnbkiqas100p/departments/snk5212/SiteShared/GetWinID.CAB#version=2,2,0,0','_extentx','8467','_extenty','4471' ); //end AC code
</script><noscript><object id="GetUserID1" width=320 height=169
 classid="CLSID:2E5FD423-86E4-404B-AB80-76659DD1AF4D"
 codebase="http://usnbkiqas100p/departments/snk5212/SiteShared/GetWinID.CAB#version=2,2,0,0">
    <param name="_ExtentX" value="8467">
    <param name="_ExtentY" value="4471">
</object></noscript>

<cfform name="TempForm" action="#cgi.SCRIPT_NAME#" method="post">
<cfoutput>
<script language="vbscript">
	dim y
	Set y = New GetLoginID
	newVar = y.LoginID
	document.write "<input type='hidden' name='EmpNo' value=" & newVar & ">"
</script>
</cfoutput>
</cfform>

<script type="text/javascript">
	document.TempForm.submit();
</script>

</cfif>
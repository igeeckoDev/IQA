<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
   <script language="VBScript">
		Class GetLoginID
			private varLoginID

			Property Get LoginID
				varLoginID = GetUserID1.LogonUserID
				LoginID = varLoginID
			End Property
		End Class

	</script>
   <script src="Scripts/AC_ActiveX.js" type="text/javascript"></script>
   <script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</head>
<cfoutput>
<body>
<script type="text/javascript">
AC_AX_RunContent( 'id','GetUserID1','width','320','height','169','classid','CLSID:2E5FD423-86E4-404B-AB80-76659DD1AF4D','codebase','#request.serverProtocol##request.serverDomain#/departments/snk5212/SiteShared/GetWinID.CAB##version=2,2,0,0','_extentx','8467','_extenty','4471' ); //end AC code
</script><noscript><object id="GetUserID1" width=320 height=169
 classid="CLSID:2E5FD423-86E4-404B-AB80-76659DD1AF4D"
 codebase="#request.serverProtocol##request.serverDomain#/departments/snk5212/SiteShared/GetWinID.CAB##version=2,2,0,0">
    <param name="_ExtentX" value="8467">
    <param name="_ExtentY" value="4471">
</object></noscript>


	<cfform name="TempForm" action="GetEmpNo_DAPScopeLink2.cfm" method="post">
		<script language="vbscript">
			dim y
			Set y = New GetLoginID
			newVar = y.LoginID
			document.write "<input type='hidden' name='EmpNo' value=" & newVar & ">"
		</script>
	</cfform>
</cfoutput>

<script type="text/javascript">
	document.TempForm.submit();
</script>

</body>
</html>
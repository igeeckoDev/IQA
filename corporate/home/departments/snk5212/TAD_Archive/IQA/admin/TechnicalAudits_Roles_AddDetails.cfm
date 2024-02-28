<cfoutput>
<link href="#Request.CSS#" rel="stylesheet" media="screen">

<div class="Blog-Title">
<b>#URL.Role# - Employee Lookup</b>
</div><br>

<div class="Blog-Content">
<cfform 
    action="#url.PageName#?#cgi.QUERY_STRING#"
    method="post" 
    name="uploadnew"
    target="doUpLoadProc" 
    onsubmit="setTimeout('self.close()',500)">
    
    <input name="Role" value="#url.Role#" type="hidden" />

	Name: (order: First Middle Last)<br />
	<cfinput name="Name" value="" type="text" size="40" required="yes" /><br /><br />
    
    Location:<br />
    <cfinput name="Location" value="" type="text" required="yes" /><br /><br />
    
    Department Number:<br />
    <cfinput name="DepartmentNumber" value="" type="text" required="yes" /><br /><br />

	<input name="Select" type="submit" value="Select #URL.Role#">

</cfform>
</div>
</cfoutput>
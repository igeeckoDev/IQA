<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title="Manage User Accounts">
<cfinclude template="SOP.cfm">

<!--- / --->

<!---
<cflock scope="SESSION" timeout="60">
<CFQUERY BLOCKFACTOR="100" NAME="SelectUser" Datasource="Corporate"> 
SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE Name = '#SESSION.AUTH.Name#'
</CFQUERY>
</CFLOCK>
--->

<!---
<script language="javascript"> 
<!-- 
function check_current_pw() 
{
	if (document.theForm.Current.value != document.theForm.password.value){
		alert ("Your current password was entered incorrectly.");
		return false;
	 } 
	 
	if (document.theForm.ConfirmP1.value != document.theForm.ConfirmP2.value){
		alert ("The confirmation password and new password to not match.");
		return false;
	 } 
	 
  return true;	 
}
//-->
</script>
--->

<Br>
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU">

<cfif isDefined("URL.Role")>
	<cfif url.Role eq "Andon">
        <CFQUERY BLOCKFACTOR="100" NAME="Andon" Datasource="Corporate"> 
        SELECT * FROM IQADB_Login
        WHERE (AccessLevel = 'IQAAuditor'
        OR AccessLevel = 'SU' 
        OR AccessLevel = 'Admin'
        OR AccessLevel = 'RQM')
        AND Name IS NOT NULL
        AND Status IS NULL
        ORDER BY Andon DESC, AccessLevel, Region, SubRegion, UserName
        </CFQUERY>
       
        <cfif isDefined("URL.ID") AND isDefined("URL.Action")>
        <CFQUERY BLOCKFACTOR="100" NAME="UserInfo" Datasource="Corporate"> 
        SELECT Name, UserName FROM IQADB_Login
        WHERE ID = #URL.ID#
        </CFQUERY>
        	<cfoutput query="UserInfo">
            <font color="red">
				<b>Andon Action Taken</b>: #Name# (#UserName#) - #URL.Action#
                <br><br>
            </font>
			</cfoutput>
        </cfif>
        
   	    <table width="650" align="left" border="1">
        <tr>
            <Td class="blog-title" align="center">Access Level</td>
            <Td class="blog-title" align="center">User</td>
            <td class="blog-title" align="center">Andon</td>
            <td class="blog-title" align="center">Change</td>
        </tr>
    	<cfoutput query="Andon">
			<cfif Andon is "Yes">
                <cfset Action = "Removed">
            <cfelse>
                <cfset Action = "Added">
            </cfif>
        <tr>
        	<Td class="blog-content">
            	#accesslevel#<Cfif AccessLevel is "RQM"> - #Region#/#SubRegion#</Cfif>
            </td>
        	<Td class="blog-content">
            	#UserName# (<cfif len(name)>#Name#<cfelse><u>Not Assigned</u></cfif>)
            </td>
            <td class="blog-content">
            	#Andon#
            </td>
        	<td class="blog-content" align="center">
            	<a href="Manage_Andon_User.cfm?ID=#ID#&Role=Andon&Action=#Action#">
					<cfif Andon is "Yes">Remove<cfelse>Add</cfif>
                </a>
            </td>
        </tr>
    	</CFOUTPUT>
    </table>
    </cfif>

<cfelse>

    <CFQUERY BLOCKFACTOR="100" NAME="SelectAll" Datasource="Corporate"> 
    SELECT * FROM  IQADB_LOGIN "LOGIN" 
    WHERE Status IS NULL
    ORDER BY AccessLevel, Region, SubRegion, UserName
    </CFQUERY>
  	<table width="650" align="left" border="1">
        <tr>
            <Td class="blog-title" align="center">Access Level</td>
            <Td class="blog-title" align="center">User</td>
            <td class="blog-title" align="center">Edit</td>
        </tr>
        <CFOUTPUT query="SelectAll">
        <tr>
        	<Td class="blog-content">
            	#accesslevel#<Cfif AccessLevel is "RQM"> - #Region#/#SubRegion#</Cfif>
            </td>
        	<Td class="blog-content">
            	#UserName# (<cfif len(name)>#Name#<cfelse><u>Not Assigned</u></cfif>)
            </td>
        	<td class="blog-content" align="center">
            	<a href="manage_user.cfm?ID=#ID#">edit</a>
            </td>
        </tr>
    	</CFOUTPUT>
    </table>
</cfif>

<!---
<cfelseif SESSION.Auth.accesslevel is "SU" or SESSION.Auth.AccessLevel is "Admin">

<CFOUTPUT query="SelectUser">
<b>Change your password.</b><br><br>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="theForm" ACTION="manage_password.cfm" onsubmit="return check_current_pw()">
Current Password:<br>
<INPUT TYPE="HIDDEN" name="password" value="#password#">
<INPUT TYPE="HIDDEN" name="ID" value="#ID#">
<cfINPUT TYPE="TEXT" NAME="Current" required="yes" message="Enter your current password"><br><br>
New Password:<br>
<cfINPUT TYPE="TEXT" NAME="ConfirmP1" required="yes" message="Enter your new password"><br><br>
Confirm Password:<br>
<cfINPUT TYPE="TEXT" NAME="ConfirmP2" required="yes"  message="Confirm your password"><br><br>
<INPUT TYPE="Submit" value="Submit Changes">
</cfFORM>
</CFOUTPUT>

<cfelse>
Get outta here.
--->
</cfif>
</cflock>						  
			  					  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
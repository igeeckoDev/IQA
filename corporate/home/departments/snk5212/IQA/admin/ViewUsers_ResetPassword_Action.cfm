<cfif Form.PasswordReset is "Confirm">
	<CFQUERY name="ResetPassword" Datasource="Corporate">
    UPDATE IQADB_LOGIN
    SET Password = 'temppwd'
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="User"> 
    SELECT Name, Email, Username, Status
    FROM IQADB_LOGIN
    WHERE ID = #URL.ID#
    </CFQUERY>
	
    <!--- null status = Active. If not active, do not send email --->
    <cfif NOT isDefined("#User.Status#")>
        <cfmail to="#Email#" from="Internal.Quality_Audits@ul.com" subject="Password Reset - IQA Web Site" query="User" type="html">
        The password for username <b>#Username#</b> has been reset. Your temporary password is <b>temppwd</b>.<br /><br />
        
        The next time you log in to the <a href="http://usnbkiqas100p/departments/snk5212/IQA/">IQA web site</a>, you will be asked to set a new password.<br /><br />
        </cfmail>
    </cfif>
    
    <cflocation url="ViewUsers_Detail.cfm?ID=#URL.ID#&msg=Password Reset" ADDTOKEN="No">
    
<cfelseif Form.PasswordReset is "Cancel">

    <cflocation url="ViewUsers_Detail.cfm?ID=#URL.ID#&msg=Password Reset Action Cancelled" ADDTOKEN="No">

</cfif>
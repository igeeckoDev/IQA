<cfif form.e_CCN EQ "Retain Current">
    <cflocation url="Auditors_Details.cfm?#CGI.QUERY_STRING#&msg=Qualified CCNs Not Updated - Retain Current values indicated" addtoken="No">
<cfelse>
    <CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT CCN, History 
    FROM Auditors
    WHERE ID = #URL.ID#
    </cfquery>
    
	<CFQUERY Name="AuditorCCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE Auditors
    SET
    <cfif form.e_CCN eq "None">
    CCN = NULL
    <cfelseif form.e_CCN CONTAINS "Retain Current">
       	<cfset newValues = #replace(form.e_CCN, "Retain Current,", "", "All")#>
       	CCN = '#History.CCN#,#newValues#'
    <cfelse>
    CCN = '#Form.e_CCN#'
    </cfif>
    WHERE ID = #URL.ID#
    </CFQUERY>
    
	<cflock scope="SESSION" timeout="6">
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE Auditors
        SET
        History='#History.History#<br /><br />
        	Qualified CCNs Edited<br>
            New Qualified CCNs: #Form.e_CCN#<br />
            Old Qualified CCNs: #History.CCN#<br />
            Action by: #SESSION.Auth.Name#/#Session.Auth.UserName#<br />
            Date: #curdate# #curTime#'
        
		WHERE ID = #URL.ID#
        </CFQUERY>
	</cflock>
   
   	<cflocation url="Auditors_Details.cfm?#CGI.QUERY_STRING#&msg=Qualified CCNs Updated" addtoken="No">
</cfif>
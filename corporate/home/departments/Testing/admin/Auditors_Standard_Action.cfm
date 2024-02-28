<cfif form.e_Standard EQ "Retain Current">
    <cflocation url="Auditors_Details.cfm?#CGI.QUERY_STRING#&msg=Qualified Standards Not Updated - Retain Current values indicated" addtoken="No">
<cfelse>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Standard, History 
    FROM Auditors
    WHERE ID = #URL.ID#
    </cfquery>

	<CFQUERY Name="AuditorStandard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE Auditors
    SET
    <cfif form.e_Standard eq "None">
    Standard = NULL
	<cfelseif form.e_Standard CONTAINS "Retain Current">
       	<cfset newValues = #replace(form.e_Standard, "Retain Current,", "", "All")#>
       	Standard = '#History.Standard#,#newValues#'
    <cfelse>
    Standard = '#Form.e_Standard#'
    </cfif>
    WHERE ID = #URL.ID#
    </CFQUERY>
    
	<cflock scope="SESSION" timeout="6">
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add">
        UPDATE Auditors
        SET
        History='#History.History#<br /><br />
        	Qualified Standards Edited<br>
            New Qualified Standards: #Form.e_Standard#<br />
            Old Qualified Standards: #History.Standard#<br />
            Action by: #SESSION.Auth.Name#/#Session.Auth.UserName#<br />
            Date: #curdate# #curTime#'
        
		WHERE ID = #URL.ID#
        </CFQUERY>
	</cflock>
    
    <cflocation url="Auditors_Details.cfm?#CGI.QUERY_STRING#&msg=Qualified Standards Updated" addtoken="No">
</cfif>
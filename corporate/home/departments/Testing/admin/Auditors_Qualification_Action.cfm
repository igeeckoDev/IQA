<cfif form.e_Qualified EQ "Retain Current">
    <cflocation url="Auditors_Details.cfm?#CGI.QUERY_STRING#&msg=Qualifications Not Updated - Retain Current values indicated" addtoken="No">
<cfelse>
    <CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Qualified, History 
    FROM Auditors
    WHERE ID = #URL.ID#
    </cfquery>

	<CFQUERY Name="AuditorQualifications" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE Auditors
    SET
    <cfif form.e_Qualified eq "None">
    Qualified = NULL
	<cfelseif form.e_Qualified CONTAINS "Retain Current">
       	<cfset newValues = #replace(form.e_Qualified, "Retain Current,", "", "All")#>
       	Qualified = '#History.Qualified#,#newValues#'
    <cfelse>
    Qualified = '#Form.e_Qualified#'
    </cfif>
    WHERE ID = #URL.ID#
    </CFQUERY>
    
	<cflock scope="SESSION" timeout="6">
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE Auditors
        SET
        History='#History.History#<br /><br />
        	Qualified Audit Types Edited<br>
            New Qualified Audit Types: #Form.e_Qualified#<br />
            Old Qualified Audit Types: #History.Qualified#<br />
            Action by: #SESSION.Auth.Name#/#Session.Auth.UserName#<br />
            Date: #curdate# #curTime#'
        
		WHERE ID = #URL.ID#
        </CFQUERY>
	</cflock>
    
    <cflocation url="Auditors_Details.cfm?#CGI.QUERY_STRING#&msg=Qualifications Updated" addtoken="No">
</cfif>
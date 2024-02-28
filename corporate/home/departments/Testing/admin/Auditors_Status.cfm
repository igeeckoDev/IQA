<CFQUERY Name="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Location
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<cfif isDefined("Form.Submit")>
	<cfif Form.Status EQ "NoChanges" AND Form.Location EQ "NoChanges" 
		OR Form.Status EQ "NoChanges" AND Form.Location EQ "#Auditor.Location#">
    	<cflocation url="Auditors_Edit.cfm?ID=#ID#&Type=#URL.Type#&msg=Status and Location are unchanged" addtoken="no">
    <cfelse>
		<cfif form.status NEQ "NoChanges">
            <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="EditStatus" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE Auditors
            SET
            
            <cfif form.status is "Active">
            Status = NULL,
            ActiveDate = #CreateODBCDate(Form.StatusDate)#,
            RemoveDate = NULL
            <cfelseif form.status is "Removed">
            Status = 'Removed',
            RemoveDate = #CreateODBCDate(Form.StatusDate)#,
            ActiveDate = NULL
            </cfif>
            
            WHERE ID = #URL.ID#
            </CFQUERY>
            
            <cfset StatusChangeMsg = "Status Changed to #form.Status#<br>Effective Date #Form.StatusDate#">
        <cfelse>
            <cfset StatusChangeMsg = "No Status Changes Made">
        </cfif>

		<!--- Do not make change if the Location is "No Location Change/form.NoChanges" <br />
		or if the Location selected is the same as the one stored in the table --->
        <cfif form.location NEQ "NoChanges" AND form.location NEQ "#Auditor.Location#">
            <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="EditLocation" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE Auditors
            SET
            
            Location = '#Form.Location#'
            
            WHERE ID = #URL.ID#
            </CFQUERY>
        
            <cfset LocationChangeMsg = "Location Changed to #form.location#">
        <cfelse>
            <cfset LocationChangeMsg = "No Location Changes Made">
        </cfif>

        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT History 
        FROM Auditors
        WHERE ID = #URL.ID#
        </cfquery>

        <cflock scope="SESSION" timeout="6">
            <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit2" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE Auditors
            SET
            
            History = '#History.History#<br /><br />
            			Auditor Edited #curdate# #curTime#<br />
                        #StatusChangeMsg#<br />
                        #LocationChangeMsg#<br />
                        Changed By: #SESSION.Auth.Name#/#Session.Auth.UserName#'
            
            WHERE ID = #URL.ID#
            </CFQUERY>
        </cflock>

		<cflocation url="Auditors_Details.cfm?ID=#ID#&Type=#URL.Type#&msg=Auditor Details updated" addtoken="no">
	</cfif>
<cfelse>
	<cflocation url="Auditors_Edit.cfm?ID=#ID#&Type=#URL.Type#" addtoken="no">
</cfif>
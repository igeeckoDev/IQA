<cfif Form.ChangeStatus is "Change Status">
	<CFQUERY name="ChangeStatus" Datasource="Corporate">
    UPDATE IQADB_LOGIN
        <cfif Form.Status is "Active">
	        SET Status = NULL
        <cfelse>
    	    SET Status = '#Form.Status#'  
        </cfif>
    WHERE ID = #URL.ID#
    </CFQUERY>
 
    <cflocation url="ViewUsers_Detail.cfm?ID=#URL.ID#&msg=Status Changed to #Form.Status#" ADDTOKEN="No">   
</cfif>
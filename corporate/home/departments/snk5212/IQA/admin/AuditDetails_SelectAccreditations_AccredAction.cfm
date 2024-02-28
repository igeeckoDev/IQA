<cfif Form.Accred is "Clear">
	<CFQUERY name="AccredsClear" Datasource="Corporate">
    UPDATE AUDITSCHEDULE
    SET Accreditors = NULL
    WHERE ID = #URL.ID# 
    AND Year_ = #URL.YEAR#
    </CFQUERY>
    
    <cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">
    
<cfelseif Form.Accred is "Cancel">

	<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">

<cfelseif Form.Accred is "Confirm">
	<CFQUERY name="AccredsAdd" Datasource="Corporate">
    UPDATE AUDITSCHEDULE
    SET Accreditors = '#url.Accred#'
    WHERE ID = #URL.ID# 
    AND Year_ = #URL.YEAR#
    </CFQUERY>
    
    <cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">

</cfif>
<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addinfo">
UPDATE ExternalLocation
SET

Location='#Form.Location#',
Type='#Form.Type#',
Billable='#Form.Billable#',
Cert='#Form.Cert#',
Status=#Form.Status#,
KC=<cfif Form.KC is "">null<cfelse>'#Form.KC#'</cfif>,
KCEmail=<cfif Form.KCEmail is "">null<cfelse>'#Form.KCEmail#'</cfif>,
KCPhone=<cfif Form.KCPhone is "">null<cfelse>'#Form.KCPhone#'</cfif>,
Address1=<cfif Form.Address1 is "">null<cfelse>'#Form.Address1#'</cfif>,
Address2=<cfif Form.Address2 is "">null<cfelse>'#Form.Address2#'</cfif>,
Address3=<cfif Form.Address3 is "">null<cfelse>'#Form.Address3#'</cfif>,
Address4=<cfif Form.Address4 is "">null<cfelse>'#Form.Address4#'</cfif>

WHERE ID = #URL.ID#	
</cfquery>

<cflocation url="TPTDP_view.cfm?ID=#URL.ID#" addtoken="no">


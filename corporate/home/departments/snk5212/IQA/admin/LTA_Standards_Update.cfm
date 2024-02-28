<CFQUERY Name="Standards" Datasource="Corporate">
SELECT * From Standards_LTA
Order BY DocName
</CFQUERY>

<cfoutput query="Standards">
<cfif Form.DocName is "#DocName#">
	<cflocation url="LTA_Standards.cfm?msg=duplicate&id=#ID#" addtoken="no">
</cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM Standards_LTA
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO Standards_LTA(ID, DocName, DocNumber)
VALUES (#ID.newid#, '#Form.DocName#', '#Form.DocNumber#')
</CFQUERY>

<cflocation url="LTA_Standards.cfm?DocName=#Form.DocName#&DocNumber=#Form.DocNumber#&msg=added&ID=#ID.newid#" addtoken="no">
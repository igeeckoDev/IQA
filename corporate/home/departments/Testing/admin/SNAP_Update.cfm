<cfif NOT isDefined("form.SNAPComments") OR NOT isDefined("form.RevDetails")>
	<cflocation url="SNAP_Edit.cfm?#CGI.Query_String#&requiredfields=Yes" addtoken="no">
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
SELECT SNAPAudit, SNAPComments, OfficeName, ID
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<cfset Dump = #replace(form.SNAPComments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>

<cfset Dump3 = #replace(form.SCCComments, "<p>", "", "All")#>
<cfset Dump4 = #replace(Dump3, "</p>", "<br /><br />", "All")#>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
UPDATE IQAtblOffices
SET
SNAPSite='#Form.SNAPAudit#',
SNAPAudit='#Form.SNAPAudit#',

<cfif Dump2 eq "<br /><br />" OR NOT len(Dump2)>
	SNAPComments='No Comments'
<cfelse>
	SNAPComments='#Dump2#'
</cfif>,

SCCSite='#Form.SCCSite#',

<cfif Dump4 eq "<br /><br />" OR NOT len(Dump4)>
	SCCComments='No Comments'
<cfelse>
	SCCComments='#Dump4#'
</cfif>

WHERE ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RevHist">
SELECT MAX(RevNo)+1 as maxRev
FROM SNAP_RH
WHERE OfficeNameID = #url.ID#
</cfquery>

<cfif NOT len(RevHist.maxRev)>
	<cfset RevHist.maxRev = 0>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RevID">
SELECT MAX(ID)+1 as maxID FROM SNAP_RH
</cfquery>

<cfset Dump = #replace(form.RevDetails, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>

<cflock scope="Session" timeout="10">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddRevHist">
	INSERT INTO SNAP_RH(ID, OfficeNameID, RevNo, RevAuthor, RevDetails, RevDate)
	VALUES(#RevID.MaxID#, #url.ID#, #RevHist.maxRev#, '#SESSION.Auth.Name#', '#Dump2#', #CreateODBCDate(curdate)#)
	</cfquery>
</cflock>

<cflocation url="SNAP_Details.cfm?#CGI.QUERY_STRING#" addtoken="No">
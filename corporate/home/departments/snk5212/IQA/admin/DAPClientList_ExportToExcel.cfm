<cfsavecontent variable="output">
	<cfcontent type="application/msexcel">
	<cfcontent type="text/html">

<cfif NOT isDefined("URL.Order")>
	<cfset URL.Order = "DA">
</cfif>

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPClient
<cfif LEN("URL")>
WHERE 1 = 1
</cfif>
<cfif isDefined("URL.Status")>
	AND Status = '#URL.Status#'
</cfif>
<cfif isDefined("URL.Region")>
	AND Region = '#URL.Region#'
</cfif>
ORDER BY <cfif URL.Order eq "DA">DAFILENUMBER<cfelseif URL.Order eq "Client">CLIENTNAME</cfif>
</cfquery>

<table border="1">
<tr align="center" class="blog-title">
	<td>DA File Number</td>
	<td>Client Name</td>
	<td>Status</td>
	<td>Region</td>
	<td>Anniversary Date</td>
	<td>ACTL</td>
	<td>CBTL</td>
	<td>CTDP</td>
	<td>CTF Stage 3/4</td>
	<td>TCP</td>
	<td>TPTDP</td>
	<td>CAP</td>
	<td>PPP</td>
</tr>
<cfoutput query="output">
<tr class="blog-content" valign="top">
	<td>#DAFileNumber#</td>
	<td>#ClientName#</td>
	<td>#Status#</td>
	<td>#Region#</td>
	<td>#Dateformat(AnniversaryDate, "mm/dd/yyyy")#</td>
	<td><cfif len(ACTL)><u>ACTL</u>: #ACTL#<br></cfif></td>
	<td><cfif len(CBTL)><u>CBTL</u>: #CBTL#<br></cfif></td>
	<td><cfif len(CTDP)><u>CTDP</u>: #CTDP#<br></cfif></td>
	<td><cfif len(CTF)><u>CTF Stage 3/4</u>: #CTF#<br></cfif></td>
	<td><cfif len(TCP)><u>TCP</u>: #TCP#<br></cfif></td>
	<td><cfif len(TPTDP)><u>TPTDP</u>: #TPTDP#<br></cfif></td>
	<td><cfif len(CAP)><u>CAP</u>: #CAP#<br></cfif></td>
	<td><cfif len(PPP)><u>PPP</u>: #PPP#<br></cfif></td>
</tr>
</cfoutput>
</tr>
</table>
<br><Br>

<cfheader name="Content-Disposition" value="attachment; filename=DAPClientList.xls">
</cfsavecontent>

<cfoutput>#output#</cfoutput>
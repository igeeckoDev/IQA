<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPType">
SELECT * FROM ThirdPartyTypes
ORDER BY TPType
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - TPTDP Locations - <cfoutput>#TPTDP.ExternalLocation#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfoutput query="TPTDP">
<br><br>

<b>Third Party Participant:</b> <br>
#ExternalLocation#<br><br>

<b>Location:</b> <br>
#Location#<br><br>

<b>Type:</b> <br>
<cfif Trim(Type) is ""><Cfelse>#Type#</cfif><br><br>

<b>Billable:</b> <br>
#Billable#<br><br>

<cfif Type is "MOU" or Type is "TPTDP-I" or ID is 36>
<b>Certificate:</b><br> 
<a href="../certs/#Certificate#.pdf">View Certificate</a><br><br>

<font color="red">Note: Certificates issued in 2007 will be available for viewing on the IQA Audit Database until the dates of expiration in 2008, New certificates will no longer be issued by IQA after the 2008 dates of expiration. Please contact the DAP Process Owner, Jodine Hepner, x42418, for information regarding issuance and maintenance of new certificates.</font><br><br>
</cfif>

<b>Status:</b> <br>
<cfif Status is 1>Active<cfelseif Status is 0>Inactive/Removed<cfelse>Status Unknown</cfif><br><br>

<b>Key Contact:</b> <br>
#KC#<br><br>

<b>Key Contact Email:</b> <br>
#KCEmail#<br><br>

<b>Key Contact Phone:</b> <br>
#KCPhone#<br><br>

<b>Address:</b><br>
&nbsp;&nbsp;#Address1#<br>
&nbsp;&nbsp;#Address2#<br>
&nbsp;&nbsp;#Address3#<br>
&nbsp;&nbsp;#Address4#<br>
</cfoutput><br>

* Note: Certificates are issued by IQA <u>ONLY</u> for MOU and TPTDP-I clients.<br><br>
 					  			  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
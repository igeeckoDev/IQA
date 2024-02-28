<!--- DV_CORP_002 02-APR-09 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#SiteTitle# - CAR Training Documents">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<table border="1">
<tr>
<td class="Blog-Title" align="center">Document Name</td>
<td class="Blog-Title" align="center">Revision</td>
<td class="Blog-Title" align="center">Revision Date</td>
<td class="Blog-Title" align="center">File Type</td>
<td class="Blog-Title" align="center">View Document</td>
</tr>
<cfloop index="i" from="1" to="12">
<CFQUERY DataSource="Corporate" Name="Files"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d3fee8cf-171c-4ecf-9efb-ed2f8fd21601 Variable Datasource name --->
SELECT * FROM CARTraining
WHERE Rev = (SELECT MAX(Rev) FROM CARTraining WHERE DocNumber = #i#)
AND DocNumber = #i#
<!---TODO_DV_CORP_002_End: d3fee8cf-171c-4ecf-9efb-ed2f8fd21601 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cfoutput query="Files">
<tr>
<td class="Blog-Content">#FileTitle#</td>
<td class="Blog-Content" align="center"><cfif FileType is "DC">&nbsp;<cfelse>#Rev#</cfif></td>
<td class="Blog-Content" align="center"><cfif FileType is "DC">&nbsp;<cfelse>#dateformat(uploaded, "mm/dd/yyyy")#</cfif></td>
<td class="Blog-Content" align="center"><cfif FileType is "DC">Document Control<cfelse>#FileType#</cfif></td>
<td class="Blog-Content" align="center">
	<cfif FileType is "DC">
		<a href="#DCLink#">view</a>
	<cfelse>
		<a href="../../QE/CARTraining/CT#DocNumber#Current.#FileType#">view</a>			
	</cfif>
</td>
</tr>
</cfoutput>
</cfloop>
</table>
<br>

<b>Notes:</b><br>
A. <u>Viewing options</u><br>
1 - Select 'view' above<br>
2 - Right-Click on 'view' and select 'Save Target As' to save to your computer.<br><br>
<cflock scope="Session" timeout="5">	
	<cfif isDefined("Session.Auth.IsLoggedIn")>
B. <u>Viewing Powerpoint Notes</u><br>
1 - All Powerpoint files above have 'notes' which can be viewed by:<br>
2 - Saving the files to your computer (Note A.2 above)<br>
3 - Open the file in Powerpoint<br>
4 - Select 'View' followed by 'Notes Page'<br><br>
	</cfif>
</cflock>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
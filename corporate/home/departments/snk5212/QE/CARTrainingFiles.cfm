<!--- Start of Page File --->
<cfset subTitle = "CAR Training Documents">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("url.uploaded") AND isDefined("url.Rev") AND isDefined("url.DocName")>
	<cfoutput>
    <font color="red"><b>#URL.DocName# [Rev #URL.Rev#] has been uploaded</b></font>
    </cfoutput><br /><br />
</cfif>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
		<a href="CARTrainingNewFile.cfm"><b>Add</b></a> a new Document<br><br>
	</cfif>
</cflock>

<table border="1" style="border-collapse: collapse;">
<tr>
<td class="Blog-Title" align="center">Document Name</td>
<td class="Blog-Title" align="center">Revision</td>
<td class="Blog-Title" align="center">Revision Date</td>
<td class="Blog-Title" align="center">File Type</td>
<td class="Blog-Title" align="center">View Document</td>
<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
		<td class="Blog-Title" align="center">Upload File</td>
	</cfif>
</cflock>
</tr>
<CFQUERY DataSource="Corporate" Name="Documents">
SELECT MAX(DocNumber) as MaxDocNo
FROM CARTraining
WHERE Status IS NULL
</CFQUERY>

<cfloop index="i" from="1" to="#Documents.MaxDocNo#">
<CFQUERY DataSource="Corporate" Name="Files">
SELECT * FROM CARTraining
WHERE Rev = (SELECT MAX(Rev) FROM CARTraining WHERE DocNumber = #i#)
AND DocNumber = #i#
</CFQUERY>

<cfoutput query="Files">
<tr>
<td class="Blog-Content">#FileTitle#</td>
<td class="Blog-Content" align="center"><cfif FileType is "DC">&nbsp;<cfelse>#Rev#</cfif></td>
<td class="Blog-Content" align="center"><cfif FileType is "DC">&nbsp;<cfelse>#dateformat(uploaded, "mm/dd/yyyy")#</cfif></td>
<td class="Blog-Content" align="center"><cfif FileType is "DC">Document Control<cfelse>#FileType#</cfif></td>
<td class="Blog-Content" align="center">
<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
			<cfif FileType is "DC">
				<a href="#DCLink#">view</a>
			<cfelse>
				<a href="#CARRootDir#CARTraining/CT#DocNumber#Current.#FileType#">view</a>
			</cfif>
	<cfelse>
	<!--- not logged in --->
		<cfif Type is "Login">
		--
		<cfelseif Type is "All">
			<cfif FileType is "DC">
				<a href="#DCLink#">view</a>
			<cfelse>
				<a href="#CARRootDir#CARTraining/CT#DocNumber#Current.#FileType#">view</a>
			</cfif>
		</cfif>
	</cfif>
</cflock>
</td>
<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
		<td class="Blog-Content" align="center">
		<cfif FileType NEQ "DC">
			<a href="CARTrainingUpload.cfm?DocNumber=#DocNumber#&Type=#Type#">Upload</a></td>
		<cfelse>
			&nbsp;
		</cfif>
	</cfif>
</cflock>
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
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
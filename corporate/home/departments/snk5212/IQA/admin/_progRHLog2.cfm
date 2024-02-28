<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Program List - Revision History Log by Revision Date">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="RHLog"> 
SELECT * FROM ProgramRevLog
ORDER BY RevDate DESC, Program, RevNo
</CFQUERY>

<br>

<cfset date = "">
<cfoutput query="RHLog">
	<cfif date is NOT revdate>
		<b>#dateformat(RevDate, "mmmm dd, yyyy")#</b><br>
	</cfif>
<u>Program:</u> #Program#<br>
<u>Rev Number:</u> #revNo#<br>
<u>Author</u>: #RevAuthor#<br>
<u>Details:</u> #RevDetails#<br><br>
<cfset date = #revdate#>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Program List - Revision History Log by Program">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="RHLog"> 
SELECT * FROM ProgramRevLog
ORDER BY Program, RevNo
</CFQUERY>

<br>

<cfset prog = "">
<cfoutput query="RHLog">
	<cfif prog is NOT program>
		<b>#program#</b><br>
	</cfif>
<u>Rev Number:</u> #revNo#<br>
<u>Date:</u> #dateformat(RevDate, "mm/dd/yyyy")#<br>
<u>Author</u>: #RevAuthor#<br>
<u>Details:</u> #RevDetails#<br><br>
<cfset prog = #program#>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
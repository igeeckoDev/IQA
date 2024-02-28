<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - View Survey Responses with Comments">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="viewComments" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT qID, Answer, Notes
FROM CARSurvey_Answers
WHERE DBMS_LOB.SUBSTR(Notes, 500) NOT LIKE 'No Comments Added%'
ORDER BY qID, Answer
</CFQUERY>

<cfset qIDHolder = "">

<cfoutput query="viewComments">
<cfif NOT len(qIDHolder)>
	<b>Question #qID#</b>
<cfelse>
	<cfif qID NEQ qIDHolder>
	<br><br>
	<b>Question #qID#</b>
	</cfif>
</cfif>
<Br><br>

<u>Rating</u>: #Answer#<br>
<u>Comments</u>: #Notes#<br>

<cfset qIDHolder = qID>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditSurvey_Distribution.cfm?Year=#URL.Year#'>Audit Survey</a> - View Survey Responses with Comments">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="viewComments" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT qID, Answer, Notes, UserID
FROM AuditSurvey_Answers
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

<CFQUERY BLOCKFACTOR="100" name="AuditNumber" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditID, AuditYear
FROM AuditSurvey_Users
WHERE ID = #UserID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2, LeadAuditor
FROM AuditSchedule
WHERE ID = #AuditNumber.AuditID#
AND Year_ = #AuditNumber.AuditYear#
</CFQUERY>

<u>Rating</u>: <b>#Answer#</b><br>
<u>Audit</u>: #AuditNumber.AuditYear#-#AuditNumber.AuditID# [#Audit.Area# | #Audit.OfficeName# | #Audit.AuditType2# | #Audit.LeadAuditor#]<br>
<u>Comments</u>: #Notes#<br>

<cfset qIDHolder = qID>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
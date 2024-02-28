<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "CAR Trend Reports - <a href=Report_EmailOwner_History.cfm>Functional Group Owners Email History</a> - View Email">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="selectRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM GCAR_METRICS_SentEmail
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="selectRow">
<b>Date Sent</b><br />
#dateformat(SendDate, "mm/dd/yyyy")#<br /><br />

<b>To</b><br />
#replace(SendTo, ",", "<br />", "All")#<br /><br />

<cfif len(SendCC)>
<b>CC / FYI</b><br />
#replace(SendCC, ",", "<br />", "All")#<br /><br />
</cfif>

<b>From</b><br />
#SendFrom#<br /><br />

<b>Subject</b><br />
#Subject#<br /><br />

<b>Link</b><br />
<a href="#LinkTo#">#LinkTo#</a><br /><br />

<b>Email Body</b><br />
#EmailBody#<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
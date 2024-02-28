<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Current Due Dates">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Audits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE CurrentDueDate IS NOT NULL
AND CurrentDueDateField IS NOT NULL
ORDER BY Year_, ID
</cfquery>

<cfoutput query="Audits">
#Year_#-#ID#: #dateformat(CurrentDueDate, "mm/dd/yyyy")# (#CurrentDueDateField#)<br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
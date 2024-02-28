<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Calendar List View by ID - <cfoutput>#url.year#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY DataSource="Corporate" Name="BaseLine">
SELECT * FROM Baseline
WHERE Year_ = #URL.Year#
</cfquery>

<cfif BaseLine.BaseLine eq 0>
	<cfoutput>
	<font color="red">#URL.Year# IQA Audit Schedule is tentative.</font><br><Br>
	</cfoutput>
</cfif>

<cfinclude template="#IQARootDir#qAudit_List3.cfm">

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
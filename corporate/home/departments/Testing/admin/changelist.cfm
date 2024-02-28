<!--- DV_CORP_002 02-APR-09 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Change Log List">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="#DB.ChangeLog#" NAME="Query"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 29bea48e-b943-4d74-ba85-577863c1f18a Variable Datasource name --->
SELECT DISTINCT Page FROM changelog1
	ORDER BY Page
<!---TODO_DV_CORP_002_End: 29bea48e-b943-4d74-ba85-577863c1f18a Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>
<br>
<cfoutput query="Query">
- <a href="changelog.cfm?page=#page#">#Page#</a><br>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
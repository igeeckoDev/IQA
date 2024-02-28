<!--- DV_CORP_002 02-APR-09 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Change Log">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="#DB.ChangeLog#" NAME="Query"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 68142981-1082-41c5-8eeb-4adfd1eb082e Variable Datasource name --->
SELECT * FROM changelog1
	WHERE Page = '#URL.Page#'
	ORDER BY Page, EditDate
<!---TODO_DV_CORP_002_End: 68142981-1082-41c5-8eeb-4adfd1eb082e Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>
<br>
<cfoutput query="Query">
<b><u>#Page#</u></b><br><br> 
</cfoutput>

<cfoutput query="Query">
Date/Time - #Dateformat(editdate, 'mm/dd/yyyy')#, #Timeformat(editdate, 'HH:mm:ss')#<br>
Username - #username#<br>
#page#<br><br>
#changelog#<br><br>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
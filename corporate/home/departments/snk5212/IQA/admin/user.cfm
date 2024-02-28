<cfif isDefined("URL.ID")>
	<cfset e_finduser = #URL.ID#>
<cfelse>
   	<cfset e_finduser = #form.e_finduser#>
</cfif>

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" name="finduser" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT * FROM IQADB_LOGIN "LOGIN" 
WHERE ID = #e_finduser#
ORDER BY Username
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "User Access Log">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<p class="blog-content">
<cfoutput query="finduser">
<b>Username</b>: <u>#username#</u><br>
<b>Name</b>: #name#<br>
<b>Subregion</b>: #SubRegion#<br>
<b>Region</b>: #Region#<br>
<b>Office</b>: #Office#<br>
<b>Access Level</b>: #AccessLevel#<br>
<b>Email</b>: #Email#<br>
<b>Phone</b>: #phone#<br>
<b>Last IP</b>: #LastIP#<br>
<b>Last Browser</b>: #LastBrowser#<br>
<b>Total Logins</b>: #TotalLogins#<br>
<b>Last Login</b>: #LastLogin#<br><br>

<b>Login Date/Time Log</b>:<br>#LoginLog#<br>
<b>IP Log</b>:<br>#IPLog#
</cfoutput>
</p>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="check" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 42c24e18-7747-4cfe-9657-41d27e8c527d Variable Datasource name --->
SELECT * FROM RH
WHERE filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: 42c24e18-7747-4cfe-9657-41d27e8c527d Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfif check.recordcount eq 0>
	<CFQUERY BLOCKFACTOR="100" name="maxID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 5b45e165-8179-48f7-a243-30aca9132d11 Variable Datasource name --->
SELECT MAX(ID)+1 as max FROM RH
<!---TODO_DV_CORP_002_End: 5b45e165-8179-48f7-a243-30aca9132d11 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	
	<cflock scope="Session" Timeout="5" type="READONLY">
	<CFQUERY BLOCKFACTOR="100" name="register" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 30572dcc-a801-4f0b-8bc6-f0161dcedc3d Variable Datasource name --->
INSERT INTO RH(ID,Filename,RevNo,RevDetails,RevAuthor,RevDate)
			VALUES(#maxID.max#,'#url.filename#',1,'Initial Publication','#SESSION.Auth.Name#','#curdate#')
<!---TODO_DV_CORP_002_End: 30572dcc-a801-4f0b-8bc6-f0161dcedc3d Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	</cflock>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="regconf" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: dce9a876-9a1a-4b0c-bcb9-27c436a17451 Variable Datasource name --->
SELECT * FROM RH
WHERE filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: dce9a876-9a1a-4b0c-bcb9-27c436a17451 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Register a Page">
<cfinclude template="SOP.cfm">

<!--- / --->
			
<br>

<cfif check.recordcount gt 0>
	This page has already been registered.
<cfelse>
	The page has been registered.
</cfif><br><br>

<cfoutput query="regconf">
<u>Filename</u>: #Filename#<br>
<u>Rev Number</u>: #RevNo#<br>
<u>Rev Author</u>: #RevAuthor#<br>
<u>Rev Date</u>: #dateformat(curdate, "mmmm dd, yyyy")#<br>
<u>Rev Details</u>: #RevDetails#<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
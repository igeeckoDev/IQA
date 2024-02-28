<!--- DV_CORP_002 02-APR-09 --->
<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>

<cflock timeout="60" scope="SESSION">
<CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: f40490a3-6964-4b2f-9d63-c21a87a7227d Variable Datasource name --->
SELECT * FROM login 
WHERE username = '#SESSION.Auth.username#'
<!---TODO_DV_CORP_002_End: f40490a3-6964-4b2f-9d63-c21a87a7227d Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	
<CFQUERY BLOCKFACTOR="100" DataSource="#DB.ChangeLog#" NAME="Query"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 13bc0e2c-d08e-46c3-b6db-03367f1bf954 Variable Datasource name --->
SELECT MAX(ID) + 1 AS newid FROM changelog1
<!---TODO_DV_CORP_002_End: 13bc0e2c-d08e-46c3-b6db-03367f1bf954 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>	

<CFQUERY BLOCKFACTOR="100" name="accesslog" DataSource="#DB.ChangeLog#"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: e71f98d8-706a-48f5-827f-a483206e4f46 Variable Datasource name --->
INSERT INTO changelog1(ID)
	VALUES (#Query.newid#)
<!---TODO_DV_CORP_002_End: e71f98d8-706a-48f5-827f-a483206e4f46 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	
<CFQUERY BLOCKFACTOR="100" name="changelog" DataSource="#DB.ChangeLog#"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 528efe13-78fa-457c-8dc5-5de70faef77d Variable Datasource name --->
UPDATE changelog1
	SET

	editdate = '#curtimedate#',
	username = '#SESSION.Auth.username#',
	page = '#Self#',
	changelog = '<b>Field Values</b>:<br><CFLOOP INDEX="TheField" list="#Form.FieldNames#">#TheField# = #Evaluate(TheField)#<br></CFLOOP>'	

	WHERE ID = #Query.newid#
<!---TODO_DV_CORP_002_End: 528efe13-78fa-457c-8dc5-5de70faef77d Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>	
</cflock>
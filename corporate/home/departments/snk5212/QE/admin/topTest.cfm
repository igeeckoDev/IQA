<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 1b0e01a4-5ca7-4353-a61d-48f9e8ea41d7 Variable Datasource name --->
SELECT * FROM RH
WHERE RH.filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: 1b0e01a4-5ca7-4353-a61d-48f9e8ea41d7 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 25749cf1-67e0-428c-9adf-7930e79a483d Variable Datasource name --->
SELECT * FROM page_content, RH
WHERE RH.filename = '#url.filename#'
AND page_content.pageID = RH.ID
AND Title = 'Intro Text'
AND page_content.RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #PageID.ID#)
<!---TODO_DV_CORP_002_End: 25749cf1-67e0-428c-9adf-7930e79a483d Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>


<cfdump var="#PageID#">

<cfdump var="#introText#">
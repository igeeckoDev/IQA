<!--- DV_CORP_002 02-APR-09 --->
<cfset pageID.ID = "23">

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 36792fab-78bb-4829-a4f9-60c4f0ac2157 Variable Datasource name --->
SELECT * FROM page_content
WHERE PageID = #PageID.ID#
AND Title = 'Intro Text'
AND RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #PageID.ID#)
<!---TODO_DV_CORP_002_End: 36792fab-78bb-4829-a4f9-60c4f0ac2157 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfdump var="#introText#">
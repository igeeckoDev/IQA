<!--- Start of Page File --->
<cfset subTitle = "IQA Admin - Admin Menu (Original Menu)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/IndexAdminMenu.cfm">

<cflock scope="SESSION" timeout="60">
<cfif SESSION.Auth.AccessLevel eq "superuser"
	OR SESSION.Auth.AccessLevel eq "Admin"
	OR SESSION.Auth.AccessLevel eq "IQAAudtor">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TopicCount"> 
SELECT * 
FROM IQADB_INDEXTOPICS "INDEXTOPICS"
WHERE IndexTopic = 'Index'
</CFQUERY>

<cfset loopcount = TopicCount.recordcount>

<cfloop index="i" from="1" to="#variables.loopcount#">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxrev"> 
SELECT MAX(RevNo) AS MaxRev
FROM IQADB_INDEX  "INDEX"
WHERE INDEXTopicID = #i#
</CFQUERY>

<CFQUERY NAME="Topic" Datasource="Corporate"> 
SELECT IQADB_Index.ID, IQADB_Index.IndexTopicID, IQADB_Index.Index_ as "Index", IQADB_Index.RevNo, 
IQADB_Index.RevAuthor, IQADB_Index.RevDate, IQADB_Index.RevDetails, IQADB_IndexTopics.ID, IQADB_IndexTopics.IndexTopic

FROM 
IQADB_INDEX, IQADB_INDEXTOPICS

WHERE 
IQADB_INDEXTopics.ID = IQADB_Index.IndexTopicID 
AND IQADB_Index.RevNo = #maxrev.MaxRev#
AND IQADB_IndexTopics.ID = #i#
</CFQUERY>

<cfoutput query="Topic">
<u><b>#IndexTopic#</b></u> [Rev #RevNo#, #dateformat(revdate, "mm/dd/yyyy")#]
<cflock scope="session" timeout="5">
	<cfif SESSION.Auth.AccessLevel is "SU">
 - <a href="indexEdit.cfm?ID=#IndexTopicID#&Rev=#RevNo#">edit</a>
	</cfif>
</cflock><Br>
#Index#
</cfoutput>
</cfloop>

</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
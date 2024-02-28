<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TopicCount"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  IQADB_INDEXTOPICS  "INDEXTOPICS" 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfset loopcount = TopicCount.recordcount>

<cfloop index="i" from="1" to="#variables.loopcount#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxrev"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->

SELECT MAX(RevNo) AS MaxRev
 FROM IQADB_INDEX  "INDEX"
 WHERE INDEX_TopicID=#i#

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY NAME="topic" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->

SELECT Index.ID, Index.IndexTopicID,"INDEX".INDEX_ as "Index", Index.RevNo, Index.RevAuthor, Index.RevDate, Index.RevDetails, IndexTopics.ID, IndexTopics.IndexTopic
 FROM IQADB_INDEX  "INDEX",IQADB_INDEXTOPICS  "INDEXTOPICS"
 WHERE INDEX_Topics.ID=Index.IndexTopicID AND  RevNo = #maxrev.MaxRev#
 AND INDEX_Topics.ID=#i#

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="Topic">
#i#<Br>
<u><b>#IndexTopic#</b></u> [Rev #RevNo#, #dateformat(revdate, "mm/dd/yyyy")#] - <a href="indexEdit.cfm?ID=#IndexTopicID#&Rev=#RevNo#">edit</a><Br>
#Index#<br><br>
</cfoutput>
</cfloop>
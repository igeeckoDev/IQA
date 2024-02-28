<CFQUERY Name="Alerts" Datasource="Corporate"> 
SELECT * From  IQADB_ALERTS  "ALERTS" Order BY ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Database - Admin Index">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TopicCount"> 
SELECT * FROM IQADB_INDEXTOPICS "INDEXTOPICS" 
</CFQUERY>

<cfset loopcount = TopicCount.recordcount>

<cfloop index="i" from="1" to="#variables.loopcount#">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxrev"> 
SELECT MAX(RevNo) AS MaxRev
FROM IQADB_INDEX  "INDEX"
WHERE INDEXTopicID = #i#
</CFQUERY>

<CFQUERY NAME="Topic" Datasource="Corporate"> 
SELECT IQADB_Index.ID, IQADB_Index.IndexTopicID, IQADB_Index.Index_ as "Index", IQADB_Index.RevNo, IQADB_Index.RevAuthor, IQADB_Index.RevDate, IQADB_Index.RevDetails, IQADB_IndexTopics.ID, IQADB_IndexTopics.IndexTopic

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
#Index#<br /><br />
</cfoutput>
</cfloop>

<!---
<span class="blog-title">Auditor Alerts</span>
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
		 - <a href="add_alert.cfm">Add Alert</a>
	</cfif><br><br>
</cflock>

<CFOUTPUT QUERY="Alerts">
<CFIF #Alerts.RecordCount# IS "0">
No Alerts Found at this time.
<cfelse>
<img src="../images/ico_article.gif" border="0">
<a href="alerts.cfm?ID=#ID#">#Subject#</a> 
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
		(<a href="edit_alert.cfm?ID=#ID#">edit</a>)
	</cfif>
</cflock><br>
</CFIF>
</CFOUTPUT>
-->
							
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
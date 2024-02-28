<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!---
<cfloop index="i" from="2" to="3">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxrev">
SELECT MAX(RevNo) AS MaxRev
FROM IQADB_INDEX
WHERE INDEXTopicID = #i#
</CFQUERY>

<CFQUERY NAME="topic" Datasource="Corporate">
SELECT IQADB_Index.ID, IQADB_Index.IndexTopicID, IQADB_Index.Index_ as "Index", IQADB_Index.RevNo, IQADB_Index.RevAuthor, IQADB_Index.RevDate, IQADB_Index.RevDetails, IQADB_IndexTopics.ID, IQADB_IndexTopics.IndexTopic

FROM
IQADB_INDEX, IQADB_INDEXTOPICS

WHERE
IQADB_INDEXTopics.ID = IQADB_Index.IndexTopicID
AND IQADB_Index.RevNo = #maxrev.MaxRev#
AND IQADB_IndexTopics.ID = #i#
</CFQUERY>

<cfoutput query="Topic">
<u><b>#IndexTopic#</b></u> [Rev #RevNo#, #dateformat(revdate, "mm/dd/yyyy")#]<Br>
#Index#<br /><br />
</cfoutput>
</cfloop>
--->


<!--- added 7/1/2015--->
<b>Mission and Vision</b><br>
We employ problem and potential improvement identification, analysis,  problem solving, and quality and technical expertise as we partner with UL organizations, teams and external UL stakeholders to promote greater business performance and ultimately increased customer satisfaction and financial results.  This takes the form of audits, corrective actions, improvement projects  and process support.<br><br>

Our vision is to be recognized as a key resource for driving and facilitating continuous improvement efforts, contributing to enhanced processes, in addition to effective and efficient use of our staff.<br><br>

<!---
View: <a href="http://intranet.ul.com/en/Tools/DeptsServs/Quality/_layouts/PowerPoint.aspx?PowerPointView=ReadingView&PresentationId=/en/Tools/DeptsServs/Quality/Documents/Quality%20Engineering%20Roadmap.ppt&Source=http%3A%2F%2Fintranet%2Eul%2Ecom%2Fen%2FTools%2FDeptsServs%2FQuality%2FDocuments%2FForms%2FAllItems%2Easpx&DefaultItemOpen=1" target="_blank">Quality Engineering Roadmap</a><br><br>
--->
<!--- /// --->

<!--- for NON IE browsers --->
<!--[if !(IE)]><!--><hr width="50%" align="center"><br><!--><![endif]-->

<!-- for IE browser --->
<!--[if (IE)]><hr class='dash'><![endif]-->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
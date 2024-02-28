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

<div align="center">
<img src="http://intranet.ul.com/en/Tools/DeptsServs/Quality/PublishingImages/QE%20Logo%20June%2016%202015.png" width="400" border="0" /><br /><br />
</div>

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

<u>Quality Engineering</u>: Corporate Quality staff whose focus is on supporting the creation and deployment of quality systems, processes and tools that meet business requirements and enhance organizational performance and ultimately, customer satisfaction. We assist organizations through involvement with data analysis and problem solving, using our expertise with quality principles and standards, quality system development, and quality improvement techniques and tools.<br /><br />

<u>Auditing</u>: The Corporate Quality Engineering organization has responsibility for conducting audits of internal facilities, processes and programs/schemes as well as responsibility for conducting Data Acceptance Program (DAP) audits of clients submitting data to UL.  Internal audits are conducted globally to provide insight into our operating effectiveness and compliance through the use of internal documentation, regulatory and accreditation requirements. DAP Audits, conducted globally, assess a client’s capability to submit data that may be utilized for the UL Mark certification decisions.<br /><br />

<u>CAPA Support</u>: A Global Corrective Action Process is utilized, supported by CAR Champions who work with CAR Owners to identify root causes and resolutions to issues, many of which may impact our accreditations, diminish our ability to provide optimal service to our customers, or constrain our internal operating effectiveness. Metrics are provided via the GCAR Metrics Website to provide management and process owners with timely trending of key business factors, which in turn expedites the identification of improvement needs.<br /><br />

<u>Process Support</u>: Corporate Quality Engineering Staff participate in process and performance improvement activities such as Green Belt projects, Kaizens and Katas. Staff work with program/process owners to develop Key Performance Indicators to facilitate their ability monitor performance and identify any need for adjustments.<br /><br />

<u>Quality Management System (QMS) Support</u>: Corporate Quality Engineering Staff provide support to newly acquired facilities to facilitate their integration into the Quality aspect of UL. One key way this is done is by identifying compliance strengths as well as providing inputs on opportunities for improvement.<br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
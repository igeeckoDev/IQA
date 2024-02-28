<!--- Start of Page File --->

<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">


A Global Corrective Action Process is utilized, supported by CAR Champions who work with CAR Owners to identify root causes and resolutions to
issues, many of which may impact our accreditations, diminish our ability to provide optimal service to our customers, or constrain our internal
operating effectiveness. <br><br>

For any questions about this site or contents, please contact Cheryl Adams at <a href="mailto:Cheryl.Adams@ul.com">Cheryl.Adams@ul.com</a>.<br><br>

<!---
<cfinclude template="inc_TOP.cfm">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="TopicCount">
SELECT *
FROM CAR_IndexTopics
WHERE IndexTopic = 'Index'
</CFQUERY>

<cfset loopcount = TopicCount.recordcount>

<cfloop index="i" from="1" to="#variables.loopcount#">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxrev">
SELECT MAX(RevNo) AS MaxRev
 FROM CAR_INDEX  "INDEX"
 WHERE INDEXTopicID=#i#
</CFQUERY>

<CFQUERY NAME="topic" DataSource="Corporate">
  SELECT A.ID, A.IndexTopicID,
  A.Index_ AS "Index", A.RevNo, A.RevAuthor,
  A.RevDate, A.RevDetails, B.ID,
  B.IndexTopic
  FROM CAR_INDEX "A",  CAR_INDEXTOPICS "B"
WHERE B.ID = A.IndexTopicID
AND  RevNo = #maxrev.MaxRev#
AND B.ID=#i#
</CFQUERY>

<cfoutput query="Topic">
<u><b>#IndexTopic#</b></u> [Rev #RevNo#, #dateformat(revdate, "mm/dd/yyyy")#]
<cflock scope="Session" timeout="5">
<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
 - <a href="#CARDir_Admin#indexEdit.cfm?ID=#IndexTopicID#&Rev=#RevNo#">edit</a></cfif>
</cflock>
<Br>
<cfset Dump = #replace(Index, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#
</cfoutput>
</cfloop>
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
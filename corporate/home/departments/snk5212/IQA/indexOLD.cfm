<CFQUERY Name="Alerts" Datasource="Corporate">
SELECT * From 
IQADB_ALERTS "ALERTS" 
Order BY ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Database">
<cfinclude template="SOP_Index.cfm">

<!--- / --->
<br /><br />						  

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TopicCount">
SELECT * FROM  
IQADB_INDEXTOPICS "INDEXTOPICS"
</CFQUERY>

<cfset loopcount = TopicCount.recordcount>
<cfloop index="i" from="1" to="#variables.loopcount#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxrev">
SELECT MAX(RevNo) AS MaxRev
FROM IQADB_INDEX "INDEX"
WHERE INDEXTopicID=#i#
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
#Index#
<cfif i neq #variables.loopcount#>
	<br /><br />
</cfif>
</cfoutput>
</cfloop>
						  </td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr>
                          <td width="3%" align="right"><p>&nbsp;</p></td>
						<tr>
                          <td class="article-end" colspan="3" valign="top" align="right">&nbsp;</td>
                        </tr>
						<tr>
                          <td width="3%" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-content"><br />

<script language="JavaScript" src="webhelp/webhelp.js"></script>

<cfoutput>
<span class="blog-content"><b>Main Menu</b></span><br>

<table border="0">
<tr class="blog-content">
<td width="300" valign="top">
:: <a href="index.cfm">Main</a><br>
:: <a href="../GCARMetrics/"><b>GCAR Metrics</b></a><br>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&auditor=All">Audit Schedule</a><br>
:: <a href="Audit_List2.cfm?Year=#curyear#&type=all">Yearly List of Audits</a><br>
:: <a href="AuditNumber.cfm">Audit Lookup</a> (by Audit Number)<br>
:: <a href="Aprofiles.cfm">Auditor List</a><br>
:: <a href="FAQ.cfm">IQA FAQ</a><br>
:: <a href="metrics_region.cfm">Metrics</a><br>
:: <a href="CARFiles.cfm?Category=Plans">IQA Audit Plans</a><br>
<!--- 1/12/2009 :: <a href="TPTDP.cfm">TPTDP Certificates</a><br>--->
:: <a href="audit_req.cfm">Request an Audit</a><br>
:: <a href="KBindex.cfm">IQA / CAR Process Knowledge Base</a><br>
:: <a href="getEmpNo.cfm?page=auditor_req">Request to be an Auditor</a><br>
:: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
:: <a href="AuditCoverage.cfm?year=#curyear#">IQA Audit Coverage</a><br>
:: <A HREF="javascript:popUp('webhelp/webhelp.cfm')">IQA Web Help</a><br><br>
</td>

<td valign="top">
:: <u>Audit Calendar Views</u><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=All">All Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=IQA">IQA Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="select_site.cfm">Site/Regional Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=LAB">Laboratory Technical Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=Finance">Corporate Finance Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=FS&type2=FS">Field Service Regional Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=FS&type2=All">All Field Service Audits</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; (includes IQA Field Service Audits)<br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=Accred&type2=AS">Accreditation Services (AS) Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=Accred&type2=Non">External Accreditation (non-AS) Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=Accred&type2=All">All External Accreditation Audits</a><br>
<!---&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=TP">Third Party Test Data Program (TPTDP)</a><br>--->
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=CBTL">CBTL Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="calendar.cfm?type=QRS">QRS Internal Audits</a><br>
&nbsp; &nbsp; &nbsp; - <a href="select_auditor.cfm?page=calendar">View By Auditor</a> (Internal Audits Only)<br>
</td>
</tr>
</table>
</cfoutput>
<br><br>

<cfif Alerts.recordcount is "0">
<cfelse>
<b>Auditor Alerts</b><br>
<CFOUTPUT QUERY="Alerts">
<img src="images/ico_article.gif" border="0">
<a href="alerts.cfm?ID=#ID#">#Subject#</a><br>
</CFOUTPUT>
<br>
</CFIF>

<!--- message was removed on 10/1/2009 --->
<cfif curyear lt 2009 OR curyear eq 2009 AND curmonth lt 10>
-------------<br /><Br />

* Note: For information on TPTDP Audits after 2007, please contact <a href="mailto:Bruce.R.Proper@ul.com">Bruce Proper</a>.<br /><br />Information about 2004-2007 TPTDP Audits, Scope Letters, Reports, and TPTDP Client Report Cards is still available on this site via the Schedule and Calendar views. However, all other information (TPTDP Client List, contact information, report card application) has been archived. (This message will expire on January 1, 2010)<br /><br />

Please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher Nicastro</a> for any other information.
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
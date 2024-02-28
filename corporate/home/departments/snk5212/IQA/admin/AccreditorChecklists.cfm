<!--- Start of Page File --->
<cfset subTitle = "IQA Admin - Accreditor Checklists">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Links" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
SELECT Title, Content
FROM IQA_AccreditorChecklists
ORDER BY Title
</CFQUERY>

<cfoutput query="Links">
<b>#Title#</b><br />
#Content#<br /><br />
</cfoutput>

<b>SCC Requirements and Guidance</b><br>
Certification Bodies - Product, Process, and Service - <a href="https://www.scc.ca/en/accreditation/product-process-and-service-certification">https://www.scc.ca/en/accreditation/product-process-and-service-certification</a><br>
Inspection Bodies - <a href="https://www.scc.ca/accreditation/inspection-bodies">https://www.scc.ca/accreditation/inspection-bodies</a><br><br>

<b>IAS AC89 - Accreditation Criteria for Testing Laboratories</b><br>
<a href="https://www.iasonline.org/resources/accreditation-criteria-for-testing-laboratories-ac89/">https://www.iasonline.org/resources/accreditation-criteria-for-testing-laboratories-ac89/</a><br><br>

<b>IAS Rules of Procedure for Testing Laboratory Accreditation</b> (January 1 2016)<br>
<a href="https://www.iasonline.org/wp-content/uploads/2017/04/002-Rules-of-Procedure-for-Testing-Laboratory-Accreditation.pdf">https://www.iasonline.org/wp-content/uploads/2017/04/002-Rules-of-Procedure-for-Testing-Laboratory-Accreditation.pdf</a><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
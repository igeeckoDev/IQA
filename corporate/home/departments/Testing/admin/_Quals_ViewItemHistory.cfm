<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="View Corporate IQA Auditor Qualification Item Rev History">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Qual" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	UL06046.AuditorQualification.ID, UL06046.AuditorQualification.aID, UL06046.AuditorQualification.qID, 
UL06046.AuditorQualification.qValue, UL06046.AuditorQualification.qDate, UL06046.Qualification.QualificationName, 
UL06046.AuditorQualification.Notes, UL06046.AuditorQualification.qHistory, Corporate.AuditorList.Auditor

FROM 
	UL06046.AuditorQualification, UL06046.Qualification, Corporate.AuditorList

WHERE 
	UL06046.AuditorQualification.ID = #URL.ID#
AND UL06046.AuditorQualification.qID = UL06046.Qualification.ID
AND UL06046.AuditorQualification.aID = Corporate.AuditorList.ID
</CFQUERY>

<cfoutput query="Qual">
<b>#Auditor# / #QualificationName#</b><br />
<u>Value</u>: <cfif qValue eq 1>Yes<cfelseif qValue eq 0>No</cfif><br />
<u>Qualification Date</u>: #qDate#<br />
<u>Notes</u>: #Notes#<br /><br />

<u>Rev History</u>:<Br>
#qHistory#
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
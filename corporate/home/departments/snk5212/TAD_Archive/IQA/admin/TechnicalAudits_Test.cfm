<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Testing">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<b>Admin Menu</b><br /><Br />

<u>List Control</u><br />
:: <a href="TechnicalAudits_AccessControl.cfm">Technical Audit Manager Account Control</a><br />
:: <a href="Standard.cfm">Standard List Control</a><br />
:: <a href="TechnicalAudits_DocumentLinks.cfm">Audit Report Document Links Control</a><br />
:: <a href="TechnicalAudits_TAM.cfm">Deputy Technical Audit Manager Control</a><br />
:: <a href="TechnicalAudits_ROM.cfm">Regional Operations Manager Control</a><br />
:: <a href="TechnicalAudits_SQM.cfm">Site Quality Manager Control</a><br /><br />

<u>Reporting</u><br />
:: <a href="TechnicalAudits_Reporting.cfm">Reporting - Category, Item, SubItem Structure</a><br /><br />

<u>Audit Related</u><br />
:: View Audits - 
<a href="TechnicalAudits_ViewAudits2.cfm?Type=Full&Year=#curyear#&unit=1&Notes=Hide">Full</a> :: <a href="TechnicalAudits_ViewAudits2.cfm?Type=In-Process&Year=#curyear#&unit=1&Notes=Hide">In-Process</a><br />
:: Add Audit - <a href="TechnicalAudits_AddAudit1.cfm?Type=Full">Full</a> :: <a href="TechnicalAudits_AddAudit1.cfm?Type=In-Process">In-Process</a><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->

<!---
:: <a href="CCN.cfm">CCN List Control</a><br />
:: <a href="Industry.cfm">Industry List Control</a><br />
:: <a href="Auditors.cfm?Type=TechnicalAudit">Technical Audits - Auditor Control</a><br />
:: <a href="TechnicalAudits_Category.cfm">Report Category Control</a><br />
:: <a href="TechnicalAudits_Item.cfm">Report Item Control</a><br />
:: <a href="TechnicalAudits_SubItem.cfm">Report SubItem Control</a><br />

:: View Audits (simple, for testing) - 
<a href="TechnicalAudits_ViewAudits.cfm?Type=Full&Year=#curyear#&unit=1">Full</a> :: <a href="TechnicalAudits_ViewAudits.cfm?Type=In-Process&Year=#curyear#&unit=1">In-Process</a><br />

:: <a href="TechnicalAudits_AddNC_SelectCategory.cfm?ID=4&Year=2012">Add NCs from Audit</a><Br /><br />
--->
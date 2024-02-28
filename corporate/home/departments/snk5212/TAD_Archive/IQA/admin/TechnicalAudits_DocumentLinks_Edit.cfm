<CFQUERY Name="DocumentLink" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Links
WHERE Label = '#URL.Label#'
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Audit Report - Edit Document Names/Links">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="DocumentLink">
<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="TechnicalAudits_DocumentLinks_Edit_Update.cfm?Label=#URL.Label#">

Document Name and Number:<br>
<b>#HTTPLinkName#</b><Br><br>

<input name="HTTPLinkName" type="text" value="#HTTPLinkName#" size="70">
<br><br>

Document Link:<br>
<b>#HTTPLink#</b><br><br>

<input name="HTTPLink" type="Text" size="70" value="#HTTPLink#">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</CFform>
</CFOUTPUT>
				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audit - Confirm Remove Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * 
    FROM TechnicalAudits_AuditSchedule
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

Remove Audit Help - <A HREF="javascript:popUp('../webhelp/webhelp_remove.cfm')">[?]</A><br /><br />

<cfoutput query="Audit">					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TechnicalAudits_Remove_Submit.cfm?ID=#ID#&Year=#Year_#">

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

Do you wish to Remove Audit #varAuditIdentifier# / #year_#-#id#-Technical Audit?<br><br>

<u>Removal Notes</u>:<br>
#form.e_Notes#<br><br>
<input type="hidden" value="#form.e_notes#" name="notes">

<INPUT TYPE="Submit" name="Remove" Value="Confirm Request">
<INPUT TYPE="Submit" name="Remove" Value="Cancel Request">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
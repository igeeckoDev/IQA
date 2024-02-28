<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "Admin"
	or SESSION.Auth.accesslevel is "SU"
	or SESSION.Auth.Accesslevel is "QRS"
	or SESSION.Auth.AccessLevel is "IQAAuditor"
	or SESSION.Auth.AccessLevel is "Auditor">

<cfquery Datasource="Corporate" name="Region">
SELECT IQARegion.*, IQASubRegion.*, IQAtblOffices.*, IQAtblOffices.ID AS "OfficeNameID"
FROM IQARegion, IQASubRegion, IQAtblOffices
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = IQASubRegion.Region
AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
AND OfficeName <> 'test location'
AND SuperLocation = 'No'
ORDER BY IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>

<CFelseIF SESSION.Auth.accesslevel is "Europe"
	or SESSION.Auth.accesslevel is "Asia Pacific"
	or SESSION.Auth.accesslevel is "RQM">

<cfquery Datasource="Corporate" name="Region">
SELECT IQARegion.*, IQASubRegion.*, IQAtblOffices.*, IQAtblOffices.ID AS "OfficeNameID"
FROM IQARegion, IQASubRegion, IQAtblOffices
WHERE IQASubRegion.SubRegion <> 'None'
AND IQASubRegion.SubRegion = '#Session.Auth.SubRegion#'
AND IQARegion.Region = IQASubRegion.Region
AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
AND OfficeName <> 'test location'
ORDER BY IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>

<cfelse>
</cfif>
</cflock>

<div align="Left" class="blog-time">
Audit Notification Help - <A HREF="javascript:popUp('../webhelp/webhelp_notifications.cfm')">[?]</A><br>
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A><br>
</div><br>

<cfif SESSION.Auth.AccessLevel eq "Admin"
	OR SESSION.Auth.AccessLevel eq "superuser">
	
	<a href="UL_Locations_Add.cfm">Add</a> UL Location or Certification Body<br>
</cfif>

<a href="CertificationBodies_Schemes.cfm">View</a> Certification Bodies and associated Schemes</a><br>

<cfif SESSION.Auth.AccessLevel eq "Field Services"
	OR SESSION.Auth.AccessLevel eq "Admin"
	OR SESSION.Auth.AccessLevel eq "superuser">
	<a href="fus2.cfm">View</a> UL Inspection Center Locations<br>
	<a href="VS.cfm">View</a> Verification Services (VS) Test Labs - legacy - not used<br />
	<a href="ULE.cfm">View</a> UL Environment (ULE) Sites - legacy - not used<br />
</cfif>

<!---
	<a href="contacts_new.cfm">View</a> All Audit Notification Contacts (All Offices)<br />
--->

<a href="SNAP.cfm">View</a> OSHA SNAP / SCC / UL Location Matrix<br>
<a href="IC.cfm">View</a> International Certification Form Control (IQA only)<br>
<br />

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfif curyear gte 2006 AND curyear lte 2008>
	<cfset StartYear = 2006>
<cfelseif curyear gte 2009 AND curyear lte 2011>
	<cfset StartYear = 2009>
<cfelseif curyear gte 2012 AND curyear lte 2014>
	<cfset StartYear = 2012>
</cfif>

<cfoutput>
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.AccessLevel is "SU"
		OR SESSION.Auth.AccessLevel is "Admin"
		OR SESSION.Auth.AccessLevel is "IQAAuditor">
	<cfset AuditedBy = "IQA">
	<cfelse>
	<cfset AuditedBy = #SESSION.Auth.SubRegion#>
	</cfif>
</cflock>
</cfoutput>

<cfset RegHolder="">
<cfset SubRegHolder="">

<CFOUTPUT Query="Region">
<cfif region is NOT "Field Services">
<cfif RegHolder IS NOT Region>
<cfIf RegHolder is NOT ""><br></cfif>
<b><u>#Region#</u></b><br>
</cfif>
<cfif SubRegHolder IS NOT SubRegion>
<cfIf SubRegHolder is NOT ""><br></cfif>
<b>&nbsp;&nbsp;#SubRegion#</b><br>
</cfif>
&nbsp;&nbsp;&nbsp; - <a href="Office_Details.cfm?ID=#OfficeNameID#">#OfficeName#</a> <cfif Exist eq "No"><font class=warning><b>Inactive Location</b></font></cfif>
	<!---
	[<a href="audit_coverage.cfm?OfficeName=#OfficeName#&Year=#StartYear#&AuditedBy=#AuditedBy#">Coverage</a>] [<a href="contacts.cfm?ID=#OfficeNameID#">Contacts</a>]
	<cflock scope="SESSION" timeout="60">
		<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
		[<a href="labs.cfm?OfficeName=#OfficeNameID#">Labs</a>]
		<cfelse>
		</cfif>
	</cflock>
	[<a href="Audit_Plan.cfm?OfficeName=#OfficeName#&Start=#StartYear#&AuditedBy=#AuditedBy#">Plan</a>]
	[<a href="Snap_Details.cfm?ID=#OfficeNameID#">SNAP</a>]
	--->
<br>
<cfset RegHolder = Region>
<cfset SubRegHolder = SubRegion>
</cfif>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
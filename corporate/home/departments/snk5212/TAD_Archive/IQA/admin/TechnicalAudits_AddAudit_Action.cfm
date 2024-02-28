<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Add Audit Action">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="maxID" Datasource="Corporate">
SELECT MAX(ID)+1 as newID
FROM AuditSchedule
WHERE Year_ = '#Form.Year#'
</CFQUERY>

<cfoutput>
<B>#Form.Year#-#maxID.newID#-#Form.AuditedBy#</B>
<br><br>

<b>Available Actions</b><br>
 :: Assign Auditor<br>
 :: Add Roles (PDE, RLR, Engineering Manager/Director)<br>
 :: File Report<br><br> 
 
<b>Status</b><br>
Audit Scheduled - Awaiting Auditor Assignment<br><br>

<b>Month Scheduled</b><br>
#MonthAsString(Form.Month)#
<br><br>

<b>Audit Due Date</b><br>
#dateformat(Form.StartDate, "mmmm dd, yyyy")#
<br><br>

<b>Technical Audit Number/Identifier</b><br>
#Form.TechAuditNumber#
<br><br>

<b>Auditor</b><br>
<cfif len(Form.Auditor)>
#Auditor#
<cfelse>
Auditor not assigned
</cfif>
<br><br>

<b>Audit Type</b><br>
#Form.AuditType2#
<br><br>

<b>Office Name</b><Br>
#Form.OfficeName#
<br><br>

<b>Project Number</b><Br>
#Form.ProjectNumber#
<br><br>

<b>File Number</b><Br>
#Form.FileNumber#
<br><br>

<b>Standard</b><Br>
#Form.Standard#
<br><br>

<b>Industry</b><Br>
#Form.Industry#
<br><br>

<b>Program</b><Br>
#Form.Program#
<br><br>

<b>Notes</b><Br>
#Form.Notes#<br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
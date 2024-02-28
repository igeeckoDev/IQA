<cfif NOT isDefined("url.list")>
	<cfset url.list = "All">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="IQA Audited Programs - Coverage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif NOT isDefined("URL.List")>
	<cfset url.list = "All">
<cfelseif NOT len(url.list)>
	<cfset url.list = "All">
</cfif>

<cfquery Datasource="Corporate" name="ProgList"> 
SELECT POEmail, PMEmail, SEmail, Manual, GuideRef, CPO, CPCMR, Silver, IQA, Region, LocOwner, ProgOwner, Specialist, Manager, Comments, Status, EndDate, StartDate, ID, Program, Parent, Type, DECODE(Parent,NULL, ID, Parent) as Anc

FROM ProgDev

	<cfif url.list is "CPO">
	WHERE CPO = 1 AND
	<cfelseif url.list is "CPCMR">
	WHERE CPCMR = 1 AND
	<cfelseif url.list is "Silver">
	WHERE Silver = 1 AND
	<cfelseif url.list is "IQA">
	WHERE IQA = 1 AND
	<cfelseif url.list is "removed">
	WHERE status = 'removed'
	<cfelseif url.list is "All">
	WHERE
	</cfif>

<cfif url.list is NOT "removed">
	(Status IS NULL OR Status = 'Pending' OR Status = 'Under Review')
</cfif>

ORDER BY Region, DECODE(Parent,NULL, ID, Parent), Type DESC
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgList_w"> 
SELECT * from ProgDev

	<cfif url.list is "CPO">
	WHERE CPO = 1 AND
	<cfelseif url.list is "CPCMR">
	WHERE CPCMR = 1 AND
	<cfelseif url.list is "Silver">
	WHERE Silver = 1 AND
	<cfelseif url.list is "IQA">
	WHERE IQA = 1 AND
	<cfelseif url.list is "All">
	WHERE
	</cfif>

Status = 'Withdrawn'
ORDER BY Region, Program
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgList_r"> 
SELECT * from ProgDev
WHERE Status = 'removed'
ORDER BY ID
</CFQUERY>

Currently Viewing:
<cfif url.list is "CPO">
<b>CPO Programs</b> (Certification Programs Office)
<cfelseif url.list is "CPCMR">
<b>CPC Programs</b> (Certification Programs Countil)
<cfelseif url.list is "Silver">
<b>Silver/Bronze Programs</b>
<cfelseif url.list is "IQA">
<b>Programs Audited by IQA</b>
<cfelseif url.list is "All">
<b>All Programs (CPO, CPC, Silver/Bronze)</b>
<cfelseif url.list is "Removed">
<b>Removed Programs</b>
</cfif><br><br>

Note - Please contact <a href="mailto:David.Magri@ul.com">David Magri</a> for any questions, concerns, or comments with the UL Programs Master List.<br><br>

<b>Legend:</b><br>
<img src="../images/ico_article.gif" border="0"> - View Program Information<br><br>

<table border="1" width="785">
<tr>
<td valign="top" class="blog-title" align="center" width="55">Region</td>
<td valign="top" class="blog-title" align="center" width="200">Program</td>
<td valign="top" class="blog-title" align="center" width="55">Type</td>
<cfloop index="i" from="2009" to="#curYear#">
	<td valign="top" class="blog-title" align="center" width="100"><Cfoutput>#i#</Cfoutput><br>Audit</td>
</cfloop>
</tr>
<cfoutput query="ProgList">
	<cfif Status is "Withdrawn" AND EndDate lte #curdate#>
	<cfelseif program is "_test">
	<cfelse>
<Tr>
<td class="blog-content" align="center">#trim(Region)#&nbsp;</td>
<td class="blog-content">#Program# 
	<cfif Status is "Under Review">
    	(Under Review)
	<cfelseif Status is "Pending">
    	(Pending)</cfif> 
    <a href="_prog_detail.cfm?progid=#ID#" title="View and Edit Program Information">
    	<img src="../images/ico_article.gif" border="0">
    </a>
</td>
<td class="blog-content" align="center">#Type#&nbsp;</td>

<cfloop index="i" from="2009" to="#curYear#">
    <td class="blog-content" align="center">
        <cfquery Datasource="Corporate" name="Audit"> 
        SELECT Year_, ID FROM AuditSchedule
        WHERE Area = '#Program#'
        AND AuditedBy = 'IQA'
        AND Status IS NULL
        AND Year_ = #i#
        </cfquery>
        
        <cfif Audit.RecordCount gt 0>
            <cfloop query="Audit">
            <a href="auditdetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#</a><br />
            </cfloop>
        <cfelse>
        --
        </cfif>
    </td>
</cfloop>
</tr>
	</cfif>
</cfoutput>
</table><br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
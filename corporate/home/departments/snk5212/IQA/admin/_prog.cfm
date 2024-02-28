<!---
<cfif NOT isDefined("url.list")>
	<cfset url.list = "All">
</cfif>
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="UL Programs Master List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

11/17/2015:<Br>
<b>The Programs Master list has moved and been renamed Services Master List.</b><Br><br>

The new Services Master List can be found here: <a href="https://ul.sharepoint.com/sites/cp/CPOAccred/Lists/Services%20Master%20List/AllItems.aspx">CPO &amp; Accreditations Website: Services Master List</a><br><br>

To view programs audited by IQA, you can filter the page using the "IQA" field.<br><br>

Please contact <a href="mailto:David.Magri@ul.com">David Magri</a> for any questions.<br><br>

This page is for AUDITOR REFERENCE ONLY.<br><br>

<cfif NOT isDefined("URL.List")>
	<cfset url.list = "All">
<cfelseif NOT len(url.list)>
	<cfset url.list = "All">
</cfif>

<cfquery Datasource="Corporate" name="ProgList">
SELECT COwner, POEmail, PMEmail, SEmail, Manual, GuideRef, CPO, CPCMR, Silver, IQA, Region, LocOwner, ProgOwner, Specialist, Manager, Comments, Status, EndDate, StartDate, ID, Program, Parent, Type, DECODE(Parent,NULL, ID, Parent) as Anc

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
	<cfelseif url.list is "All" OR url.list is "removed">
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
<b>All Programs (CPO, CPC, Silver/Bronze, Programs Audited by IQA)</b>
<cfelseif url.list is "Removed">
<b>Removed Programs</b>
</cfif><br><br>

Note - Please contact <a href="mailto:David.Magri@ul.com">David Magri</a> for any questions, concerns, or comments with the UL Programs Master List.<br><br>

* Technical Responsibilities for the below programs are managed by the PDE organization<br>
* Factory Inspection elements of all programs are Program Managed by the Global Inspection and Field Services Department.<br><br>

<b>Legend:</b><br>
<img src="../images/ico_article.gif" border="0"> - View Program Details and Information<br><br>

<cflock scope="session" timeout="10">
	<cfif session.auth.accesslevel is "CPO" OR session.auth.accesslevel is "Admin" OR session.auth.accesslevel is "SU">
	 [<b><a href="_prog_add.cfm">Add</a> Program]</b><br><br>
	</cfif>
</cflock>

<table width="1200" border="1">
<tr>
<td valign="top" class="blog-title" align="center" width="55">Region</td>
<td valign="top" class="blog-title" align="center" width="290">Program</td>
<td valign="top" class="blog-title" align="center" width="55">Type</td>
<td valign="top" class="blog-title" align="center" width="75">Program Owner</td>
<td valign="top" class="blog-title" align="center" width="75">Program Manager</td>
<td valign="top" class="blog-title" align="center" width="75">Program Specialist</td>
<td valign="top" class="blog-title" align="center" width="55">Owner</td>
<td valign="top" class="blog-title" align="center" width="200">Comments</td>
<td valign="top" class="blog-title" align="center">CPO</td>
<td valign="top" class="blog-title" align="center">CPC</td>
<td valign="top" class="blog-title" align="center">S/B</td>
<td valign="top" class="blog-title" align="center">IQA</td>
<td valign="top" class="blog-title" align="center">Guide<br>Ref</td>
</tr>
<cfoutput query="ProgList">
	<cfif Status is "Withdrawn" AND EndDate lte #curdate#>
	<cfelseif program is "_test">
	<cfelse>
<Tr>
<td class="blog-content" align="center">#trim(Region)#&nbsp;</td>
<td class="blog-content">#Program# <cfif Status is "Under Review">(Under Review)<cfelseif Status is "Pending">(Pending)</cfif> <a href="_prog_detail.cfm?progid=#ID#" title="View and Edit Program Information"><img src="../images/ico_article.gif" border="0"></a></td>
<td class="blog-content" align="center">#Type#&nbsp;</td>
<td class="blog-content" align="center">
	<cfif progowner neq "-">
		<a href="mailto:#POEmail#?Subject=Programs Master List - #Program#">#ProgOwner#</a>
	<cfelse>
		-
	</cfif>
</td>
<td class="blog-content" align="center">
	<cfif manager neq "-">
		<a href="mailto:#PMEmail#?Subject=Programs Master List - #Program#">#Manager#</a>
	<cfelse>
		-
	</cfif>
</td>
<td class="blog-content" align="center">
	<cfif Type is "Ancillary" OR len(Specialist)>
		<a href="mailto:#SEmail#?Subject=Programs Master List - #Program#">#Specialist#</a>
	<cfelse>
		-
	</cfif>
</td>
<td class="blog-content" align="center">#LocOwner#&nbsp;</td>
<td class="blog-content" align="center">#Comments#&nbsp;</td>
<td class="blog-content" align="center"><cfif CPO is "1">x<Cfelse>--</cfif></td>
<td class="blog-content" align="center"><cfif CPCMR is "1">x<Cfelse>--</cfif></td>
<td class="blog-content" align="center"><cfif Silver is "1">x<Cfelse>--</cfif></td>
<td class="blog-content" align="center"><cfif IQA is "1">x<Cfelse>--</cfif></td>
<td class="blog-content" align="center">#GuideRef#&nbsp;</td>
</tr>
	</cfif>
</cfoutput>
</table><br><br>

<cfif url.list is NOT "Removed">
<table width="950" border="1">
<tr>
<td class="blog-title" align="left" colspan="7">Withdrawn Programs</td>
</tr>
<tr>
<td valign="top" class="blog-title" align="center" width="55">
<!---<a href="_prog.cfm?list=#url.list#&order=Region&sort=asc">--->Region/Owner</a></td>
<td valign="top" class="blog-title" align="center" width="300">Program</a></td>
<td valign="top" class="blog-title" align="center" width="55">Type</a></td>
<td valign="top" class="blog-title" align="center" width="75">Program Owner</a></td>
<td valign="top" class="blog-title" align="center" width="75">Program Manager</a></td>
<td valign="top" class="blog-title" align="center" width="75">Program Specialist</a></td>
<td valign="top" class="blog-title" align="center" width="200">Withdrawn</td>
</tr>
<cfoutput query="ProgList_w">
	<cfif Status is "Withdrawn" AND EndDate lte #curdate#>
<Tr>
<td class="blog-content" align="center">#Region# - #LocOwner#&nbsp;</td>
<td class="blog-content">#Program# <a href="_prog_detail.cfm?progid=#ID#" title="View and Edit Program Information"><img src="../images/ico_article.gif" border="0"></a></td>
<td class="blog-content" align="center">#Type#&nbsp;</td>
<td class="blog-content" align="center">
	<cfif progowner neq "-">
		<a href="mailto:#POEmail#?Subject=Programs Master List - #Program#">#ProgOwner#</a>
	<cfelse>
		-
	</cfif>
</td>
<td class="blog-content" align="center">
	<cfif manager neq "-">
		<a href="mailto:#PMEmail#?Subject=Programs Master List - #Program#">#Manager#</a>
	<cfelse>
		-
	</cfif>
</td>
<td class="blog-content" align="center">
	<cfif Type is "Ancillary" OR len(Specialist)>
		<a href="mailto:#SEmail#?Subject=Programs Master List - #Program#">#Specialist#</a>
	<cfelse>
		-
	</cfif>
</td>
<td class="blog-content" align="center">#dateformat(EndDate, 'mmmm dd, yyyy')#&nbsp;</td>
</tr>
	</cfif>
</cfoutput>
</table><br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
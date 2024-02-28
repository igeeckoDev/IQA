<!--- DV_CORP_002 02-APR-09 --->
<cfquery datasource="Corporate" name="ProgList"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 7a99ed61-6d0c-4bbb-9551-d8f0478e5cfd Variable Datasource name --->
SELECT * from Programs
	<cfif url.list is NOT "">
		<cfif url.list is "CPO">
		WHERE CPO = 1
		<cfelseif url.list is "CPCMR">
		WHERE CPCMR = 1
		<cfelseif url.list is "Silver">
		WHERE Silver = 1
		<cfelseif url.list is "IQA">
		WHERE IQA = 1
		<cfelseif url.list is "All">
		</cfif>
	</cfif>
	<cfif url.order is NOT "">
	ORDER BY #URL.ORDER#, Program 
		<cfif url.sort is "desc">
		DESC
		</cfif>
	<cfelse>
	ORDER BY Program
	</cfif>
<!---TODO_DV_CORP_002_End: 7a99ed61-6d0c-4bbb-9551-d8f0478e5cfd Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cfoutput>
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<table width="750" border="0">
<Tr>
<td colspan="7" class="blog-content">
<cfif url.list is "CPO">
<b>CPO - UL Programs Master List</b>
<cfelseif url.list is "CPCMR">
<b>CPO - UL Programs CPC-MR List</b>
<cfelseif url.list is "Silver">
<b>CPO - UL Programs Silver List</b>
<cfelseif url.list is "IQA">
<b>IQA Program List</b>
<cfelseif url.list is "All">
<b>All Programs (IQA+CPO)</b>
</cfif><br><br>

</td>
</tr>
</table>

<table width="750" border="1">
<tr>
<cfoutput>
<td valign="top" class="blog-content" align="center" width="75">
<a href="prog.cfm?list=#url.list#&order=Region&sort=asc">Region</a></td>
<td valign="top" class="blog-content" align="center" width="200">
<a href="prog.cfm?list=#url.list#&order=Program&sort=asc">Program</a></td>
<td valign="top" class="blog-content" align="center" width="95">
<a href="prog.cfm?list=#url.list#&order=ProgOwner&sort=asc">Program Owner</a></td>
<td valign="top" class="blog-content" align="center" width="75">
<a href="prog.cfm?list=#url.list#&order=Type&sort=asc">Type</a></td>
<td valign="top" class="blog-content" align="center" width="95">
<a href="prog.cfm?list=#url.list#&order=Manager&sort=asc">Program Manager</a></td>
<td valign="top" class="blog-content" align="center" width="40">
<a href="prog.cfm?list=#url.list#&order=LocOwner&sort=asc">Owner</a></td>
<td valign="top" class="blog-content" align="center" width="170">Comment</td>
</cfoutput>
</tr>
<cfoutput query="ProgList">
<Tr>
<td class="blog-content" align="center">#Region#&nbsp;</td>
<td class="blog-content">#Program# <a href="prog_detail.cfm?progID=#ID#"><img src="../images/ico_article.gif" border="0"></a></td>
<td class="blog-content" align="center">#ProgOwner#&nbsp;</td>
<td class="blog-content" align="center">#Type#&nbsp;</td>
<td class="blog-content" align="center">#Manager#&nbsp;</td>
<td class="blog-content" align="center">#LocOwner#&nbsp;</td>
<td class="blog-content" align="center">#Comments#&nbsp;</td>
</tr>
</cfoutput>
</table>
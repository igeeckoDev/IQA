<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditPlanning.cfm?Year=#URL.Year#'>Audit Planning</a> - #URL.Year# - Mark as Publish">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="Session" timeout="10">
	<cfform action="AuditPlanning_markAsPublished_Action.cfm?Year=#URL.Year#&Action=Ready">
	Are you are you want to set the <cfoutput>#URL.Year#</cfoutput> Planning Matrix to 'Mark as Published'?<br><br>

	No further edits will be possible.<br><br>

	Yes <cfinput
			type="checkbox"
			name="YesNoItem"
			value="Yes"
			required="yes"
			message="Please select Yes if you want to set the Planning Matrix to 'Published'. If not, please press back or follow the link back to the Audit Planning Matrix." /><Br><br>

	<cfinput type="hidden" name="PublishDate" value="#curDate#">
	<cfinput type="hidden" name="PublishStatus" value="Yes">
	<cfinput type="hidden" name="PublishUser" value="#SESSION.Auth.Name#">

	<cfinput type="Submit" name="upload" value="Set #URL.Year# as Published">
	</cfform>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
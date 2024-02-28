<cfif URL.ID EQ 12>
	<cflocation url="admin/CARSource_View.cfm" addtoken="No">
<cfelseif URL.ID EQ 26>
	<cflocation url="admin/RootCause_Add.cfm" addtoken="No">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "FAQ Attachments">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="faqView" datasource="Corporate" blockfactor="100"> 
SELECT * FROM CAR_FAQ "FAQ" 
WHERE ID = #url.id#
</cfquery>

<cfoutput query="faqView">
Attachment for FAQ Question #ID#<br><br>
<B>Question</B><br>
#Question#<br><br>

<b>Answer</b><br>
#Content#<br>
</cfoutput>

<cfif URL.ID NEQ 14>
	<cfinclude template="FAQ#URL.ID#.cfm">
<cfelse>
	This table is not editable in this fashion. Please contact Chris Nicastro to discuss changes to the Standard Category Matrix.<br /><br />
	<cfinclude template="#IQARootDir#matrix.cfm">
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->
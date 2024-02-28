<!--- Start of Page File --->
<cfset subTitle = "Frequently Asked Questions (FAQ) - Revision History Log">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b><u>FAQ Revision History</u></b><br>
<u>FAQ v1</u> Released July 29, 2008 (Initial Release)<br>
<u>FAQ v2</u> Released - March 9, 2015 (New Design)<br>
 :: All FAQ items have been revised on March 9, 2015. The revisions include formatting updates as well as some revisions to the FAQ text.<br><br>

<cfquery Datasource="Corporate" name="RH">
SELECT * from CAR_FAQ_RH
ORDER BY FAQID, RevNo
</CFQUERY>

<br>
<cfset FAQItem = "">
<cfoutput query="RH">
<cfif FAQItem IS NOT FAQID>
<cfIf FAQItem is NOT ""><br>--------<br><br></cfif>
<b><u>FAQ Item #FAQID#</u></b><br>
<cfelse>
<br>
</cfif>
<b>Revision Number</b> #RevNo#<br>
<u>Revision Date</u> #DateFormat(RevDate, 'mmmm dd, yyyy')#<br>
<u>Revision Author</u> #RevAuthor#<br />
<u>Details</u><br>
#RevComments#<br>
<cfset FAQItem = FAQID>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
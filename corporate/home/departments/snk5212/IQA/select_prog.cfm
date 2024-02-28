<cfquery Datasource="Corporate" name="ProgList"> 
SELECT * from ProgDev
WHERE IQA = 1
ORDER BY Program
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Calendar - Select Program">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b><u>IQA Program List</u></b><br><br>

<cfoutput query="ProgList">
 - <a href="calendar.cfm?type=program&type2=#program#">#Program#</a><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset title = "CAR Administrator Responsibility List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY DataSource="Corporate" Name="Files"> 
SELECT * FROM CARResponsibility
ORDER BY ID
</CFQUERY>

<u>Revision History</u><br>
<cfoutput query="files">
ID - #ID#<br>
Date - #dateformat(uploaded, "mm/dd/yyyy")#<br>
Comments - #Comments#<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
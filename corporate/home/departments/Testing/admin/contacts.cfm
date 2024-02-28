<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Audit Notification Contacts">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtbloffices
WHERE ID = #URL.ID#
</cfquery>
					  
<cfoutput query="OfficeName">
<b>Office Name</b> <br>
#OfficeName# 
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "QRS">
<br><br>
<cfelse>
<a href="editcontacts.cfm?ID=#ID#">(edit contacts)</a><br><br>
</CFIF>
</cflock>

<b>Region</b> <br>
#subRegion#<br><br>

<b>Contact 1</b> <sup>1</sup><br>
<cfif len(RQM)>
#replace(RQM, ",", "<br />", "All")#
<cfelse>
None Listed
</cfif><br><br>

<b>Contact 2</b> <sup>1</sup><br>
<cfif len(QM)>
#replace(QM, ",", "<br />", "All")#
<cfelse>
None Listed
</cfif><br><br>

<b>Contact 3</b> <sup>1</sup><br>
<cfif len(GM)>
#replace(GM, ",", "<br />", "All")#
<cfelse>
None Listed
</cfif><br><br>

<b>Contact 4</b> <sup>1</sup><br>
<cfif len(LES)>
#replace(LES, ",", "<br />", "All")#
<cfelse>
None Listed
</cfif><br><br>

<b>Contact 5</b> <sup>1</sup><br>
<cfif len(Other)>
#replace(Other, ",", "<br />", "All")#
<cfelse>
None Listed
</cfif><br><br>

<b>Contact 6</b> <sup>1</sup><br>
<cfif len(Other2)>
#replace(Other2, ",", "<br />", "All")#
<cfelse>
None Listed
</cfif><br><br>

<b>Regional Audit Contacts</b> <sup>2</sup><br>
<cfif len(Regional1)>
#Regional1#
<cfelse>
None Listed
</cfif><br>

<cfif len(Regional2)>
#Regional2#
<cfelse>
None Listed
</cfif><br>

<cfif len(Regional3)>
#Regional3#
<cfelse>
None Listed
</cfif><br><br>

<!---
<b>QRS</b> <sup>3</sup><br>
#QRS#
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "QRS">
<a href="qrs_contact.cfm?ID=#ID#">(edit QRS contacts)</a><br><br>
<cfelse>
</CFIF>
</cflock>
--->
</cfoutput>

<br><br>
<sup>1</sup> - These fields will include notifications of Corporate Quality Audits.<br>
<sup>2</sup> - These fields will include notifications of Regional Audits.<br>
<sup>3</sup> - These fields will include notifications of QRS Audits.<br>
<br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
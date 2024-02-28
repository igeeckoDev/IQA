<cfmail from="ULWebForms@ul.com" to="Internal.Quality_Audits@ul.com" subject="IQA Audit Request - #Form.e_Location#">
Sent By: 
#Form.e_Name#, #Form.e_Email#

Scope:
#Form.e_auditscope#

Location:
#Form.e_location#

Time Frame:
#Form.e_time#
</cfmail>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Audit Request Sent">
<cfinclude template="SOP.cfm">

<!--- / --->
						  
<p>Email Sent.<br>
You will be contacted upon receipt for scheduling verification.<br><br>

<hr noshade width="75%" align="center">
<br><br>
<CFOUTPUT>
<p><b>Sent By:</b><br>
#Form.e_Name#, #Form.e_Email#</p>

<p><b>Scope:</b><br>
#Form.e_auditscope#</p>

<p><b>Location to be Audited:</b><br>
#Form.e_Location#</p>

<p><b>Time Frame:</b><br>
#Form.e_time#</p>
</CFOUTPUT>
</p>
<br>						  					  
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
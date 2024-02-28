<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="EditAccount"> 
SELECT * FROM IQADB_LOGIN
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Database Users - View Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("URL.msg")>
	<cfoutput><font color="red">#URL.msg#</font></cfoutput><br><br>
</cfif>

<cfoutput query="EditAccount">
<b>Available Actions</b><br />
 :: <a href="ViewUsers_ResetPassword.cfm?ID=#ID#">Reset Password</a><br />
<!---
 :: <a href="ViewUsers_Edit.cfm?ID=#ID#">Edit Account</a><br />
--->
 :: <a href="ViewUsers_ChangeStatus.cfm?ID=#ID#">Change Status</a><br />
<!---
 :: <a href="ViewUsers_ChangeUsername.cfm?ID=#ID#">Change Username</a><br>
--->
 :: <a href="ViewUsers.cfm">View User List</a><br /><br />
 
<b>Username</b><br />
#Username#<br /><br />

<b>Name</b><br />
#Name#<br /><br />

<b>Email</b><br />
#Email#<br /><br />

<b>AccessLevel</b><br />
#AccessLevel#<br /><br />

<b>Location</b><br />
<cfif IQA eq "Yes">
	Corporate IQA<br><br>
<cfelse>
	#Region# / #SubRegion#<br /><br />
</cfif>

<b>Status</b><br />
<cfif NOT len(Status)>
	Active
<cfelse>
    <cfif Status eq "Test">
    	<font color="red">This is a Test Account</font><br /><br />
	<cfelse>
		#Status#    	
    </cfif>
</cfif><br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
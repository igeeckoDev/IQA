<!--- Start of Page File --->
<cfset subTitle = "Request to be a CAR Champion - Request Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="inc_TOP.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Requests" DataSource="Corporate">
SELECT * FROM CARAdminRequest
WHERE ID = #URL.ID#
</cfquery>

<cflock scope="Session" timeout="5">
	<cfif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
	 <cfoutput>
		<a href="admin/Request.cfm">View</a> List CAR Champion Requests<br><br>
		<!--- maybe for later
		<a href="admin/RequestEdit.cfm?ID=#URL.ID#">Edit/Manage</a> This CAR Champion Request<br><br>--->
	 </cfoutput>
	</cfif>
</cflock>

<CFOUTPUT QUERY="Requests">
<b>Name</b><br>
#Name# (<a href="mailto:#Email#">#Email#</a>)<Br><Br>

<b>Location</b><Br>
#Location#<br><br>

<b>Guide 17020</b><Br>
Experience: <cfif x17020 eq 1>Yes<cfelse>No</cfif><Br>
Years of Experience: #x17020yrs#<br>

<cfset dump = #replace(x17020notes, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "", "All")#>
Notes: <cfif len(x17020notes)>#dump2#<cfelse>N/A</cfif><br><br>

<b>Guide 17025</b><Br>
Experience: <cfif x17025 eq 1>Yes<cfelse>No</cfif><Br>
Years of Experience: #x17025yrs#<br>

<cfset dump = #replace(x17025notes, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "", "All")#>
Notes: <cfif len(x17025notes)>#dump2#<cfelse>N/A</cfif><br><br>

<b>Guide 17065</b><Br>
Experience: <cfif x17065 eq 1>Yes<cfelse>No</cfif><Br>
Years of Experience: #x17065yrs#<br>

<cfset dump = #replace(x17065notes, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "", "All")#>
Notes: <cfif len(x17065notes)>#dump2#<cfelse>N/A</cfif><br><br>

<b>Status of Request</b><br>
<cfif status is "">Open<cfelse>#Status#</cfif>

<cflock scope="Session" timeout="5">
	<cfif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
    	<cfif NOT len(Status) AND Status NEQ "Approved">
		 :: [<a href="RequestStatus.cfm?ID=#URL.ID#">Change </a> Request Status]
         </cfif>
	</cfif>
</cflock><br><br />

<b>Date Requested</b><br>
#dateformat(posted, "mm/dd/yyyy")#<Br>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
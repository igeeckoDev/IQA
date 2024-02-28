<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KB">
SELECT KB.ID, KB.Subject, KB.CAR, KB.Status, KB.Author, KB.Posted, KB.KBTopics, KB.Details, KBTopics.KBTopics FROM KB, KBTopics
WHERE KB.KBTopics = KBTopics.KBTopics
AND KB.Status IS NULL
<cfif isdefined("URL.CAR")>
 AND KB.CAR = 1
</cfif>
ORDER BY KB.KBTopics, Subject
</CFQUERY>

<cflock scope="SESSION" timeout="60">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
			<cfinclude template="#CARDir_Admin#KBMenu.cfm">
		</CFIF>
    </cfif>
</cflock>
 
<br> 
<cfset KBTopicHolder = ""> 
<CFOUTPUT Query="KB"> 
<cfif KBTopicHolder IS NOT KB.KBTopics> 
<cfIf KBTopicHolder is NOT ""><br></cfif> 
<b>#KBTopics#</b><br> 
</cfif>
<cfif Subject is "">    
No Articles in this Topic exist.
<cfelse>
<!--- SU and Admin can edit all, users can edit their own, only --->
<cflock scope="SESSION" timeout="60">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
			&nbsp;&nbsp; - <a href="#CARRootDir#KB.cfm?ID=#ID#">#Subject#</a> (<a href="#CARAdminDir#kbedit.cfm?ID=#ID#">edit</a>)<br>
		<cfelse>
			<cfif Author is SESSION.AUTH.Name>
				&nbsp;&nbsp; - <a href="#CARRootDir#KB.cfm?ID=#ID#">#Subject#</a> (<a href="#CARAdminDir#kbedit.cfm?ID=#ID#">edit</a>)<br>
			<cfelse>
				&nbsp;&nbsp; - <a href="#CARRootDir#KB.cfm?ID=#ID#">#Subject#</a><br>
			</cfif>
		</cfif>
	<!--- if not logged in --->
	<cfelse>
		&nbsp;&nbsp; - <a href="#CARRootDir#KB.cfm?ID=#ID#">#Subject#</a><br>
	</cfif>	
</cflock>
</cfif> 
<cfset KBTopicHolder = KB.KBTopics> 
</CFOUTPUT>
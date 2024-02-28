<CFQUERY BLOCKFACTOR="100" NAME="FAQ" Datasource="Corporate"> 
SELECT * FROM IQADB_FAQ "FAQ" 
WHERE Status = 'Active'
ORDER BY alphaID
</CFQUERY>

<br>

<cfset i = 1>
<CFOUTPUT QUERY="FAQ">
#i#. &nbsp;<a href="FAQ.cfm###ID#">#Q#</a><br>
<cfset i = i + 1>
</CFOUTPUT>						  
						  
<br><br>
<cfset i = 1>
<CFOUTPUT QUERY="FAQ">
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<a name="#ID#"></a>
<span class="blog-title">
#i#. &nbsp;#Q# 
<cflock scope="Session" timeout="6">
	<cfif isDefined("SESSION.Auth.IsLoggedIn")>
		<cfif SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
			<a href="#IQAAdminDir#faq_edit.cfm?ID=#ID#">[Edit]</a>
		</cfif>
	</cfif>
</cflock>
</span><br><br>

<span class="blog-content">
<cfset dump = #replace(A, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "<br><br>", "All")#>
#dump2#
</span>
<cfset i = i + 1>
</CFOUTPUT>
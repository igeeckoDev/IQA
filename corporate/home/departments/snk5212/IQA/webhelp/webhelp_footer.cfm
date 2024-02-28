<cfif NOT isDefined("URL.Type")>
	<cfset URL.Type = "popUp">
</cfif>

<cfoutput>
<br><br>
<a href="webhelp_showMaxRev.cfm?Type=#URL.Type#">[Web Help Index]</a>
</cfoutput>
<!---
<br>
<a href="javascript:window.close();">[Close Window]</a>
--->
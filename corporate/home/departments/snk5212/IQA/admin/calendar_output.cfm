<cfoutput>
<!--- audit number and link to details --->
<a href="auditdetails.cfm?id=#id#&year=#year#">
<cfif auditedby is "AS">
    (#auditedby#-#year#-#id#)
<cfelse>
    (#year#-#id#-#auditedby#)
</cfif></a>
<br>
<!--- end of hover/start of output on calendar underneath audit number/link --->
<cfif auditedby is "AS">
    #replace(officename, "!", ", ", "All")# (#audittype#)
<cfelseif audittype is "TPTDP">
    #externallocation#
<cfelseif audittype2 is "Field Services">
    #replace(officename, "!", ", ", "All")#
<cfelseif audittype2 is "Global Function/Process" or audittype2 is "Corporate" or audittype2 is "MMS - Medical Management Systems" or audittype2 is "Local Function" OR audittype2 is "Local Function FS">
    #replace(officename, "!", ", ", "All")# - <cfif Area is "Acquired Facility">#AuditArea#<cfelse>#Area#<cfif Area is "Processes" OR Area is "Laboratories"> - #AuditArea#</cfif></cfif><cfif Desk eq "Yes"> (Desk Audit)</cfif>
<cfelseif audittype2 is "Program">
    #replace(officename, "!", ", ", "All")#<br />
    [#Area#]
<cfelse>
    #replace(officename, "!", ", ", "All")#
</cfif><br><br>
</cfoutput>
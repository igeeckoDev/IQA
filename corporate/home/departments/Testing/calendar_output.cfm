<!---
<style type="text/css">
  div.transparent {
    filter:alpha(opacity=100);
    display:none;
    width:250;
    height:200;
    position:absolute;
    color: black;
    border: 1 black solid;
}
</style>

<script language="javascript" type="text/javascript">
    /* this function shows the pop-up when
     user moves the mouse over the link */
    function Show(id)
    {
        /* get the mouse left position */
        x = event.clientX + document.body.scrollLeft;
        /* get the mouse top position  */
        y = event.clientY + document.body.scrollTop + 75;
        /* display the pop-up */
        document.getElementById(id).style.display="block";
        /* set the pop-up's left */
        document.getElementById(id).style.left = x;
        /* set the pop-up's top */
        document.getElementById(id).style.top = y;
    }
    /* this function hides the pop-up when
     user moves the mouse out of the link */
    function Hide(id)
    {
        /* hide the pop-up */
        document.getElementById(id).style.display="none";
    }
</script>
--->

<cfoutput>
<!---
audit number and link to details
onMouseOut="Hide(#id#)" onMouseMove="Show(#id#)" removed from link tag
--->
<a href="auditdetails.cfm?id=#id#&year=#year#">
<cfif auditedby is "AS">
    (#auditedby#-#year#-#id#)
<cfelse>
    (#year#-#id#-#auditedby#)
</cfif></a>
<!---
<!--- hover over box with audit details --->
<div id="#id#" class="transparent" style="border: 1px solid black">
    <div style="background-color: ##A6A6A6">
     <b>Audit Details<br>
     <cfif auditedby is "AS">
         #auditedby#-#year#-#id#
     <cfelse>
         #year#-#id#-#auditedby#
     </cfif></b>
    </div>
<div style="background-color: ##f2f2f2; padding:2px;">
<cfif audittype is "TPTDP">
    #externallocation#
<cfelse>
    #OfficeName#
    <cfif auditedby is "LAB">
		<br />#AuditArea#
    </cfif>
</cfif><br>

#DateOutput#<br />

#trim(auditType)#
<cfif audittype is NOT "TPTDP"
    and auditedby is NOT "AS"
    and audittype2 is NOT "Accred"
    and audittype is NOT "finance"
    and auditedby is NOT "QRS"
    and auditedby is NOT "Field Services"
    and audittype2 is NOT "Field Services"
	and auditedby is NOT "LAB">, #Trim(AuditType2)#<br>#Auditarea#
<cfelseif audittype2 is "Field Services" OR auditedby is "Field Services">, #Trim(AuditType2)#
    <cfif audittype2 is NOT "Field Services" AND auditedby is NOT "LAB">
        <br>#Area#
    </cfif>
</cfif><br>
<cfif auditedby is "AS">
    UL Site Contact - #SiteContact#<br>
    AS Contact - #ASContact#<br>
<cfelseif audittype2 is "Accred">
    UL Site Contact - #SiteContact#<br>
<cfelseif auditedby is "Finance">
    Auditor - #ASContact#
<cfelseif auditedby is "QRS">
    Auditor - #Auditor#<br>
<cfelseif auditedby is "LAB">
    Auditor - #Auditor#<br />
	<cfif len(EmailName)>
		Site Contact - #EmailName#<Br />
	</cfif>
<cfelse>
    Lead Auditor- #LeadAuditor#<br>
</cfif>
</div>
</div><br>
<!--- end of hover/start of output on calendar underneath audit number/link --->
--->
<cfif auditedby is "AS">
    #officename# (#audittype#)
<cfelseif audittype is "TPTDP">
    #externallocation#
<cfelseif audittype2 is "Field Services">
    #officename#
<cfelseif audittype2 is "Global Function/Process" or audittype2 is "Corporate" or audittype2 is "MMS - Medical Management Systems" or audittype2 is "Local Function" OR audittype2 is "Local Function FS">
    #officename# - <cfif Area is "Acquired Facility">#AuditArea#<cfelse>#Area#<cfif Area is "Processes" OR Area is "Laboratories"> - #AuditArea#</cfif></cfif><cfif Desk eq "Yes"> (Desk Audit)</cfif>
<cfelseif audittype2 is "Program">
    #officename#<br />
    [#Area#]
<cfelse>
    #officename#
</cfif><br><br>
</cfoutput>
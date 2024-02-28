<CFOUTPUT query="Details">

	<CFIF Details.IsFirst()>
<td colspan="4" class="sched-title">
<a name="#i#"></a>
<div align="center" class="blog-title">
#MonthAsString(Month)# #Year#
<!---
 - <a href="Print_month.cfm?Month=#i#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">Print</a>
--->
</div>
</td>
</tr>
<tr>
	</cfif>

    <CFIF (Int(Details.CurrentRow)-1) mod 4 is 0 and NOT Details.IsFirst()> 
    </tr><tr> 
    </CFIF>
    <td class="sched-content" width="25%" valign="top" align="left">
	 
<cfif Details.auditedby is "AS">
<b>#AuditedBy#-#Year#-#ID#</b>
<cfelse>
<b>#Year#-#ID#-#AuditedBy#</b>
</cfif>
<br> 
#OfficeName#<br>
<cfif auditedby is "LAB">
#AuditArea#<br />
</cfif>
#AuditType#<br>				
<cfif auditedby is "QRS">
#Auditor#, Auditor<br>
<cfelseif auditedby is "LAB">
#Auditor#, Auditor<br>
	<cfif len(EmailName)>
    	Primary Contact - #EmailName#<br />
    </cfif>
<cfelseif auditedby is "Finance">
#replace(ASContact, ",", "<br />", "All")#<br>
</cfif>

<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">
    
	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>
	
	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>
    
    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#
<br />

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
SELECT * FROM ReportAttach
WHERE ID = <cfqueryparam value="#ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif reschedulenextyear is NOT "Yes">
	<cfif AuditedBy is "LAB">
    	<cfinclude template="status_colors_LTA2.cfm">
    <cfelse>
	   	<cfinclude template="status_colors_AS2.cfm">
	</cfif>
</cfif>

<cfif Trim(RescheduleStatus) is "rescheduled">
<br>
<img src="../images/red.jpg" border="0">
<CFELSE>
</CFIF>

<br><br>				

<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">Audit Details</a>
</td>

<cfif Details.IsLast()>
	<cfif Int(Details.CurrentRow) gt 4>
		<cfif (Int(Details.CurrentRow)-1) mod 4 eq 2>
			<td>&nbsp;</td>
		<cfelseif (Int(Details.CurrentRow)-1) Mod 4 eq 1>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        <cfelseif (Int(Details.CurrentRow)-1) Mod 4 eq 0>
        	<td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
		</cfif>
	</cfif>
</cfif>
</CFOUTPUT>
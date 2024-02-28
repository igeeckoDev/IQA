<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Reschedule- Confirm">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<script language="JavaScript" src="../webhelp/webhelp.js"></script>
					  
<div align="Left" class="blog-time">
IQA Activity Help - <A HREF="javascript:popUp('../webhelp/webhelp_IQAActivity.cfm')">[?]</A></div>						  

<CFQUERY BLOCKFACTOR="100" name="Reschedule" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year 
FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
						  
<cfoutput query="Reschedule">
<!--- change to approval by DE page --->
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="reschedule_submit.cfm?ID=#ID#&Year=#Year#">

<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>

<cfset y = #url.year#>
<cfset y2 = #y# + 1>
<cfset d = #DateFormat(Form.startdate, 'dd')#>
<cfset m = #DateFormat(Form.startdate, 'mm')#>
<cfset d2 = #DateFormat(Form.Enddate, 'dd')#>
<cfset m2 = #DateFormat(Form.Enddate, 'mm')#>

<cfif form.reschedulenextyear is "yes">
<cfif Form.StartDate is "" AND Form.EndDate is "">
	<input type="hidden" value="" name="startdate">
	<input type="hidden" value="" name="enddate">
	<input type="hidden" value="#form.e_month#" name="month">
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
	<input type="hidden" value="#m#/#d#/#y2#" name="startdate">
	<input type="hidden" value="" name="enddate">
	<cfset m = #DateFormat(Form.StartDate, 'mm')#>
	<input type="hidden" value="#m#" name="month">
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		<input type="hidden" value="#m#/#d#/#y2#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 0>
		<input type="hidden" value="#m#/#d#/#y2#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 1>
		<input type="hidden" value="#m2#/#d2#/#y2#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		<input type="hidden" value="#m2#/#d2#/#y2#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y2#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
</cfif>
<cfelse>
<cfif Form.StartDate is "" AND Form.EndDate is "">
	<input type="hidden" value="" name="startdate">
	<input type="hidden" value="" name="enddate">
	<input type="hidden" value="#form.e_month#" name="month">
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
	<input type="hidden" value="#m#/#d#/#y#" name="startdate">
	<input type="hidden" value="" name="enddate">
	<cfset m = #DateFormat(Form.StartDate, 'mm')#>
	<input type="hidden" value="#m#" name="month">
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		<input type="hidden" value="#m#/#d#/#y#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 0>
		<input type="hidden" value="#m#/#d#/#y#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	<cfelseif CompareDate eq 1>
		<input type="hidden" value="#m2#/#d2#/#y#" name="startdate">
		<input type="hidden" value="#m#/#d#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		<input type="hidden" value="#m2#/#d2#/#y#" name="startdate">
		<input type="hidden" value="#m2#/#d2#/#y#" name="enddate">
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		<input type="hidden" value="#m#" name="month">
</cfif>
</cfif>

Do you wish to reschedule Audit #year#-#id#-#auditedby#?<br><br>

<u>Original Month:</u> #monthasstring(Month)#, #Year#<br>

<cfif form.startdate is "" AND Form.EndDate is "">
	<u>Rescheduled Month:</u> #monthasstring(Form.e_Month)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# + 1>#Next#<cfelse>#Year#</cfif><br><br>
<cfelseif form.startdate is NOT "" AND Form.EndDate is "">
	<cfset m = #DateFormat(Form.StartDate, 'mm')#>
	<u>Rescheduled Month:</u> #monthasstring(m)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# + 1>#Next#<cfelse>#Year#</cfif><br><br>
<cfelseif form.startdate is "" AND Form.EndDate is NOT "">
	<cfset m = #DateFormat(Form.EndDate, 'mm')#>
	<u>Rescheduled Month:</u> #monthasstring(m)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# + 1>#Next#<cfelse>#Year#</cfif><br><br>
<cfelseif form.startdate is NOT "" AND Form.EndDate is NOT "">
	<cfset m = #DateFormat(Form.startdate, 'mm')#>
	<u>Rescheduled Month:</u> #monthasstring(m)#, <cfif Form.RescheduleNextYear is "Yes"><cfset next = #Year# +
1>#Next#<cfelse>#Year#</cfif><br><br>
</cfif>

<u>Reschedule Dates:</u><br>
<cfif form.reschedulenextyear is "yes">
	<cfif Form.StartDate is "" AND Form.EndDate is "">
		No Dates
	<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
		#m#/#d#/#y2#
	<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
		<cfif CompareDate eq -1>
			#m#/#d#/#y2# - #m2#/#d2#/#y2#
		<cfelseif CompareDate eq 0>
			#m#/#d#/#y2# - #m#/#d#/#y2#
		<cfelseif CompareDate eq 1>
			#m2#/#d2#/#y2# - #m#/#d#/#y2#
		</cfif>
	<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		#m2#/#d2#/#y2#
	</cfif>
<cfelse>
	<cfif Form.StartDate is "" AND Form.EndDate is "">
		No Dates
	<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
		#m#/#d#/#y#
	<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
		<cfif CompareDate eq -1>
			#m#/#d#/#y# - #m2#/#d2#/#y#
		<cfelseif CompareDate eq 0>
			#m#/#d#/#y# - #m#/#d#/#y#
		<cfelseif CompareDate eq 1>
			#m2#/#d2#/#y# - #m#/#d#/#y#
		</cfif>
	<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
		#m2#/#d2#/#y#
	</cfif>
</cfif><br><br>

<u>Reschedule Notes</u>:<br>
#htmlcodeformat(Form.e_RescheduleNotes)#<br><br>
<input type="hidden" value="#form.e_reschedulenotes#" name="reschedulenotes">
<input type="hidden" value="#form.reschedulenextyear#" name="reschedulenextyear">

<INPUT TYPE="Submit" name="Resched" Value="Confirm Request">
<INPUT TYPE="Submit" name="Resched" Value="Cancel Request">

</FORM>
</cfoutput>  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
<CFQUERY Datasource="Corporate" Name="baseline">
UPDATE Baseline
SET
Baseline=#Form.Baseline#
WHERE Year_ = #form.year#
</cfquery>

<!--- no longer used
<cfmail 
	to="Kai.huang@ul.com"
    from="Internal.Quality_Audits@ul.com"
    cc=" Kai.Huang@ul.com"
    replyto="global.internalquality@ul.com"
    subject="#form.Year# IQA Audit Schedule has been baselined"
    type="html">
    <cfoutput>
    The #form.Year# IQA Audit Schedule has been approved and baselined.<br /><br />
    </cfoutput>
    
    Please note that notifications will be sent if any audits are cancelled or rescheduled.<br /><br /> 
</cfmail>
--->

<cflocation url="baseline.cfm?year=#form.year#" ADDTOKEN="No">
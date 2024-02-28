<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<HTML>
<HEAD>
<TITLE>Print Report</TITLE>
</HEAD>
<BODY>

<!--- Check if the Finding number is existed in the Database --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View2">
SELECT * FROM TPREPORT2
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<p>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Ex"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID, AuditSchedule.AuditedBy,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Auditor, AuditSchedule.LeadAuditor, AuditSchedule.AuditType, AuditSchedule.Report, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.KCPhone, ExternalLocation.ExternalLocation, ExternalLocation.Type
 FROM AuditSchedule, ExternalLocation
 WHERE AuditSchedule.ID = #URL.ID# 
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<!--- Read the template file----->

<CFLOCK NAME="L1" TYPE="ReadOnly" Timeout="30">
<CFFILE ACTION="READ"
        FILE ="#ExpandPath(".")#\1.RTF"
        VARIABLE= "TEXT1">
</CFLOCK>

<!--- Replace the marks with real information form the database--->
<CFSET TEXT2=REPLACE(#TEXT1#, "UUUUY","#Ex.Year#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUX","#Ex.ID#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUW","#Ex.AuditedBy#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUU4","#Ex.ExternalLocation#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUU5","#Ex.AuditType#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUU6","#Ex.KC#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUU7","#Ex.KCEmail#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUU8","#DateFormat(Ex.EndDate, 'mmmm dd, yyyy')#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUU9","#Ex.LeadAuditor#")>

<cfif Ex.auditor is "- None -" or Ex.auditor is "">
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUA","")>
<cfelse>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUA","#Ex.Auditor#")>
</cfif>

<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUL","#View.LabCert#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUN","#View.LabCertNotes#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUJ","#View.ProjectsCompleted#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUK","#View.PeopleInFacility#")>

<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUE","#View.Scope#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUF","#DateFormat(View.ReportDate, 'mmmm dd, yyyy')#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUH","#View.Summary#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUI","#View.BestPrac#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUM","#DateFormat(Ex.StartDate, 'mmmm dd, yyyy')#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUQ","#Ex.Type#")>

<CFSET TEXT2=REPLACE(#TEXT2#, "UUUUZ","#Ex.KCPhone#")>

<CFSET TEXT2=REPLACE(#TEXT2#, "XF1","#View.Count1#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF2","#View.Count2#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF3","#View.Count3#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF4","#View.Count4#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF5","#View.Count5#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF6","#View.Count6#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF7","#View.Count7#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF8","#View.Count8#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XF9","#View.Count9#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFA","#View.Count10#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFB","#View.Count11#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFC","#View.Count12#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFD","#View.Count13#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFE","#View.Count14#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFF","#View.Count15#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFG","#View.Count16#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFH","#View.Count17#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFI","#View.Count18#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFJ","#View.Count19#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFK","#View.Count20#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFL","#View.Count21#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFM","#View.Count22#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFN","#View.Count23#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFO","#View.Count24#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFP","#View.Count25#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XFQ","#View.CountOther#")>

<CFSET TEXT2=REPLACE(#TEXT2#, "xvq","#View.OCount1#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqa","#View.OCount2#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqz","#View.OCount3#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqc","#View.OCount4#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqd","#View.OCount5#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqe","#View.OCount6#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqf","#View.OCount7#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqg","#View.OCount8#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqh","#View.OCount9#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqi","#View.OCount10#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqj","#View.OCount11#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqk","#View.OCount12#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvql","#View.OCount13#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqm","#View.OCount14#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqn","#View.OCount15#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqo","#View.OCount16#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqp","#View.OCount17#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqq","#View.OCount18#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqr","#View.OCount19#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqs","#View.OCount20#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqt","#View.OCount21#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqu","#View.OCount22#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqv","#View.OCount23#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqw","#View.OCount24#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqx","#View.OCount25#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "xvqy","#View.OCountOther#")>

<CFSET TEXT2=REPLACE(#TEXT2#, "XC1","#View.CAR1#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC2","#View.CAR2#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC3","#View.CAR3#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC4","#View.CAR4#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC5","#View.CAR5#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC6","#View.CAR6#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC7","#View.CAR7#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC8","#View.CAR8#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XC9","#View.CAR9#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCA","#View.CAR10#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCB","#View.CAR11#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCC","#View.CAR12#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCD","#View.CAR13#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCE","#View.CAR14#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCF","#View.CAR15#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCG","#View.CAR16#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCH","#View.CAR17#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCI","#View.CAR18#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCJ","#View.CAR19#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCK","#View.CAR20#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCL","#View.CAR21#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCM","#View.CAR22#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCN","#View.CAR23#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCO","#View.CAR24#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCP","#View.CAR25#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "XCQ","#View.CAROther#")>

<cfif View2.VCar1 is "0">

<CFSET TEXT2=REPLACE(#TEXT2#, "DUMP1","No Verified CARs")>
<CFSET TEXT2=REPLACE(#TEXT2#, "DUMP2","")>
<CFSET TEXT2=REPLACE(#TEXT2#, "DUMP3","")>

<cfelse>

<cfset DUMP1="\trowd \trgaph108\trleft-108\trbrdrt\brdrs\brdrw10 \trbrdrl\brdrs\brdrw10 \trbrdrb\brdrs\brdrw10 \trbrdrr\brdrs\brdrw10 \trbrdrh\brdrs\brdrw10 \trbrdrv\brdrs\brdrw10 \trftsWidth1\trautofit1\trpaddl108\trpaddr108\trpaddfl3\trpaddfr3 \clvertalt\clbrdrt
\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx2844\clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 
\cltxlrtb\clftsWidth3\clwWidth2952 \cellx5796\clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx8748\pard\plain 
\s1\qc \li0\ri0\keepn\widctlpar\intbl\aspalpha\aspnum\faauto\outlinelevel0\adjustright\rin0\lin0 \b\fs18\lang1033\langfe2052\loch\af29\hich\af29\dbch\af17\cgrid\langnp1033\langfenp2052 {\hich\af29\dbch\af17\loch\f29 CAR Number\cell 
\hich\af29\dbch\af17\loch\f29 Effective\cell }\pard\plain \qc \li0\ri0\widctlpar\intbl\aspalpha\aspnum\faauto\adjustright\rin0\lin0 \fs24\lang1033\langfe2052\loch\af0\hich\af0\dbch\af17\cgrid\langnp1033\langfenp2052 {\b\f29\fs18 
\hich\af29\dbch\af17\loch\f29 Comments\cell }\pard \ql \li0\ri0\widctlpar\intbl\aspalpha\aspnum\faauto\adjustright\rin0\lin0 {\f29\fs18 \trowd \trgaph108\trleft-108\trbrdrt\brdrs\brdrw10 \trbrdrl\brdrs\brdrw10 \trbrdrb\brdrs\brdrw10 \trbrdrr
\brdrs\brdrw10 \trbrdrh\brdrs\brdrw10 \trbrdrv\brdrs\brdrw10 \trftsWidth1\trautofit1\trpaddl108\trpaddr108\trpaddfl3\trpaddfr3 \clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 
\cltxlrtb\clftsWidth3\clwWidth2952 \cellx2844\clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx5796\clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 
\clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx8748\row }">

<cfset DUMP2a="\trowd \trgaph108\trleft-108\trbrdrt\brdrs\brdrw10 \trbrdrl\brdrs\brdrw10 \trbrdrb\brdrs\brdrw10 \trbrdrr\brdrs\brdrw10 \trbrdrh\brdrs\brdrw10 \trbrdrv
\brdrs\brdrw10 \trftsWidth1\trautofit1\trpaddl108\trpaddr108\trpaddfl3\trpaddfr3 \clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx2844\clvertalt\clbrdrt
\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx5796\clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 
\cltxlrtb\clftsWidth3\clwWidth2952 \cellx8748\pard \ql \li0\ri0\widctlpar\intbl\aspalpha\aspnum\faauto\adjustright\rin0\lin0 {\f29\fs18 \hich\af29\dbch\af17\loch\f29  #View2.VCAR1#\cell \hich\af29\dbch\af17\loch\f29 #View2.Effective1#\cell \hich\af29\dbch\af17\loch\f29 #View2.Comments1#
\cell }\pard \ql \li0\ri0\widctlpar\intbl\aspalpha\aspnum\faauto\adjustright\rin0\lin0 {\f29\fs18 \trowd \trgaph108\trleft-108\trbrdrt\brdrs\brdrw10 \trbrdrl\brdrs\brdrw10 \trbrdrb\brdrs\brdrw10 \trbrdrr\brdrs\brdrw10 \trbrdrh\brdrs\brdrw10 \trbrdrv
\brdrs\brdrw10 \trftsWidth1\trautofit1\trpaddl108\trpaddr108\trpaddfl3\trpaddfr3 \clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx2844\clvertalt\clbrdrt
\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 \cltxlrtb\clftsWidth3\clwWidth2952 \cellx5796\clvertalt\clbrdrt\brdrs\brdrw10 \clbrdrl\brdrs\brdrw10 \clbrdrb\brdrs\brdrw10 \clbrdrr\brdrs\brdrw10 
\cltxlrtb\clftsWidth3\clwWidth2952 \cellx8748\row }">

<cfset DUMP2="#dump2a#">

<cfset DUMP3="\pard \ql \li0\ri0\widctlpar\aspalpha\aspnum\faauto\adjustright\rin0\lin0\itap0 {
\par 
\par }}">

<CFSET TEXT2=REPLACE(#TEXT2#, "DUMP1","#DUMP1#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "DUMP2","#DUMP2#")>
<CFSET TEXT2=REPLACE(#TEXT2#, "DUMP3","#DUMP3#")>

</cfif>

<!--- Output the file to MS World---->

<cfheader name="content-inline" value="attachment;filename=Finding.RTF">
<cfcontent type="application/msword">
<CFOUTPUT>
#TEXT2#
</CFOUTPUT>
</BODY>
</HTML>
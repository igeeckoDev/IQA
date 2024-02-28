<cfoutput>
<b>#DateFormat(DateSent, 'mmmm dd, yyyy')#</b><br><br>

<b>#name#<br>
#contactemail#<br>
#ExternalLocation#<br>
#Address1#<br>
<cfif address2 is "" or address2 is " "><cfelse>#trim(Address2)#<br>
</cfif>
<cfif address3 is "" or address3 is " "><cfelse>#trim(Address3)#<br>
</cfif>
<cfif address4 is "" or address4 is " "><cfelse>#trim(Address4)#<br>
</cfif></b><br>

File Number <b>#FileNumber#</b>
<cfif billable is "Yes"><br>Project Number: <b>#ProjectNumber#</b></cfif><br><br>

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program <br><br>

Dear <b>#Name#</b>,<br><br>
</cfoutput>

<!--- count Findings and Observations from Audit Report --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> and id=#url.id#
</cfquery>

<cfoutput query="View">
<cfset CARList = CAR1 & ", " & CAR2 & ", " & CAR3 & ", " & CAR4 & ", " & CAR5 & ", " & CAR6 & ", " & CAR7 & ", " & CAR8 & ", " & CAR9 & ", " & CAR10 & ", " & CAR11 & ", " & CAR12 & ", " & CAR13 & ", " & CAR14 & ", " & CAR15 & ", " & CAR16 & ", " & CAR17 & ", " & CAR18 & ", " & CAR19 & ", " & CAR20 & ", " & CAR21 & ", " & CAR22 & ", " & CAR23 & ", " & CAR24 & ", " & CAR25 & ", " & CAROther>

<cfset dump = #replace(CARList, "N/A, ", "", "All")#>
<cfset dump1 = #replace(dump, ", N/A", "", "All")#>
<cfset dump2 = #replace(dump1, "N/A", "", "All")#>
<cfset dump3 = #replace(dump2, "NA, ", "", "All")#>
<cfset dump4 = #replace(dump3, ", NA", "", "All")#>
<cfset dump5 = #replace(dump4, "NA", "", "All")#>
<!--- /// --->
</cfoutput>

<cfoutput>
<!--- no findings or obs --->
<cfif dump5 is "">
This letter addresses the responses to the findings associated with the recent assessment conducted of <b>#ExternalLocation#</b>'s operations <cfif startdate eq enddate>on <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b><cfelse>between <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b> and <b>#DateFormat(EndDate, 'mmmm dd, yyyy')#</b></cfif>.

UL has completed the review of <B>#ExternalLocation#</B>'s quality system, conducted [Audit Dates]. We are recommending that <B>#ExternalLocation#</B> be retained in good standing under UL's TPTDP. An updated TPTDP certificate should be mailed to you shortly.<br><br>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">By copy of this letter to <b>#CAPName#</b>, the Certificated Agent Program Coordinator at <b>#CAPLocation#</b>, we are informing the coordinator on the completion of the assessment. You should anticipate being notified on the status of the issuance of a new Certificate showing <b>#ExternalLocation#</b>'s continued participation in UL’s Certificated Agent Program.<cfelse> <cfif Cert is "Yes">You will receive a new Certificate under separate correspondence.</cfif></cfif><br><br>

<!--- some findings and/or obs --->
<cfelse>
This letter addresses the responses to the findings associated with the recent assessment conducted of <b>#ExternalLocation#</b>'s operations <cfif startdate eq enddate>on <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b><cfelse>between <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b> and <b>#DateFormat(EndDate, 'mmmm dd, yyyy')#</b></cfif>. 

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">You should anticipate being notified on the status of the issuance of a new Certificate showing <B>#ExternalLocation#</b>'s continued participation in UL’s Certificated Agent Program.<cfelse> <cfif Cert is "Yes">You will receive a new Certificate under separate correspondence.</cfif></cfif><br><br>

UL has reviewed the responses and corrective action plans to findings <b>#dump5#</b> and found them to be acceptable. Effective implementation of the identified corrective actions will be verified during the next regularly scheduled reassessment.<br><br>

UL anticipates that <b>#ExternalLocation#</b> will monitor the effectiveness of the corrective actions and take whatever additional actions necessary, if any, to ensure the elimination of the problems noted by the findings.<br><br>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">By copy of this letter to <b>#CAPName#</b>, the Certificated Agent Program Coordinator at <b>#CAPLocation#</b>, we are advising the coordinator on the resolution of the findings noted during our assessment.<cfif billable is "Yes"> Our Accounting Department has been advised to invoice you for charges incurred.</cfif></cfif></cfif>

<cfif Type is NOT "CAP-EA" AND Type is NOT "CAP-EA/CAP-AA">Thank you for your prompt response and it was a pleasure working with you and your staff during the audit. With this, the project related to this audit can be closed.<cfif billable is "Yes"> Our Accounting Department has been advised to invoice you for charges incurred.</cfif> We look forward to continuing our work with you in the future.<br><br></cfif>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">If you have any questions please do not hesitate to contact <b>#CAPName#</b>.<br><br></cfif>

Feel free to contact me with further questions or for additional information. Thank you for your continued participation in UL's TPTDP.<br><br>

<b>#Auditor#</b><br>
Underwriters Laboratories, Inc.<br>
Email: <b>#AuditorEmail#</b><br>
Phone: <b>#Phone#</b><br><br>

cc: #cc#
</cfoutput>
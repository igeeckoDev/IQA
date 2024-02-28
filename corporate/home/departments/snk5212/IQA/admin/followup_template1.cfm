<cfoutput>
<b>#DateFormat(curdate, 'mmmm dd, yyyy')#</b><br><br>

<b>#form.e_name#<br>
#form.e_contactemail#<br>
#ExternalLocation#<br>
#Form.e_Address1#<br>
<cfif form.address2 is "" or form.address2 is " "><cfelse>#Form.Address2#<br>
</cfif>
<cfif form.address3 is "" or form.address3 is " "><cfelse>#Form.Address3#<br>
</cfif>
<cfif form.address4 is "" or form.address4 is " "><cfelse>#Form.Address4#<br>
</cfif></b><br>

File Number: #SelectAudit.FileNumber#
<cfif Billable is "Yes"><br>Project Number: #Form.e_ProjectNumber#</cfif><br><br>

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program <br><br>

Dear <b>#Form.e_Name#</b>,<br><br>
</cfoutput>

<!--- count Noncompliance and Preventive actions from Audit Report --->
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

<cfoutput query="SelectAudit">
<!--- no findings or obs --->
<cfif dump5 is "">
This letter addresses the recent assessment conducted of <b>#ExternalLocation#</b>'s operations <cfif startdate eq enddate>on <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b><cfelse>between <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b> and <b>#DateFormat(EndDate, 'mmmm dd, yyyy')#</b></cfif>.

UL has completed the review of <B>#ExternalLocation#</B>'s quality system. We are recommending that <B>#ExternalLocation#</B> be retained in good standing under UL's TPTDP. An updated TPTDP certificate should be mailed to you shortly.<br><br>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">You should anticipate being notified on the status of the issuance of a new Certificate showing <b>#ExternalLocation#</b>'s continued participation in UL�s Certificated Agent Program.<cfelse> <cfif Cert is "Yes">You will receive a new Certificate under separate correspondence.</cfif></cfif><br><br>

<!--- some findings and/or obs --->
<cfelse>
This letter addresses the responses to the findings associated with the recent assessment conducted of <b>#ExternalLocation#</b>'s operations <cfif startdate eq enddate>on <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b><cfelse>between <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b> and <b>#DateFormat(EndDate, 'mmmm dd, yyyy')#</b></cfif>. 

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">You should anticipate being notified on the status of the issuance of a new Certificate showing <b>#ExternalLocation#</b>'s continued participation in UL�s Certificated Agent Program.<cfelse> <cfif Cert is "Yes">You will receive a new Certificate under separate correspondence.</cfif></cfif><br><br>

UL has reviewed the responses and corrective action plans to findings <b>#dump5#</b> and found them to be acceptable. Effective implementation of the identified corrective actions will be verified during the next regularly scheduled reassessment.<br><br>

UL anticipates that <b>#ExternalLocation#</b> will monitor the effectiveness of the corrective actions and take whatever additional actions necessary, if any, to ensure the elimination of the problems noted by the findings.<br><br>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">By copy of this letter to <b>#myarraylist[1]#</b>, the Certificated Agent Program Coordinator at <b>#myarraylist[2]#</b>, we are advising the coordinator on the resolution of the findings noted during our assessment.<cfif billable is "Yes"> Our Accounting Department has been advised to invoice you for charges incurred.</cfif><br><br></cfif>

</cfif>

<cfif Type is NOT "CAP-EA" AND Type is NOT "CAP-EA/CAP-AA">Thank you for your prompt response and it was a pleasure working with you and your staff during the audit. With this, the project related to this audit can be closed. <cfif billable is "Yes"> Our Accounting Department has been advised to invoice you for charges incurred.</cfif> We look forward to continuing our work with you in the future.<br><br></cfif>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">If you have any questions please do not hesitate to contact <b>#myarraylist[1]#</b>, the Certificated Agent Program Coordinator at <b>#myarraylist[2]#</b>.<br><br></cfif>

Feel free to contact me with further questions or for additional information. Thank you for your continued participation in UL's TPTDP.<br><br>

<b>#LeadAuditor#</b><br>
Underwriters Laboratories, Inc.<br>
Email: <b>#Form.e_AuditorEmail#</b><br>
Phone: <b>#Form.e_Phone#</b><br><br>

<cfif cc is "">
cc: <b>James.E.Feth@ul.com<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">, #myarraylist[3]#, Sandra.B.Brown@ul.com<cfelseif Cert is "Yes" OR Billable is "Yes">, Raye.Silva@ul.com</cfif></b><br>
<cfelse>
cc: <b>James.E.Feth@ul.com, #form.cc#<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">, #myarraylist[3]#, Sandra.B.Brown@ul.com<cfelseif Cert is "Yes" OR Billable is "Yes">, Raye.Silva@ul.com</cfif></b><br>
</cfif>
</cfoutput>
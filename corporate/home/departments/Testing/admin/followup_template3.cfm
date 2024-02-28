<cfoutput>#DateFormat(DateSent, 'mmmm dd, yyyy')#

#name#
#contactemail#
#ExternalLocation#
#Address1#
<cfif address2 is "" or address2 is " "><cfelse>#Address2#</cfif>
<cfif address3 is "" or address3 is " "><cfelse>#Address3#</cfif>
<cfif address4 is "" or address4 is " "><cfelse>#Address4#</cfif>

File Number: #FileNumber#
<cfif billable is "yes">Project Number: #ProjectNumber#</cfif>

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program 

Dear #Name#,
<cfif dump5 is ""><!--- no findings or obs --->
This letter addresses the responses to the findings associated with the recent assessment conducted of #ExternalLocation#'s operations <cfif startdate eq enddate>on #DateFormat(StartDate, 'mmmm dd, yyyy')#<cfelse>between #DateFormat(StartDate, 'mmmm dd, yyyy')# and #DateFormat(EndDate, 'mmmm dd, yyyy')#</cfif>.

UL has completed the review of #ExternalLocation#'s quality system. We are recommending that #ExternalLocation# be retained in good standing under UL's TPTDP.

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">By copy of this letter to #CAPName#, the Certificated Agent Program Coordinator at #CAPLocation#, we are informing the coordinator on the completion of the assessment. You should anticipate being notified on the status of the issuance of a new Certificate showing #ExternalLocation#'s continued participation in UL’s Certificated Agent Program.</cfif>
<cfelse><!--- some findings and/or obs --->
This letter addresses the responses to the findings associated with the recent assessment conducted of #ExternalLocation#'s operations <cfif startdate eq enddate>on #DateFormat(StartDate, 'mmmm dd, yyyy')#<cfelse>between #DateFormat(StartDate, 'mmmm dd, yyyy')# and #DateFormat(EndDate, 'mmmm dd, yyyy')#</cfif>.

<cfif Cert is "Yes">You will receive a new Certificate under separate correspondence.</cfif> <cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">You should anticipate being notified on the status of the issuance of a new Certificate showing #ExternalLocation#'s continued participation in UL’s Certificated Agent Program.</cfif>

UL has reviewed the responses and corrective action plans to findings #dump5# and found them to be acceptable. Effective implementation of the identified corrective actions will be verified during the next regularly scheduled reassessment.

UL anticipates that #ExternalLocation# will monitor the effectiveness of the corrective actions and take whatever additional actions necessary, if any, to ensure the elimination of the problems noted by the findings.
<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">
By copy of this letter to #CAPName#, the Certificated Agent Program Coordinator at #CAPLocation#, we are advising the coordinator on the resolution of the findings noted during our assessment.<cfif billable is "Yes"> Our Accounting Department has been advised to invoice you for charges incurred.</cfif></cfif></cfif><cfif Type is NOT "CAP-EA" AND Type is NOT "CAP-EA/CAP-AA">Thank you for your prompt response and it was a pleasure working with you and your staff during the audit. With this, the project related to this audit can be closed. <cfif billable is "Yes"> Our Accounting Department has been advised to invoice you for charges incurred.</cfif> We look forward to continuing our work with you in the future.</cfif>

<cfif Type is "CAP-EA" OR Type is "CAP-EA/CAP-AA">If you have any questions please do not hesitate to contact #CAPName#, the Certificated Agent Program Coordinator at #CAPLocation#.</cfif>

Feel free to contact me with further questions or for additional information. Thank you for your continued participation in UL's TPTDP.

#Auditor#
Underwriters Laboratories, Inc.
Email: #AuditorEmail#
Phone: #Phone#

cc: #cc#
</cfoutput>
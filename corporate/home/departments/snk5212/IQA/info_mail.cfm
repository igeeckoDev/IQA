<cfset DayofMonth = #Dateformat(now(), 'dd')#>
<cfset Month = #Dateformat(now(), 'mm')#>

<cfif Month is 01 or Month is 07>
<cfif DayofMonth is 01>

<cfmail to="Volker.R.Kotscha@ul.com, Keith.A.Mowry@ul.com, Rodney.E.Morton@ul.com, Debra.Modra@ul.com, Werner.Haab@ul.com, Gunsimarbir.Paintal@ul.com, Gururaj.R@ul.com, Thomas.Kestner@ul.com, Martin.Wang@ul.com, KwangTai.Kim@ul.com, Renata.Carrazedo@ul.com" from="Internal.Quality_Audits@ul.com" Subject="Information Request">

Facilities Director & Regional Quality Managers,

This notification is sent monthly to request updates on facility changes and/or quality system impacting changes.  We would appreciate a response within 5 days. If you have any questions, please contact Kai Huang, at ext 11536.

Please use the following link to respond:
http://#CGI.SERVER_NAME#/departments/snk5212/iqa/info.cfm

Facilities (and RQM's if info known):
Are there any planned moves of facilities or lab areas this quarter?

Are there any new facilities being opened this quarter?

RQM's
Are there any changes to your regions that may impact the Quality Management System? (eg. new functions added or deleted, major process changes, organizational changes, etc)

Are there any areas not yet scheduled that you recommend scheduling?

</cfmail>
</cfif>
</cfif>

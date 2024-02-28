
<cfcontent type='application/vnd.ms-excel'>
<table border='1'>
<tr align='center' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
	<th>Form Row ID</th>
	<th>Lead Auditor Name</th>
	<th>Lead Auditor Email</th>
	<th>Lead Auditor's Manager Email</th>
	<th>Reviewer Name</th>
	<th>Reviewer Email</th>
	<th>Date Posted</th>
	<th>DA File Number</th>
	<th>Project Number</th>
	<th>Program Audited</th>
	<th>Assessment Type</th>
	<th>Requires Review</th>
	<th>Review Status</th>
	<th>ROverall Status</th>
	<th>Review Comments</th>
	<th>Review Comments Date, Name</th>
</tr> 

<tr valign='top' align='left' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
<td>2</td>
	<td>Bob</td>
	<td>BobEmail</td>
	<td>BobManagerEmail</td>
	<td>Christopher.J.Nicastro@ul.com</td>
	<td>Christopher.J.Nicastro@ul.com</td>
	<td>05/27/2016</td>
	<td>DA2</td>
	<td>4787212121</td>
	<td>CTDP</td>
	<td>Annual</td>
	<td>
	<Cfif RequiresReview eq 'Yes'>
			Yes
		<cfelse>
			No
		</Cfif>
	</td>
	<td>
		<cfif RequiresReview eq 'Yes'>
			<cfif ResultsSent eq 'Yes'>
				Review Completed
			<cfelse>
				Review Not Completed
			</cfif>
		<cfelse>
			N/A
		</cfif>
	</td>
	<td>
		<cfif ResultsSent eq 'Yes'>
			Results Sent (05/31/2016)
		<cfelse>
			--
		</cfif>
	</td>
	<td><cfif Len(RequiresReviewComments)>N/A<cfelse>--</cfif></td>
	<td><cfif Len(RequiresReview_CompletedDate)>05/31/2016, by Christopher Nicastro<cfelse>--</cfif></td>
</tr></table>

<tr valign='top' align='left' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
<td>4</td>
	<td>Test 2</td>
	<td>Test@ul.com</td>
	<td>TestManager@ul.com</td>
	<td>Christopher.J.Nicastro@ul.com</td>
	<td>Christopher.J.Nicastro@ul.com</td>
	<td>05/31/2016</td>
	<td>DA1234</td>
	<td>4787000000</td>
	<td>CTF</td>
	<td>Annual</td>
	<td>
	<Cfif RequiresReview eq 'Yes'>
			Yes
		<cfelse>
			No
		</Cfif>
	</td>
	<td>
		<cfif RequiresReview eq 'Yes'>
			<cfif ResultsSent eq 'Yes'>
				Review Completed
			<cfelse>
				Review Not Completed
			</cfif>
		<cfelse>
			N/A
		</cfif>
	</td>
	<td>
		<cfif ResultsSent eq 'Yes'>
			Results Sent (06/01/2016)
		<cfelse>
			--
		</cfif>
	</td>
	<td><cfif Len(RequiresReviewComments)>Testing Comments123<cfelse>--</cfif></td>
	<td><cfif Len(RequiresReview_CompletedDate)>06/01/2016, by Christopher Nicastro<cfelse>--</cfif></td>
</tr></table>

<tr valign='top' align='left' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
<td>5</td>
	<td>Test 3</td>
	<td>Test@ul.com</td>
	<td>TestManager@ul.com</td>
	<td>Christopher J Nicastro</td>
	<td>Christopher.J.Nicastro@ul.com</td>
	<td>05/31/2016</td>
	<td>DA123</td>
	<td>4786555444</td>
	<td>TCP</td>
	<td>Annual</td>
	<td>
	<Cfif RequiresReview eq 'Yes'>
			Yes
		<cfelse>
			No
		</Cfif>
	</td>
	<td>
		<cfif RequiresReview eq 'Yes'>
			<cfif ResultsSent eq 'Yes'>
				Review Completed
			<cfelse>
				Review Not Completed
			</cfif>
		<cfelse>
			N/A
		</cfif>
	</td>
	<td>
		<cfif ResultsSent eq 'Yes'>
			Results Sent (05/31/2016)
		<cfelse>
			--
		</cfif>
	</td>
	<td><cfif Len(RequiresReviewComments)>N/A<cfelse>--</cfif></td>
	<td><cfif Len(RequiresReview_CompletedDate)>, by <cfelse>--</cfif></td>
</tr></table>

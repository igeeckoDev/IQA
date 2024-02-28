<!--- For Program Summary Expand/Collapse --->
<style type="text/css">
.togList
{
font-family: verdana;
font-size: 11px;
}

.togList dt
{
cursor: pointer; cursor: hand;
}

.togList dt span
{
font-family: verdana;
font-size: 11px;
}

.togList dd
{
width: 700px;
padding-bottom: 0px;
}

html.isJS .togList dd
{
display: none;
}
</style>

<!--- for CAR FAQ Question List expand/collapse --->
<script type="text/javascript">
/* Only set closed if JS-enabled */
document.getElementsByTagName('html')[0].className = 'isJS';

function tog2(dt)
{
var display, dd=dt;
/* get dd */
do{ dd = dd.nextSibling } while(dd.tagName!='DD');
toOpen =!dd.style.display;
dd.style.display = toOpen? 'block':''
dt.getElementsByTagName('span')[0].innerHTML
= toOpen? '<a>Hide [-]</a>':'<a>View CAR FAQs [+]</a>' ;
}
</script>

<cfset indent = "&nbsp;::">
<cfset HeadingWidth = 200>
<cfset TopicWidth = 160>
<cfset subTopicWidth = 125>
<cfset subTopicWidth2 = 75>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT *
FROM CAR_FAQ
WHERE Status IS NULL
AND ID > 0
ORDER BY ID
</cfquery>

<dl class="togList">
<b>View CAR FAQ Questions</b><br>
<dt onclick="tog2(this)"><span><a>View CAR FAQs [+]</a></span></dt>
<dd>
<br>
<cfoutput query="FAQ">
	<a href="FAQ.cfm###ID#">## #ID#</a> - #question#<br>
</cfoutput>
</dd>
</dl><br>

<table width="800" border="0">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

Please click a box to navigate to an area of interest.<br><br>

<!--- more/hide code --->
<script type="text/javascript">
/* Only set closed if JS-enabled */
document.getElementsByTagName('html')[0].className = 'isJS';

function tog(dt)
{
var display, dd=dt;
/* get dd */
do{ dd = dd.nextSibling } while(dd.tagName!='DD');
toOpen =!dd.style.display;
dd.style.display = toOpen? 'block':''
dt.getElementsByTagName('span')[0].innerHTML
= toOpen? '<a>Hide [-]</a>':'<a>More [+]</a>' ;
}
</script>

<cfoutput>
<!--- Heading Table --->
<table width="600" border="0" style="border-collapse: collapse;">
<tr>
	<td align="center">
		<div align="center">
			<A href="FAQ.cfm?##OwnerHeading">
				<img src="FAQImages\New\Owner Heading.png" border="0">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="FAQ.cfm?##ChampionHeading">
				<img src="FAQImages\New\Champion Heading.png" border="0">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="FAQ.cfm?##CreatingHeading">
				<img src="FAQImages\New\Create Heading.png" border="0">
			</a>
		</div>
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- CAR Owner Table --->
<table width="600" border="0">
<tr>
	<td colspan="3" align="center">
		<a name="OwnerHeading"></a>
		<A href="FAQ.cfm?##Owner">
			<img src="FAQImages\New\Owner Heading.png" border="0">
		</a>
		<br><br>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<A href="FAQ.cfm?##General">
			<div style="position: relative; left: 50px;">
				<img src="FAQImages\New\General.png" border="0">
				<br><br>
			</div>
		</a>
	</td>
	<td valign="top" align="center">
		<A href="FAQ.cfm?##Finding">
			<img src="FAQImages\New\Finding.png" border="0">
		<br><br>
		</a>
	</td>
	<td valign="top" align="center">
		<a name="ObservationHeading"></a>

		<a href="FAQ.cfm?##Observation">
			<div style="position: relative; right: 50px;">
				<img src="FAQImages\New\Observation.png" border="0">
				<br><br>
			</div>
		</a>
	</td>
</tr>
<!--- Navigation --->
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- CAR Champion Table --->
<table width="600" border="0">
<tr>
	<td colspan="4" align="center">
		<div align="center">
			<a name="ChampionHeading"></a>
			<A href="FAQ.cfm?##Champion">
				<img src="FAQImages\New\Champion Heading.png" border="0">
			</a>
		</div>
		<br><br>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<A href="FAQ.cfm?##Before">
			<img src="FAQImages\New\Before CAR Assignment.png" border="0">
			<br><br>
		</a>

	</td>
	<td valign="top" align="center">
		<A href="FAQ.cfm?##Processing">
			<img src="FAQImages\New\CAR Processing.png" border="0">
			<br><br>
		</a>
	</td>
	<td valign="top" align="center">
		<A href="FAQ.cfm?##Closing">
			<img src="FAQImages\New\Closing and Verifying CARs.png" border="0">
			<br><br>
		</a>
	</td>
	<td valign="top" align="center">
		<A href="FAQ.cfm?##Resources">
			<img src="FAQImages\New\CAR Champion Resources.png" border="0">
			<br><br>
		</a>
	</td>
</tr>
<tr>
	<td colspan="4">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- Creating a CAR Table --->
<table width="600" border="0">
<tr>
	<td colspan="2" align="center">
		<div align="center">
			<a name="CreatingHeading"></a>
			<a href="FAQ.cfm?##Creating">
				<img src="FAQImages\New\Create Heading.png" border="0">
			</a>
		</div>
		<br><br>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<div style="position: relative; left: 75px;">
			<a href="FAQ.cfm?##How">
				<img src="FAQImages\New\How to Create a CAR.png" border="0">
				<br><br>
			</a>
		</div>
	</td>
	<td valign="top" align="center">
		<div style="position: relative; right: 75px;">
			<a href="FAQ.cfm?##Selections">
				<img src="FAQImages\New\CAR Field Selections.png" border="0">
				<br><br>
			</a>
		</div>
	</td>
</tr>
<tr>
	<td colspan="2" align="right">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ
	</td>
</tr>
<tr>
	<td colspan="2">
		<hr class="faded" />
	</td>
</tr>
</table>
<br><br>

<table width="800">
<tr>
	<td>
<!--- CAR Owners --->
<!--- General --->
<a name="Owner"></a>
<a name="General"></a>
<a name="15"></a>

<img src="FAQImages\New\Owner Heading.png" border="0" width="100">
<img src="FAQImages\New\General.png" border="0" width="100"><br><br>
</cfoutput>

<cfinclude template="FAQ15_New.cfm">

<hr class="faded" />

Finding CAR: High-level Flow<br><br>

<cfinclude template="FAQ15.cfm">
</td>
</tr>
</TABLE>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="FindingDetail"></a>
<!--- CAR Owners --->
<!--- Finding CAR --->
<img src="FAQImages\New\Owner Heading.png" border="0" width="100">
<img src="FAQImages\New\Finding.png" border="0" width="100"><br><br>

<b>Finding CARs</b> – Finding CARs require that all sections of the CAR are completed, including:<br>
<ul class=arrow3>
	<li class=arrow3>Analysis [<a href="FAQ.cfm?#18">View</a>]</li>
	<li class=arrow3>Root Cause statement [<a href="FAQ.cfm?#19">View</a>]</li>
	<li class=arrow3>Scope of Nonconformance [<a href="FAQ.cfm?#17">View</a>]</li>
	<li class=arrow3>Corrective Action Plan [<a href="FAQ.cfm?#20">View</a>]</li>
	<li class=arrow3>Milestones
		<ul class=arrow3>
			<li class=arrow3>Milestones fully address the nonconformance and all steps of CAP.</li>
			<li class=arrow3>They consist of appropriate steps with appropriate timeline.</li>
			<li class=arrow3>You can combine pieces of the corrective action plan into one milestone
				<ul class=arrow3>
					<li class=arrow3>It is often effective to group related actions into one milestone.</li>
					<li class=arrow3>Example: For a document update, (1) the draft along with (2) stakeholder comments and (3) evidence of submission to document control can all be in one milestone instead of three separate milestones.</li>
				</ul>
			</li>
			<li class=arrow3>You may attach records, documents, links, etc. within each milestone.</li>
			<li class=arrow3>Supporting evidence is required to demonstrate the completion of the milestone.</li>
			<li class=arrow3>Containment milestone
				<ul class=arrow3>
					<li class=arrow3>Containment usually is the first milestone.</li>
					<li class=arrow3>It is the immediate short term action that “stops the bleeding” and contains the problem and/or captures impacted records until the permanent fix is implemented.</li>
					<li class=arrow3>Containment is usually required.  However, if containment is not required, explain the rationale in the Corrective Action Plan or Analysis section of the CAR.</li>
				</ul>
			</li>
			<li class=arrow3>Owner’s Verification of Effectiveness milestone
				<ul class=arrow3>
					<li class=arrow3>Owners must verify the effectiveness of the implemented corrective actions before CAR is closed.</li>
					<li class=arrow3>They must ensure that the corrective action worked to prevent the problem from happening again.</li>
					<li class=arrow3>They must ensure that new problems have not been created as a result of the corrective actions.</li>
				</ul>
			</li>
			<li class=arrow3>Interim Verification milestone<br>
			An Interim Verification milestone is required at each 3 month interval of milestone dates.  Interim Verification milestones:
				<ul class=arrow3>
					<li class=arrow3>Verify that the corrective action plan is still reasonable and effective</li>
					<li class=arrow3>Determines if modifications to the corrective action plan are needed</li>
				</ul>
			Therefore a CAR may have more than one Interim Verification milestone.  Interim Verification milestones address:
				<ul class=arrow3>
					<li class=arrow3>The appropriateness of the corrective actions for the current business direction</li>
					<li class=arrow3>The effectiveness of the actions that have been implemented to date</li>
					<li class=arrow3>Progress/timeliness of the corrective actions</li>
				</ul>
			</li>
		</ul>
	</li>
</ul><br><br>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#FindingDetail">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		Finding CAR<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="18"></a>
<!--- CAR Owners --->
<!--- Finding CAR --->
<img src="FAQImages\New\Finding.png" border="0" width="100">
<img src="FAQImages\New\Analysis.png" border="0" width="100"><br><Br>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_FAQ
WHERE ID = 18
</cfquery>

<Table width="700">
<cfoutput query="FAQ">
	 <tr>
 		<td class="blog-content">
		<B>#ID# - #question#</B>
		<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
			[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
		</cfif>

		<Br><Br>
		#Content#<Br><br>

		<cfif len(AttachedFile)>
			<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
		</cfif>

		<cfif include is "Yes">
			<cfinclude template="FAQ#ID#.cfm"><br><br>
		</cfif>
	</td>
	</tr>
</cfoutput>
</TABLE>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#FindingDetail">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		Finding CAR<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="17"></a>
<img src="FAQImages\New\Finding.png" border="0" width="100">
<img src="FAQImages\New\Scope.png" border="0" width="100"><br>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_FAQ
WHERE ID = 17
</cfquery>

<Table width="700">
<cfoutput query="FAQ">
	 <tr>
 		<td class="blog-content">
		<B>#ID# - #question#</B>
		<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
			[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
		</cfif>

		<Br><Br>
		#Content#<Br><br>

		<cfif len(AttachedFile)>
			<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
		</cfif>

		<cfif include is "Yes">
			<cfinclude template="FAQ#ID#.cfm"><br><br>
		</cfif>
	</td>
	</tr>
</cfoutput>
</TABLE>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#FindingDetail">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		Finding CAR<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="19"></a>
<img src="FAQImages\New\Finding.png" border="0" width="100">
<img src="FAQImages\New\Root Cause.png" border="0" width="100"><br>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_FAQ
WHERE ID = 19
</cfquery>

<Table width="800">
<cfoutput query="FAQ">
	 <tr>
 		<td class="blog-content">
		<B>#ID# - #question#</B>
		<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
			[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
		</cfif>

		<Br><Br>
		#Content#<Br><br>

		<cfif len(AttachedFile)>
			<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
		</cfif>

		<cfif include is "Yes">
			<cfinclude template="FAQ#ID#.cfm"><br><br>
		</cfif>
	</td>
	</tr>
</cfoutput>
</TABLE>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#FindingDetail">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		Finding CAR<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<img src="FAQImages\New\Finding.png" border="0" width="100">
<img src="FAQImages\New\Corrective Action Plan.png" border="0" width="100"><br>

<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_FAQ
WHERE ID = 20
</cfquery>

<Table width="800">
<cfoutput query="FAQ">
	 <tr>
 		<td class="blog-content">

		<a name="#ID#"></a>
		<B>#ID# - #question#</B>
		<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
			[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
		</cfif>

		<Br><Br>
		#Content#<Br><br>

		<cfif len(AttachedFile)>
			<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
		</cfif>

		<cfif include is "Yes">
			<cfinclude template="FAQ#ID#.cfm"><br><br>
		</cfif>
	</td>
	</tr>
</cfoutput>
</TABLE>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#FindingDetail">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		Finding CAR<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="ObsDetail"></a>
<a name="37"></a>
<!--- CAR Owners --->
<!--- Observation CAR --->
<cfoutput>
<img src="FAQImages\New\Owner Heading.png" border="0" width="100">
<img src="FAQImages\New\Observation.png" border="0" width="100"><br><br>

<B>37 - What is required for an Observation CAR?</B><br><br>

<b>Observation CARs</b><br>
The CAR owner fixes the problem found in the nonconformance. Observation CARs require that all sections of the CAR are completed including analysis, root cause statement, scope of nonconformance, corrective action plan and milestones.<br><br>

<ol class=arrow3 type=1>
	<li class=arrow3>The CAR Owner fixes the problem that is identified in the “Objective Evidence”.  This may mean updating a datasheet, publishing a document in Document Control, updating an employee’s qualifications in the Technical Competency Database, etc.
		<ol class=arrow3 type=a>
			<li class=arrow3>Within Observation CARs, the owner is to only fix the problem noted.</li>
			<li class=arrow3>Additional enhancements are encouraged, but must be completed outside of the CAR database.</li>
		</ol>
	</li>
	<li class=arrow3>Analysis for an Observation CAR determines “why” the nonconformance occurred.  If there was human error, do more analysis to determine why the error occurred and capture that reasoning.</li>
	<li class=arrow3>Root Cause statement flows from the analysis, and states succinctly why the nonconformance occurred.</li>
	<li class=arrow3>Scope of Nonconformance for an Observation CAR is the objective evidence for the nonconformance plus any additional evidence found during the analysis.</li>
	<li class=arrow3>The CAR Owner completes the “Corrective Action Plan” by detailing how they will fix the “Objective Evidence”.</li>
	<li class=arrow3>The CAR Owner creates milestones to carry out the “Corrective Action Plan”.</li>
	<li class=arrow3>The action taken to fix the nonconformance is generally considered Containment.  Additional containment may be required if the correction is delayed.</li>
	<li class=arrow3>An Owner’s Verification milestone is NOT required and is not to be included.</li>
</ol>
</cfoutput>

</TABLE>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		Top of FAQ<br><br>
	</td>
	<td align="right" valign="top" width="80">
		<A href="FAQ.cfm?#General">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<Table border="0" width="800">
<tr>
<td>

<!--- CAR Champion --->
<cfoutput>
<a name="Champion"></a>
<a name="Before"></a>
<img src="FAQImages\New\Champion Heading.png" border="0" width="100">
<img src="FAQImages\New\Before CAR Assignment.png" border="0" width="100">
<br><br>

<cfloop list="3,1,4,2,24,36,5" index="listElement">

	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
</cfoutput>
</td>
</tr>
</table>

<cfloop list="3,1,4,2,24,36,5" index="listElement">
	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<Table width="800">
	<cfoutput query="FAQ">
		 <tr>
	 		<td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
				</cfif>

				<Br><Br>
				#Content#<Br><br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<cfinclude template="FAQ#ID#.cfm"><br><br>
				</cfif>
			</td>
		</tr>
	</cfoutput>
	</TABLE>
	<!--- end of section navigation break --->
	<Table width="800">
	<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm">
				<img src="FAQImages\Main Index.png" border="0" width="25">
			</a><br>
			Top of FAQ<br><br>
		</td>
		<td align="right" valign="top" width="110">
			<A href="FAQ.cfm?#Before">
				<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
			</a><br>
			Before CAR Assignment
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- CAR Champion / CAR Processing --->
<cfoutput>
<a name="Processing"></a>
<img src="FAQImages\New\Champion Heading.png" border="0" width="100">
<img src="FAQImages\New\CAR Processing.png" border="0" width="100">
<br><br>

<cfloop list="26,6,21,8,7,10,11,35,34,9,38" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
</cfoutput>

<cfloop list="26,6,21,8,7,10,11,35,34,9,38" index="listElement">
	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<Table width="800">
	<cfoutput query="FAQ">
		 <tr>
	 		<td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
				</cfif>

				<Br><Br>
				#Content#<Br><br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<cfinclude template="FAQ#ID#.cfm"><br><br>
				</cfif>
			</td>
		</tr>
	</cfoutput>
	</table>
	<!--- end of section navigation break --->
	<Table width="800">
	<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm">
				<img src="FAQImages\Main Index.png" border="0" width="25">
			</a><br>
			Top of FAQ<br><br>
		</td>
		<td align="right" valign="top" width="110">
			<A href="FAQ.cfm?#Processing">
				<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
			</a><br>
			CAR Processing
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- CAR Champion / Closing and Verifying --->
<cfoutput>
<a name="Closing"></a>
<img src="FAQImages\New\Champion Heading.png" border="0" width="100">
<img src="FAQImages\New\Closing and Verifying CARs.png" border="0" width="100">
<br><br>

<cfloop list="12,22,27" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
</cfoutput>

<cfloop list="12,22,27" index="listElement">
	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<Table width="800">
	<cfoutput query="FAQ">
		 <tr>
	 		<td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
				</cfif>

				<Br><Br>
				#Content#<Br><br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<cfinclude template="FAQ#ID#.cfm"><br><br>
				</cfif>
			</td>
		</tr>
	</cfoutput>
	</TABLE>
	<!--- end of section navigation break --->
	<Table width="800">
	<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm">
				<img src="FAQImages\Main Index.png" border="0" width="25">
			</a><br>
			Top of FAQ<br><br>
		</td>
		<td align="right" valign="top" width="100">
			<A href="FAQ.cfm?#Closing">
				<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
			</a><br>
			Closing and Verifying CARs
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- CAR Champion / Resources --->
<cfoutput>
<a name="Resources"></a>
<img src="FAQImages\New\Champion Heading.png" border="0" width="100">
<img src="FAQImages\New\CAR Champion Resources.png" border="0" width="100">
<br><br>

<cfloop list="25,30,31,32,33" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
</cfoutput>

<cfloop list="25,30,31,32,33" index="listElement">
	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<Table width="800">
	<cfoutput query="FAQ">
		 <tr>
	 		<td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
				</cfif>

				<Br><Br>
				#Content#<Br><br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<cfinclude template="FAQ#ID#.cfm"><br><br>
				</cfif>
			</td>
		</tr>
	</cfoutput>
	</table>
	<!--- end of section navigation break --->
	<Table width="800">
	<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm">
				<img src="FAQImages\Main Index.png" border="0" width="25">
			</a><br>
			Top of FAQ<br><br>
		</td>
		<td align="right" valign="top" width="100">
			<A href="FAQ.cfm?#Resources">
				<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
			</a><br>
			CAR Champion Resources
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- Creating a CAR / How to Create a CAR --->
<cfoutput>
<a name="Creating"></a>
<a name="How"></a>
<img src="FAQImages\New\Create Heading.png" border="0" width="100">
<img src="FAQImages\New\How to Create a CAR.png" border="0" width="100">
<br><br>

<!--- hide since there is only one item
<cfloop list="29" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
--->
</cfoutput>


<cfloop list="29" index="listElement">
	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<Table width="800">
	<cfoutput query="FAQ">
		 <tr>
	 		<td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
				</cfif>

				<Br><Br>
				#Content#<Br><br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<cfinclude template="FAQ#ID#.cfm"><br><br>
				</cfif>
			</td>
		</tr>
	</cfoutput>
	</table>
	<!--- end of section navigation break --->
	<Table width="800">
	<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm">
				<img src="FAQImages\Main Index.png" border="0" width="25">
			</a><br>
			Top of FAQ<br><br>
		</td>
		<td align="right" valign="top" width="100">
			<A href="FAQ.cfm?#Creating">
					<img src="FAQImages\Creating a CAR Index.png" border="0" width="25">
				</a><br>
				Create a CAR
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- Creating a CAR / CAR Field Selections --->
<cfoutput>
<a name="Selections"></a>
<img src="FAQImages\New\Create Heading.png" border="0" width="100">
<img src="FAQImages\New\CAR Field Selections.png" border="0" width="100">
<br><br>

<cfloop list="16,13,14" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
</cfoutput>

<cfloop list="16,13,14" index="listElement">
	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<Table width="800">
	<cfoutput query="FAQ">
		 <tr>
	 		<td class="blog-content">
				<a name="#ID#"></a>
				<B>#ID# - #question#</B>
				<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
					[<a href="#CARAdminDir#editFAQ.cfm?ID=#ID#">edit</a>]</a>
				</cfif>

				<Br><Br>
				#Content#<Br><br>

				<cfif len(AttachedFile)>
					<a href="FAQ\#AttachedFile#"><b>View</b></a> #AttachedFile#<br /><br />
				</cfif>

				<cfif include is "Yes">
					<cfinclude template="FAQ#ID#.cfm"><br><br>
				</cfif>
			</td>
		</tr>
	</cfoutput>
	</table>

	<!--- end of section navigation break --->
	<Table width="800">
	<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm">
				<img src="FAQImages\Main Index.png" border="0" width="25">
			</a><br>
			Top of FAQ<br><br>
		</td>
		<td align="right" valign="top" width="120">
			<A href="FAQ.cfm?#Selections">
					<img src="FAQImages\Creating a CAR Index.png" border="0" width="25">
				</a><br>
				CAR Field Selections
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<hr class="faded" />
		</td>
	</tr>
	</table>

</cfloop>
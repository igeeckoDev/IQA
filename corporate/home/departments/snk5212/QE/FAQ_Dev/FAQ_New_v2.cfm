<!--- Start of Page File --->
<cfset subTitle = "Frequently Asked Questions (FAQ)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

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

<cfset indent = "&nbsp;::">
<cfset HeadingWidth = 200>
<cfset TopicWidth = 160>
<cfset subTopicWidth = 125>
<cfset subTopicWidth2 = 75>

<cfoutput>

<!--- Heading Table --->
<table width="800" border="0">
<tr>
	<td align="center">
		<div align="center">
			<A href="FAQ_New.cfm?##OwnerHeading">
				<img src="FAQImages\CAR Owner 2.png" border="0" width="#HeadingWidth#">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="FAQ_New.cfm?##ChampionHeading">
				<img src="FAQImages\CAR Champion 2.png" border="0" width="#HeadingWidth#">
			</a>
		</div>
	</td>
	<td align="center">
		<div align="center">
			<A href="FAQ_New.cfm?##CreatingHeading">
				<img src="FAQImages\Creating a CAR 2.png" border="0" width="#HeadingWidth#">
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
<table width="800" border="0">
<tr>
	<td colspan="3" align="center">
		<a name="OwnerHeading"></a>
		<A href="FAQ_New.cfm?##Owner">
			<img src="FAQImages\CAR Owner 2.png" border="0" width="#HeadingWidth#">
		</a>
		<br><br>
	</td>
</tr>
<tr>
	<td valign="top" style="padding-left:50px">
		<A href="FAQ_New.cfm?##General">
			<img src="FAQImages\General 2.png" border="0" width="#TopicWidth#">
		<br><br>
		</a>
	</td>
	<td valign="top" style="padding-left:50px">
		<A href="FAQ_New.cfm?##Finding">
			<img src="FAQImages\Finding CAR 2.png" border="0" width="#TopicWidth#">
		<br><br>
		</a>
	</td>
	<td valign="top" style="padding-left:50px">
		<a name="ObservationHeading"></a>

		<a href="FAQ_New.cfm?##Observation">
			<img src="FAQImages\Observation CAR 2.png" border="0" width="#TopicWidth#">
			<br><br>
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
<table width="800" border="0">
<tr>
	<td colspan="4" align="center">
		<div align="center">
			<a name="ChampionHeading"></a>
			<A href="FAQ_New.cfm?##Champion">
				<img src="FAQImages\CAR Champion 2.png" border="0" width="#HeadingWidth#">
			</a>
		</div>
		<br><br>
	</td>
</tr>
<tr>
	<td valign="top" style="padding-left:20px">
		<A href="FAQ_New.cfm?##Before">
			<img src="FAQImages\Before CAR Assignment.png" border="0" width="#TopicWidth#">
			<br><br>
		</a>

	</td>
	<td valign="top" style="padding-left:20px">
		<A href="FAQ_New.cfm?##Processing">
			<img src="FAQImages\CAR Processing.png" border="0" width="#TopicWidth#">
			<br><br>
		</a>
	</td>
	<td valign="top" style="padding-left:20px">
		<A href="FAQ_New.cfm?##Closing">
			<img src="FAQImages\Closing and Verifying CARs.png" border="0" width="#TopicWidth#">
			<br><br>
		</a>
	</td>
	<td valign="top" style="padding-left:20px">
		<A href="FAQ_New.cfm?##Resources">
			<img src="FAQImages\CAR Champion Resources.png" border="0" width="#TopicWidth#">
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
<table width="800" border="0">
<tr>
	<td colspan="2" align="center">
		<div align="center">
			<a name="CreatingHeading"></a>
			<a href="FAQ_New.cfm?##Creating">
				<img src="FAQImages\Creating a CAR 2.png" border="0" width="#HeadingWidth#">
			</a>
		</div>
		<br><br>
	</td>
</tr>
<tr>
	<td valign="top" style="padding-left:110px">
		<a href="FAQ_New.cfm?##How">
			<img src="FAQImages\How to Create a CAR.png" border="0" width="#TopicWidth#">
			<br><br>
		</a>
	</td>
	<td valign="top" style="padding-left:110px">
		<a href="FAQ_New.cfm?##Selections">
			<img src="FAQImages\CAR Field Selections.png" border="0" width="#TopicWidth#">
			<br><br>
		</a>
	</td>
</tr>
<!--- Navigation --->
<tr>
	<td colspan="2">
		<hr class="faded" />
	</td>
</tr>
<tr>
	<td colspan="2" align="right">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index
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

<a href="FAQ_New.cfm?##OwnerHeading">
	<img src="FAQImages\CAR Owner 2.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\General.png" border="0" width="#SubTopicWidth#"><br><br>
</cfoutput>

<b>15. What are CAR Owner responsibilities and what resources are available to assist an owner?</b><br><br>

<dl class="togList">
<b>CAR Owner Responsibilities</b><br>
1. Accepts Responsibility for the CAR
<dt onclick="tog(this)"><span><a>More [+]</a></span></dt>
<dd>
	<ul class=arrow3>
		<li class=arrow3>CARs are assigned to the individual with the authority to resolve the issue and obtain the best result in preventing recurrence of the issue.
			<ul class=arrow3>
				<li class=arrow3>If you think that someone other than you should be the owner of a CAR, discuss this with the CAR Champion.</li>
			</ul>
		</li>
		<li class=arrow3>CAR owners often work with other UL departments to resolve CAR concerns.
			<ul class=arrow3>
				<li class=arrow3>As CAR owner, you enlist the support and approval of other UL departments for their completion of any necessary actions.  For example:
					<ul class=arrow3>
						<li class=arrow3>IT for system updates</li>
						<li class=arrow3>Document owners to make updates for policy or process exceptions</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
</dd>
</dl>

<dl class="togList">
2. Acts on CAR by due date
<dt onclick="tog(this)"><span><a>More [+]</a></span></dt>
<dd>
	<ul class=arrow3>
		<li class=arrow3>CARs will escalate to successively higher levels of CAR owner management if not addressed by due dates.</li>
		<li class=arrow3>Extensions are requested through the CAR database when due dates cannot be met.
			<ul class=arrow3>
				<li class=arrow3>CAR Champions review extension requests.</li>
				<li class=arrow3>Requests may be denied for business reasons, to meet accreditor deadlines, if sufficient CAR progress is not being made, etc.</li>
			</ul>
		</li>
		<li class=arrow3>Accreditors may require specific response timeframes.  CAR responses must meet these dates and will not be extended beyond them.</li>
	</ul>
</dd>
</dl>

<dl class="togList">
3.	May assign someone to assist with the CAR
<dt onclick="tog(this)"><span><a>More [+]</a></span></dt>
<dd>
	<ul class=arrow3>
		<li class=arrow3>A CAR owner may assign an Owner�s Assistant
			<ul class=arrow3>
				<li class=arrow3>A person designated by the CAR Owner to act on a CAR on the CAR Owner�s behalf.</li>
				<li class=arrow3>The Owner�s Assistant is given the same edit abilities for the CAR as the CAR Owner (able to input analysis, create milestones, submit implementation, request extensions, etc.).</li>
				<li class=arrow3>The CAR Owner continues to remain responsible for the CAR through closure even if an Owner�s Assistant has been designated.</li>
			</ul>
		</li>
	</ul>
</dd>
</dl>

<b>CAR Owner Assistance</b> - <a href="CAR Owner Resources.pptx" target=_blank>View presentation for the below topics</a>
<ul class=arrow3>
	<li class=arrow3>CAR Owner resources</li>
	<li class=arrow3>Assigning an Owner�s Assistant</li>
	<li class=arrow3>Attaching documents in a CAR</li>
	<li class=arrow3>CAR Database � how to access GCAR; how to search for your CARs</li>
</ul>

<dl class="togList">
<b>Observation CARs</b><br>
The CAR owner fixes the problem found in the nonconformance.  Analysis, root cause statement and scope of nonconformance are not required.
<dt onclick="tog(this)"><span><a>More [+]</a></span></dt>
<dd>
	<ol class=arrow3 type=1>
		<li class=arrow3>Fixes the problem that is identified in the �Objective Evidence�.  This may mean updating a datasheet, publishing a document in Document Control, updating an employee�s qualifications in the Technical Competency Database, etc.
			<ol class=arrow3 type=a>
				<li class=arrow3>Within Observation CARs, the owner is to only fix the problem noted.</li>
				<li class=arrow3>Additional enhancements are encouraged, but must be completed outside of the CAR database.</li>
			</ol>
		</li>
		<li class=arrow3>Completes the �Corrective Action Plan� by detailing how they will fix the �Objective Evidence�.</li>
		<li class=arrow3>Creates milestones to carry out the �Corrective Action Plan�.</li>
		<li class=arrow3>The following are NOT required for Observation CARs:
			<ul class=arrow3>
				<li class=arrow3>Analysis � Though not required, helpful information may be entered in the analysis section.  Otherwise, enter �Not Required� or similar wording.</li>
				<li class=arrow3>Root Cause statement � Enter �Not Applicable� or similar wording.</li>
				<li class=arrow3>Scope of Nonconformance � Either enter the objective evidence for the nonconformance or enter �Not Applicable� or similar wording.
					<ul class=arrow3>
						<li class=arrow3>Containment milestone is not required.</li>
						<li class=arrow3>Owner�s verification of effectiveness milestone is not required.</li>
					</ul>
				</li>
			</ul>
		</li>
	</ol>
</dd>
</dl>

<dl class="togList">
<b>Finding CARs</b> � Finding CARs require that all sections of the CAR are completed, including:<br>
<ul class=arrow3>
	<li class=arrow3>Analysis [<a href="FAQ_New.cfm?#18">View</a>]</li>
	<li class=arrow3>Root Cause statement [<a href="FAQ_New.cfm?#19">View</a>]</li>
	<li class=arrow3>Scope of Nonconformance [<a href="FAQ_New.cfm?#17">View</a>]</li>
	<li class=arrow3>Milestones
		<dt onclick="tog(this)"><span><a>More [+]</a></span></dt>
		<dd>
			<ul class=arrow3>
				<li class=arrow3>Milestones fully address the nonconformance and all steps of CAP.</li>
				<li class=arrow3>They consist of appropriate steps with appropriate timeline.</li>
				<li class=arrow3>You can combine pieces of the corrective action plan into one milestone
					<ul class=arrow3>
						<li class=arrow3>It is often effective to group related actions into one milestone.</li>
						<li class=arrow3>Example: For a document update, (1) the draft along with (2) stakeholder comments and (3) evidence of submission to KMS can all be in one milestone instead of three separate milestones.</li>
					</ul>
				</li>
				<li class=arrow3>You may attach records, documents, links, etc. within each milestone.</li>
				<li class=arrow3>Supporting evidence is required to demonstrate the completion of the milestone.</li>
				<li class=arrow3>Containment milestone
					<ul class=arrow3>
						<li class=arrow3>Containment usually is the first milestone.</li>
						<li class=arrow3>It is the immediate short term action that �stops the bleeding� and contains the problem and/or captures impacted records until the permanent fix is implemented.</li>
						<li class=arrow3>Containment is usually required.  However, if containment is not required, explain the rationale in the Corrective Action Plan or Analysis section of the CAR.</li>
					</ul>
				</li>
				<li class=arrow3>Owner�s Verification of Effectiveness milestone
					<ul class=arrow3>
						<li class=arrow3>Owners must verify the effectiveness of the implemented corrective actions before CAR is closed.</li>
						<li class=arrow3>They must ensure that the corrective action worked to prevent the problem from happening again.</li>
						<li class=arrow3>They must ensure that new problems have not been created as a result of the corrective actions.</li>
					</ul>
				</li>
				<li class=arrow3>Interim Verification milestone
					<ul class=arrow3>
						An Interim Verification milestone is required at each 3 month interval of milestone dates.  Interim Verification milestones:
						<li class=arrow3>Verify that the corrective action plan is still reasonable and effective</li>
						<li class=arrow3>Determines if modifications to the corrective action plan are needed</li>
					</ul>
				</li>
				<li class=arrow3>Interim Verification milestone
					<ul class=arrow3>
						Therefore a CAR may have more than one Interim Verification milestone.  Interim Verification milestones address:
						<li class=arrow3>The appropriateness of the corrective actions for the current business direction</li>
						<li class=arrow3>The effectiveness of the actions that have been implemented to date</li>
						<li class=arrow3>Progress/timeliness of the corrective actions</li>
					</ul>
				</li>

		</dd>
	</li>
</ul>
</dl>

<br><br>
<cfinclude template="FAQ15.cfm">
<br>
</td>
</tr>
</TABLE>

</TABLE>
<!--- break --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#OwnerHeading">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="Finding"></a>
<a name="18"></a>
<!--- CAR Owners --->
<!--- Finding CAR --->
<cfoutput>
<img src="FAQImages\Finding CAR.png" border="0" width="#SubTopicWidth#">
<img src="FAQImages\Analysis.png" border="0" width="#SubTopicWidth#"><br><Br>
</cfoutput>

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

</TABLE>
<!--- break --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<cfoutput>
<a name="17"></a>
<img src="FAQImages\Scope.png" border="0" width="#SubTopicWidth#"><br>
</cfoutput>

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

<!--- Navigation --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<cfoutput>
<a name="19"></a>
<img src="FAQImages\Root Cause.png" border="0" width="#SubTopicWidth#"><br>
</cfoutput>

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

<!--- Navigation --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<Cfoutput>
<img src="FAQImages\CAP.png" border="0" width="#SubTopicWidth#"><br>
</cfoutput>

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

<!--- Navigation --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<cfoutput>
<img src="FAQImages\Milestones.png" border="0" width="#SubTopicWidth#"><br>
</cfoutput>

Please follow the link below:<br><br>

<A href="#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/FAQ/Creates Milestones.pptx" target="_blank">#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/FAQ/Creates Milestones.pptx</a><br><Br>

<!--- Navigation --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<cfoutput>
<img src="FAQImages\Extensions.png" border="0" width="#SubTopicWidth#"><br>
</cfoutput>

Please follow the link below:<br><br>

<A href="" target="_blank">PPT</a> (Need Link)<br><Br>

</TABLE>
<!--- break --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#OwnerHeading">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<a name="Observation"></a>
<!--- CAR Owners --->
<!--- Observation CAR --->
<cfoutput>
<a href="FAQ_New.cfm?##OwnerHeading">
	<img src="FAQImages\CAR Owner Heading.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\Observation CAR.png" border="0" width="#SubTopicWidth#"><br><br>

 :: Observation CARs - PPT<br><br>
</cfoutput>

</TABLE>
<!--- break --->
<Table width="800">
<tr>
	<td>
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#OwnerHeading">
			<img src="FAQImages\CAR Owner Index.png" border="0" width="25">
		</a><br>
		CAR Owner Index
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

<a href="FAQ_New.cfm?##ChampionHeading">
	<img src="FAQImages\CAR Champion.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\Before CAR Assignment.png" border="0" width="#SubTopicWidth#">
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
	<!--- break --->
	<Table width="800">
	<tr>
		<td>
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#ChampionHeading">
			<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
		</a><br>
		CAR Champion Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- CAR Champion / CAR Processing --->
<cfoutput>
<a name="Processing"></a>

<a href="FAQ_New.cfm?##ChampionHeading">
	<img src="FAQImages\CAR Champion.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\CAR Processing.png" border="0" width="#SubTopicWidth#">
<br><br>

<cfloop list="26,6,21,8,7,10,11,35,34,9" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
</cfoutput>

<cfloop list="26,6,21,8,7,10,11,35,34,9" index="listElement">
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
	<!--- break --->
	<Table width="800">
	<tr>
		<td>
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#ChampionHeading">
			<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
		</a><br>
		CAR Champion Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- CAR Champion / Closing and Verifying --->
<cfoutput>
<a name="Closing"></a>

<a href="FAQ_New.cfm?##ChampionHeading">
	<img src="FAQImages\CAR Champion.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\Closing and Verifying CARs.png" border="0" width="#SubTopicWidth#">
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
	<!--- break --->
	<Table width="800">
	<tr>
		<td>
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#ChampionHeading">
			<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
		</a><br>
		CAR Champion Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- CAR Champion / Resources --->
<cfoutput>
<a name="Resources"></a>

<a href="FAQ_New.cfm?##ChampionHeading">
	<img src="FAQImages\CAR Champion.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\CAR Champion Resources.png" border="0" width="#SubTopicWidth#">
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
	</TABLE>
	<!--- break --->
	<Table width="800">
	<tr>
		<td>
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="110">
		<A href="FAQ_New.cfm?#ChampionHeading">
			<img src="FAQImages\CAR Champion Index.png" border="0" width="25">
		</a><br>
		CAR Champion Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- Creating a CAR / How to Create a CAR --->
<cfoutput>
<a name="Creating"></a>
<a name="How"></a>

<a href="FAQ_New.cfm?##CreatingHeading">
	<img src="FAQImages\Creating a CAR.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\How to Create a CAR.png" border="0" width="#SubTopicWidth#">
<br><br>

<cfloop list="29" index="listElement">
	<cfquery name="FAQTitle" datasource="Corporate" blockfactor="100">
	SELECT Question
	FROM CAR_FAQ
	WHERE ID = #listElement#
	</cfquery>

	<a href="#CGI.ScriptName#?###listElement#">## #listElement#</a> - #FAQTitle.Question#<br>
</cfloop><br>

<hr class="faded" />
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
	</table>
	</cfoutput>
	<!--- Navigation --->
	<Table width="800">
	<tr>
		<td>
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="125">
		<A href="FAQ_New.cfm?#CreatingHeading">
				<img src="FAQImages\Creating a CAR Index.png" border="0" width="25">
			</a><br>
			Creating a CAR Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- Creating a CAR / CAR Field Selections --->
<cfoutput>
<a name="Selections"></a>

<a href="FAQ_New.cfm?##CreatingHeading">
	<img src="FAQImages\Creating a CAR.png" border="0" width="#SubTopicWidth#"></a>

<img src="FAQImages\CAR Field Selections.png" border="0" width="#SubTopicWidth#">
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
	<!--- Navigation --->
	<Table width="800">
	<tr>
		<td>
			<hr class="faded" />
		</td>
	</tr>
	</table>
</cfloop>

<!--- end of section navigation break --->
<Table width="800">
<tr>
	<td align="left">
		&nbsp;
	</td>
	<td align="right" valign="top" width="120">
		<A href="FAQ_New.cfm">
			<img src="FAQImages\Main Index.png" border="0" width="25">
		</a><br>
		CAR FAQ Index<br><br>
	</td>
	<td align="right" valign="top" width="125">
		<A href="FAQ_New.cfm?#CreatingHeading">
				<img src="FAQImages\Creating a CAR Index.png" border="0" width="25">
			</a><br>
			Creating a CAR Index
	</td>
</tr>
<tr>
	<td colspan="3">
		<hr class="faded" />
	</td>
</tr>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
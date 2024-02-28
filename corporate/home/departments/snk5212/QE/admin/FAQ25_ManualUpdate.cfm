<cfset textBlurb = "<strong>Repeat CARs</strong><br>
There are specific actions required when addressing certain repeat nonconformance CARs.  Please contact the CAR Process Owner – Denise Echols, or Cheryl Adams for the specific actions to be taken for these CARs.<br><br>

<u>Standard, Edition and Date</u> – This applies to CARs written due to inconsistencies found regarding the standard, edition, and/or date on datasheets, test records, or the communication of scope to the client.  <i><u>This does NOT include testing done to the wrong standard.</u></i><br><br>

<u>Communication of Scope</u> – This applies to CARs regarding missing and/or erroneous communication of scope to the client.<br><br>

<strong>Global CARs - Please note that we currently do not have any active Global CARs.</strong><br />
A Global CAR is one whose nonconformance:
<ul class='arrow3'>
    <li class='arrow3'>Involves more than one function, business unit, and/or location,</li>
    <li class='arrow3'>Has repeat issues that have not been fully addressed, and,</li>
    <li class='arrow3'>Would benefit from an investigation and resolution provided by a cross-functional team of business and quality experts</li>
</ul>
<br />
The CAR Process Owner decides what concerns qualify as a global CAR. Among the considerations are:
<ul class='arrow3'>
    <li class='arrow3'>One or more previous CARs have attempted to address the issue but the resolutions were not effective or only partially effective. This may be indicated by a CAR being verified as ineffective.</li>
    <li class='arrow3'>A concern is being addressed via a CAR whose impact is significant for UL and widespread throughout the company. The concern may impact UL customers, accreditations or business effectiveness.</li>
    <li class='arrow3'>Multiple CARs may exist that cover various aspects of one process. The concerns may be more completely and effectively addressed by one comprehensive CAR that includes representation for all stakeholders and functions.</li>
</ul>
<br />
The CAR Process Owner:
<ul class='arrow3'>
    <li class='arrow3'>Approves the direction of the global CAR team and empowers them to conduct a detailed analysis and provide recommendations for nonconformance resolution.</li>
    <li class='arrow3'>Ensures that the team is composed of the various subject matter and quality experts needed.</li>
</ul>
<br />
<strong><u>Process</u></strong>
<ul class='arrow3'>
    <li class='arrow3'>The CAR team performs detailed data analysis.
    <ul class='arrow3'>
        <li class='arrow3'>The true root cause(s) and the scope of the concern are determined</li>
        <li class='arrow3'>Corrective actions are established</li>
        <li class='arrow3'>The CAR may be created as the result of a previous CAR that was verified as ineffective or may be created as a new CAR.</li>
    </ul>
    </li>
    <li class='arrow3'>There may be new or existing CARs written that fall within the scope of the Global CAR.
    <ul class='arrow3'>
        <li class='arrow3'>The CAR owner must perform an analysis that indicates the CAR is a part of the scope of the global CAR. If the concern fits within the scope of the global CAR, the analytical information is presented to Quality Engineering (Christopher Nicastro) for approval to be treated as a part of the global CAR.<br /><br />
        NOTE: There must be evidence provided that clearly shows the CAR is within the scope of the global CAR. No CAR will be accepted without this evidence being provided.<br><Br></li>
        <li class='arrow3'>CARs that are within the scope of the global CAR are treated as observations and point to the global CAR for the long-term resolution.<br /><br />
        NOTE: This does not mean that the classification of the CAR is changed from &ldquo;Finding&rdquo; to &ldquo;Observation&rdquo;. It means that a Finding CAR is treated as an observation and includes an explanation providing the rationale.<br><br></li>
        <li class='arrow3'>A thorough final verification of the effectiveness of the corrective actions is performed by members of the CAR team. The verification must include data covering the entire scope of the concern &ndash; all functions, business units, locations, etc. that were identified. The verification must also include evidence that each root cause was effectively addressed.</li>
    </ul>
    </li>
</ul>">

<CFQUERY BLOCKFACTOR="100" name="DistributionDetails" Datasource="Corporate">
update corporate.CAR_FAQ
SET
Content = <CFQUERYPARAM VALUE="#textBlurb#" CFSQLTYPE="cf_sql_clob">
WHERE ID = 25
</cfquery>
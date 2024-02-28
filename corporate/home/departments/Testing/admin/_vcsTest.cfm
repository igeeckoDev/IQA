<!--- date is YYYYMMDD ---->
<!--- required variables: StartDate, endDate, category, Summary --->

<cfset newLine = "#chr(13)##chr(10)#">
<cfset startDate = "20110928">
<cfset endDate = "20110928">
<cfset category = "Technical Audit XYZ Task ABC">
<cfset summary = "Summary of Task">
<cfset notes = "Notes go here">

<cffile 
    action="write" 
    file="#IQAPath_Admin#_vcsTest.vcs"
	charset="iso-8859-1"
    output="BEGIN:VCALENDAR#newLine#
PRODID:-//Microsoft Corporation//Outlook MIMEDIR//EN#newLine#
VERSION:1.0#newLine#
BEGIN:VEVENT#newLine#
DTSTART:#startDate##newLine#
DTEND:#endDate##newLine#
LOCATION:N/A#newLine#
CATEGORIES:#category##newLine#
DESCRIPTION;ENCODING=QUOTED-PRINTABLE:#notes##newLine#
SUMMARY:#summary##newLine#
PRIORITY:3#newLine#
END:VEVENT#newLine#
END:VCALENDAR">



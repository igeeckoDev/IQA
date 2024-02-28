<cfoutput>
<b>CGI.Server_Name</b>
<br>#CGI.Server_Name#<br><br>

<b>CGI.Path_Info</b>
<br>#CGI.PATH_INFO#<br><br>

<b>CGI.Script_Name</b>
<br>#cgi.script_name#<br><br>

<b>getdirectoryfrompath</b>
<br>
<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
#curdir#<br><br>

<b>GetCurrentTemplatePath()</b>
<br>#GetCurrentTemplatePath()#<br><br>

<cfset thisPath = ExpandPath("*.*")>
<cfset path = GetDirectoryFromPath(thisPath)>
<b>thisPath - ExpandPath("*.*")<br>
path = GetDirectoryFromPath(thispath)</b><br>
<b>path</b><br>
#path#<br><br>

<b>replace(path, "admin\", "", "All")</b><br>
#replace(path, "admin\", "", "All")#<br><br>
</cfoutput>
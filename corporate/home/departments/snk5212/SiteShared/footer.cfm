<Br /><br />
<cfparam name="curyear" default="#year(now())#">
<div id="footer" align="center">
	<br><cfoutput>
    <span class="left">
        <a href="#request.serverProtocol##request.serverDomain#/library/comments/" title="Help">Help</a> |
        <a href="http://intranet.ul.com/en/Tools/Pages/Sitemap.aspx" title="Site Map">Site Map</a> |
        <a href="#request.serverProtocol##request.serverDomain#/deptadmin/Marco/index.htm" title="MARCO">UL Intranet Site Request</a>
    </span>
    <span class="right">
    	&copy; 2004-#curyear# UL LLC. All Rights Reserved
    </span></cfoutput>
</div>
</body>
</html>
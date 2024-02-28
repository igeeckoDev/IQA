<!--- Start of Page File --->
<cfset subTitle = "Quality Engineering - Site FAQ">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<ul class="arrow2">
  <li class="arrow2">1 - <a href="SiteFAQ.cfm?#1">Site Layout and Navigation</a></li>
  <li class="arrow2">2 - <a href="SiteFAQ.cfm?#2">Drop Down Menus</a></li>
  <li class="arrow2">3 - <a href="SiteFAQ.cfm?#3">Section Headings - Menu Differences</a></li>
  <li class="arrow2">4 - <a href="SiteFAQ.cfm?#4">Reporting Errors</a></li>
</ul>

<hr class='dash'><br>

<cfoutput>
<a name="1"></a>
<b>1 - Site Layout and Navigation</b><br>
The site is divided into five main sections:<Br>
- Quality Engineering<Br>
- Audits (IQA)<Br>
- CAR Process<Br>
- GCAR Metrics<Br>
- FAQ<Br><Br>

Each section above has its own menu, which can be seen on the left hand navigation menu. In the example below, the Audits / IQA Menu is shown. Also, each main section has its own heading across the top of the page.<br><br>

<img src="#SiteDir#SiteImages/SiteFAQ/IQAHomePage.jpg" border="0" /><br /><br />

<hr class='dash'><br>

<a name="2"></a>
<b>2 - Drop Down Menus</b><br>
You can view each section's main menu by placing your mouse over any of these headings. This will display a drop down menu of available pages. In the example below, placing the mouse over the 'Audits' heading will expose the drop down menu.<br><br>

<img src="#SiteDir#SiteImages/SiteFAQ/IQADropDownMenu.jpg" border="0" /><br /><br />

The drop down menu and left side navigation menu are the same in the example above. In the example below, you can see the Audits / IQA drop down menu when you are currently viewing the GCAR Metrics Site. (The left side navigation menu is for GCAR Metrics) You can navigate between all the main headings no matter what section you are viewing.<br><br>

<img src="#SiteDir#SiteImages/SiteFAQ/IQADropDownFromGCARMetricsSite.jpg" border="0" /><br /><br />

<hr class='dash'><br>

<a name="3"></a>
<b>3 - Section Headings - Menu Differences</b><br>
When in the Audits or CAR Process sites, the right-most heading is 'Log In'. This allows approved users to access their account for each site.<Br><br>
<img src="#SiteDir#SiteImages/SiteFAQ/MenuItemsLoggedOut.jpg" border="0" /><br /><br />

Hovering over 'Log In' in the above example will expose a link that will take you to the login page for either Audits / IQA or CAR Process.<br><br>

Audits / IQA:<Br>
<img src="#SiteDir#SiteImages/SiteFAQ/IQALoginLink.jpg" border="0" /><br /><br />

CAR Process:<Br>
<img src="#SiteDir#SiteImages/SiteFAQ/CARProcessLoginLink.jpg" border="0" /><br /><br />

When in the Quality Engineering, GCAR Metrics, and FAQ sites, the right-most heading is 'Help' as shown in the example below.<br><br>
<img src="#SiteDir#SiteImages/SiteFAQ/MenuItemsNonIQAorCARSites.jpg" border="0" /><br /><br />

<hr class='dash'><br>

<a name="4"></a>
<b>4 - Reporting Errors</b><Br>
On the bottom of the left side navigation menu, there is a link to the error reporting form.<br><br>

<img src="#SiteDir#SiteImages/SiteFAQ/ErrorReporting.jpg" border="0" /><br /><br />

You may encounter an error message on a page. All errors are reported to the Site Admin and are addressed as soon as possible. If you wish to be contacted about an error or wish to add additional information, you can always using the error reporting form above or by following the link on the error message notifcation page as seen below.<Br><br>

<img src="#SiteDir#SiteImages/SiteFAQ/ErrorNotice.jpg" border="0" /><br /><br />

This will take you to the Error Reporting Form.<Br><br>

<img src="#SiteDir#SiteImages/SiteFAQ/ErrorReportingForm.jpg" border="0" /><br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->
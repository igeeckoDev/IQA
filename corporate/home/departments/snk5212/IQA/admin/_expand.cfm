<html><head>
<style type="text/css">

.togList
{
font-family: verdana;
}

.togList dt
{
cursor: pointer; cursor: hand;
}

.togList dt span
{
font-family: monospace;
}

.togList dd
{
width: 200px;
padding-bottom: 15px;
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
= toOpen? '-':'+' ;
}
</script>

</head><body>

<dl class="togList">
<dt onclick="tog(this)"><span>+</span> Header 1</dt>
<dd>
<p>Info info info info Info info info info
Info info info info Info info info info</p>
<p>Info info info info Info info info info
Info info info info Info info info info</p>
</dd>
<dt onclick="tog(this)"><span>+</span> Header 2</dt>
<dd>
<p>Info info info info Info info info info
Info info info info Info info info info</p>
<p>Info info info info Info info info info
Info info info info Info info info info</p>
</dd>
</dl>

</body>
</html>
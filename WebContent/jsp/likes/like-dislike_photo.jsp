<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>

<%
int contentId = 0;
String contentType="";
String sef_url="";
String pageUrl="";
int galleryId=0;
if(request.getParameter("contentId")!=null)
	contentId = Integer.parseInt(request.getParameter("contentId"));
if(request.getParameter("contentType")!=null)
	contentType = request.getParameter("contentType");
if(request.getParameter("ScfUrl")!=null)
	sef_url = request.getParameter("ScfUrl");

if(request.getParameter("galleryId")!=null)
	galleryId = Integer.parseInt(request.getParameter("galleryId"));

%>
<cache:cache key="" scope="application " time="120" refresh="t" >
<%
String contentTypeDisplay="";
if(contentType.equals("text"))
{
	 contentTypeDisplay="story";
	 pageUrl=MegacriticCommonConstants.storyURL(sef_url,1,contentId)+"#rating";
}
else if(contentType.equals("video"))
{
	 contentTypeDisplay="video";
	 pageUrl=MegacriticCommonConstants.videoURL(sef_url,1,contentId)+"#rating";
}
else if(contentType.equals("photo")){
	 contentTypeDisplay="photo";
	 pageUrl=MegacriticCommonConstants.galleryURL(sef_url,1,galleryId)+"#rating";
}
//System.out.println("pageUrl->"+pageUrl);
int upcount=0;
int downcount=0;
int totalcount=0;
String LikeDislikeStr = MegacriticCommonConstants.LikeDislike(contentId,contentType);
String[] temp;
String delimiter = "-";
temp = LikeDislikeStr.split(delimiter);
upcount=Integer.parseInt(temp[0]);
downcount=Integer.parseInt(temp[1]);
totalcount=Integer.parseInt(temp[2]);

%>
<script>

function trim(field)
{
while(field.charAt(field.length-1)==" "){
		field=field.substring(0,field.length-1);
	}
	while(field.charAt(0)==" "){
		field=field.substring(1,field.length);
	}
	return field;
}


function handleHttpResponse2()
{
	var urltoPass = "<%=pageUrl%>";
	urltoPass=trim(urltoPass);
	if(urltoPass.length==0){
		urltoPass = url;
	}
	//alert(urltoPass);
	if (http2.readyState == 4)
	{
		var results = http2.responseText;
		var arry = results.split('|'); 
		var upcnt=	(arry[0]);
		var dncnt=(arry[1]);
		var cmnt=(arry[2]);
		if (http2.status == 200) {
			//pageTracker._trackPageview(urltoPass); 
			document.getElementById("upcount").innerHTML = upcnt;
			document.getElementById("downcount").innerHTML = dncnt;
			document.getElementById("commenttext").innerHTML = cmnt;
			runScripts(document.getElementById('upcount'));
			runScripts(document.getElementById('downcount'));
			runScripts(document.getElementById('commenttext'));
		} else {                 
			alert('There was a problem retrieving the data');
		} 
	}
}
function getHTTPObject()
{
	var xmlhttp;
	if(window.XMLHttpRequest)
	{
		xmlhttp = new XMLHttpRequest();
	}
		else if (window.ActiveXObject)
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		if (!xmlhttp)
		{
			xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
	}
	return xmlhttp;
}

var http2 = getHTTPObject();
function changeRating(contentId,content_type,action)
{ 
	//alert("sa");
	upc = document.getElementById('upcount').firstChild.nodeValue;
	downc = document.getElementById('downcount').firstChild.nodeValue;
	totalc = upc+downc;
	url="<%=MegacriticCommonConstants.SITE_URL%>jsp/likes/rating_data.jsp?content_id="+contentId+"&content_type="+content_type+"&action="+action+"&upcount="+upc+"&downcount="+downc+"&totalcount="+totalc;
//alert("url");	
    http2.open("GET", url, true);
	http2.onreadystatechange = handleHttpResponse2;
	http2.send(null);
}
</script>

<div class="likedisdiv">

    	<a  onClick="javascript:changeRating('<%=contentId%>','<%=contentType%>','1')">
    	<span class="likeimg"></span>
     </a>
    	<span class="likecount" id="upcount"><%=upcount%> </span>
  

    	<a  onClick="javascript:changeRating('<%=contentId%>','<%=contentType%>','2')">
    	  <span class="dislikeimg"></span>
      </a>
      <span class="dislcount" id="downcount"><%=downcount%></span><br />
       Do you like this <%=contentTypeDisplay%>? 
      
    </div>
   
</cache:cache>


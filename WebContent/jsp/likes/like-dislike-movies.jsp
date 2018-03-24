<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%//@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>

<%
int contentId = 0;
String contentType="";
String sef_url="";
String pageUrl="";
int galleryId=0;
String title="";
if(request.getParameter("contentId")!=null)
	contentId = Integer.parseInt(request.getParameter("contentId"));
if(request.getParameter("contentType")!=null)
	contentType = request.getParameter("contentType");
if(request.getParameter("ScfUrl")!=null)
	sef_url = request.getParameter("ScfUrl");
if(request.getParameter("titleData")!=null)
	title = request.getParameter("titleData");


if(request.getParameter("galleryId")!=null) 
	galleryId = Integer.parseInt(request.getParameter("galleryId"));
%>
<%-- <cache:cache key="<%=Constants.SITE_URL+"like-dislike.jsp?contentId="+contentId+"&contentType="+contentType%>" scope="application " time="120" refresh="t" > --%>
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
if(session.getAttribute("updata")==null)
{
session.setAttribute("updata",temp[0]);
}
else
{
	session.removeAttribute("updata");
	session.setAttribute("updata",temp[0]);
}
%>
<script>
//alert("aa--");


//var data1=document.getElementById("likecountid").value;
//var data2=document.getElementById("likecountdata").value;
//document.getElementById("likec"+data1).innerHTML = data2;

//alert(data1);
//alert(data2);


</script>

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
var likedislikeaction = '0';
function handleHttpResponse_likedislike()
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
			//alert(results);
			alert(cmnt);
			//_gaq.push(['_trackPageview', urltoPass]);
			if(!results.match('already')) {
				if(likedislikeaction==1) {
					//alert(cmnt);
					//_gaq.push(['_trackEvent', 'LIKE',urltoPass,1]);
					//ga('send', 'event', 'LIKE', 'click',urltoPass, 1, {'nonInteraction': 1});
				}
				if(likedislikeaction==2) {
					//_gaq.push(['_trackEvent', 'DISLIKE',urltoPass,1]);
					//ga('send', 'event', 'DISLIKE', 'click',urltoPass, 1, {'nonInteraction': 1});
				} 
			}
			//alert(upcnt);
			document.getElementById("upcount"+arry[3]).innerHTML = upcnt;
			document.getElementById("likec"+arry[3]).innerHTML = upcnt;
			//document.getElementById("downcount").innerHTML = dncnt;
			//document.getElementById("commenttext").innerHTML = cmnt;
			//runScripts(document.getElementById('upcount'));
			//runScripts(document.getElementById('downcount'));
			//runScripts(document.getElementById('commenttext'));
		} else {                 
			alert('There was a problem retrieving the data');
		} 
	}
}
function getHTTPObject_2()
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

var http2 = getHTTPObject_2();
function changeRating_story(contentId,content_type,action)
{ 
//	alert("aa");
	upc = document.getElementById('upcount'+contentId).firstChild.nodeValue;
	downc =0;
	totalc = upc;
	likedislikeaction = action;
	url="<%=MegacriticCommonConstants.SITE_URL%>jsp/likes/rating_data.jsp?content_id="+contentId+"&content_type="+content_type+"&action="+action+"&upcount="+upc+"&downcount="+downc+"&totalcount="+totalc;
	//alert(url);
	http2.open("GET", url, true);
	http2.onreadystatechange = handleHttpResponse_likedislike;
	http2.send(null);
}
</script>

    <a  class="like_icon_on_img" onClick="javascript:changeRating_story('<%=contentId%>','<%=contentType%>','1')"></a> 
    <input type="hidden" id="likecountid" value="<%=contentId%>"/>
    <input type="hidden" id="likecountdata" value="<%=upcount%>"/>
              </div>
               <div class="content_panel">
                <h3><%=title%></h3>
                 <strong><span class="likecount" id="upcount<%=contentId%>">  <%=upcount%>  </span> Want to Watch </strong> <a href="#">Watch Trailor</a> 
               </div> 
<%-- 
</cache:cache> --%>


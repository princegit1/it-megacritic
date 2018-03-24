<%@page import="com.indiatoday.megacritic.domain.RelatedContentDTO"%>
<%@page import="com.indiatoday.megacritic.domain.GalleryDTO"%>
<%@page import="com.indiatoday.megacritic.domain.GalleryHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>

<%@taglib uri="/struts-tags" prefix="s" %>

<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<% String baseUrl = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getServletPath()))+"/"; 
	if(request.getServerName().contains("origin-")) {
		baseUrl = MegacriticCommonConstants.SITE_URL;
		
	}
int galleryId = 10183;
int currentPhotoNo = 1;

if(request.getAttribute("photoGalleryId")!=null )
	galleryId = Integer.parseInt(request.getAttribute("photoGalleryId").toString());
if(request.getAttribute("currentPhotoNo")!=null)
	currentPhotoNo = Integer.parseInt(request.getAttribute("currentPhotoNo").toString());
%><cache:cache key="" scope="application " time="0" refresh="t" >
<%
//ArrayList photoDetails = (ArrayList)request.getAttribute("photoData");
ArrayList photoDetails = GalleryHelper.photoDetails(galleryId, currentPhotoNo); 
//ArrayList inside = (ArrayList) GalleryHelper.latestCategory(6);
ArrayList inside = null;
ArrayList gallerySmallImages = null;
//System.out.println("photoDetails size-"+photoDetails.size());  
int photoId = 0;
String photoTitle = "";
String photoCaption = "";
int photoWidth = 0;
int photoHeight = 0;
String photoKeywords = "" ;
String photoSource = "";
String photoAltText = "";
String galleryStrapHeadline="";
String imageStrapHeadline="";
String galleryTitle = "";
String galleryMetaTitle = "";
String galleryMetaKeywords = "";
String galleryMetaDescription = "" ;
String gallerySefTitle = "";
int totalPhotoCount = 0;
int noOfcomments = 0;
int categoryId = 0;
String categoryTitle  = "" ;
String categorySefTitle  = "" ;
String topNavigationPath = "";
String rightNavigationPath = "";
String bottomNavigationPath = "";
String leftNavigationPath = "";
String headerImage = "";
String imageTitle = "";
String newSlider = "";
int sliderStartFrom = currentPhotoNo;
String thumbwidth = "";
String thumbleft = "";

if (photoDetails != null && photoDetails.size() > 0) {
	gallerySmallImages = GalleryHelper.photogallerySmallImages(galleryId);
	for (int pCtr = 0; pCtr < photoDetails.size(); pCtr++) {
		GalleryDTO galleryDTO = (GalleryDTO) photoDetails.get(pCtr);
		if (pCtr == 0) {
			photoId = galleryDTO.getPhotoId();
			photoTitle = galleryDTO.getPhotoTitle();
			photoCaption = galleryDTO.getPhotoCaption();
			//photoSource = galleryDTO.getPhotoSource().trim().length() == 0 ? "" : "PHOTO: "+galleryDTO.getPhotoSource();
			photoWidth = galleryDTO.getPhotoWidth(); 
			photoHeight = galleryDTO.getPhotoHeight();
			photoKeywords = galleryDTO.getPhotoMetaKeywords();
			galleryId = galleryDTO.getGalleryId();
			if(galleryId==6301) {
				photoSource = galleryDTO.getPhotoSource().trim().length() == 0 ? "" : "<span class='photo' style='text-transform:none;'>Cartoon by "+galleryDTO.getPhotoSource()+"</span>";
			} else {
				photoSource = galleryDTO.getPhotoSource().trim().length() == 0 ? "" : "<span class='photo'><b class='photo_h'></b> "+galleryDTO.getPhotoSource()+"</span>";
			}

			galleryTitle = galleryDTO.getGalleryTitle();
			galleryStrapHeadline=galleryDTO.getStrapHeadline();
			imageStrapHeadline=galleryDTO.getImageStrapHeadline();
			gallerySefTitle = galleryDTO.getGallerySefTitle();
			galleryMetaKeywords = galleryDTO.getMetaKeywords();
			galleryMetaDescription = galleryDTO.getMetaDescription();
			categoryId = galleryDTO.getCategoryId();
			categoryTitle = galleryDTO.getCategoryTitle();
			categorySefTitle = galleryDTO.getCategorySefTitle();
			currentPhotoNo =galleryDTO.getCurrentPhotoNum();
			totalPhotoCount = galleryDTO.getPhotoCount();
			noOfcomments = galleryDTO.getGalleryCommentCount();
			photoAltText = galleryDTO.getPhotoAltText();
			headerImage = galleryDTO.getHeaderImage();
			galleryMetaTitle = galleryTitle + " - | Photo"+currentPhotoNo+" | India Today |";
			topNavigationPath = galleryDTO.getTopNavigationPath();
			rightNavigationPath = galleryDTO.getRightNavigationPath();
			bottomNavigationPath = galleryDTO.getBottomNavigationPath();
			leftNavigationPath = galleryDTO.getLeftNavigationPath();
			imageTitle = galleryDTO.getImageTitle();
		} 
	}
int backPhotoNo=currentPhotoNo-1;
int nextPhotoNo=currentPhotoNo+1;
if(currentPhotoNo>1 && totalPhotoCount>1) {
	backPhotoNo=currentPhotoNo-1;
}
if(currentPhotoNo<totalPhotoCount && totalPhotoCount>1) {
	nextPhotoNo=currentPhotoNo+1;
}

thumbwidth = (totalPhotoCount * 103) +"px";

if(totalPhotoCount > 6) {
	if(currentPhotoNo>1) {
			thumbleft = ((currentPhotoNo-1) *103)+"px";
	} else {
		thumbleft = "0";
	}
} else {
	thumbleft = "0";
}
//System.out.println("sliderStartFrom->"+sliderStartFrom+" -- currentPhotoNo->"+currentPhotoNo+" -- totalPhotoCount->"+totalPhotoCount);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/jsp/common/css-js.jsp" %>
<base href="<%=baseUrl%>"/>
<title><%=galleryMetaTitle%></title>
<meta name="description" content="<%=galleryMetaDescription%><%if(currentPhotoNo>1) { out.print(" , Photo "+currentPhotoNo); }%>" />
<meta name="keywords" content="<%=galleryMetaKeywords%> <%if(photoKeywords.trim().length()>0) {out.print(","+photoKeywords); }%> <%if(currentPhotoNo>1) { out.print(" : Photo "+currentPhotoNo); }%>" />
<%if(currentPhotoNo >= 1) { %>
<link rel="canonical" href="<%=MegacriticCommonConstants.SITE_URL+MegacriticCommonConstants.galleryURL(gallerySefTitle, currentPhotoNo, galleryId) %>" />
<%} %>
<%//@include file="ga.jsp"%>
<%//@include file="taboola_newsroom.jsp"%>
<meta charset="utf-8">
<meta name="twitter:card" content="photo">
<meta name="twitter:site" content="@IndiaToday">
<meta name="twitter:creator" content="@indiatoday">   
<meta name="twitter:url" content="<%=MegacriticCommonConstants.SITE_URL+MegacriticCommonConstants.galleryURL(gallerySefTitle, currentPhotoNo, galleryId) %>">   
<meta name="twitter:title" content="<%=galleryTitle.replace("{table}","").replace("mospagebreak","").replace("{","").replace("}","").replace("mosimage","").replace("blurb","").replace("quote","").replaceAll("<[^/bp][^>]*>|<p[a-z][^>]*>|<b[^r][^>]*>|<br[a-z][^>]*>|</[^bp]+>|</p[a-z]+>|</b[^r]+>|</br[a-z]+>","").replaceAll( "</?a[^>]*>", "" ).replaceAll( "</?font[^>]*>", "" ).replaceAll( "<br /><br /><br /><br />", "<br /><br />" ).replaceAll( "<br /><br /><br />", "<br /><br />" ).replaceAll( "\"", "-" )%>">   
<meta name="twitter:description" content="<%=photoCaption.replace("{table}","").replace("mospagebreak","").replace("{","").replace("}","").replace("mosimage","").replace("blurb","").replace("quote","").replaceAll("<[^/bp][^>]*>|<p[a-z][^>]*>|<b[^r][^>]*>|<br[a-z][^>]*>|</[^bp]+>|</p[a-z]+>|</b[^r]+>|</br[a-z]+>","").replaceAll( "</?a[^>]*>", "" ).replaceAll( "</?font[^>]*>", "" ).replaceAll( "<br /><br /><br /><br />", "<br /><br />" ).replaceAll( "<br /><br /><br />", "<br /><br />" ).replaceAll( "\"", "-" )%>">
<meta name="twitter:image:width" content="<%=photoWidth %>" />
<meta name="twitter:image:height" content="<%=photoHeight %>" />
<% if(photoTitle!=null && !photoTitle.equals("")) { %>
<meta name="twitter:image" content="<%="http://media2.intoday.in/indiatoday/images/Photo_gallery/"+photoTitle%>">
<meta property="og:image" content="<%="http://media2.intoday.in/indiatoday/images/Photo_gallery/"+photoTitle%>" />
<link rel="image_src" href="<%="http://media2.intoday.in/indiatoday/images/Photo_gallery/"+photoTitle%>" / >
<%} else {%>
<meta name="twitter:image" content="http://media2.intoday.in/indiatoday/it-logo-200x200-white.gif">
<meta property="og:image" content="http://media2.intoday.in/indiatoday/it-logo-200x200-white.gif" />
<link rel="image_src" href="http://media2.intoday.in/indiatoday/it-logo-200x200-white.gif" / >
<%}%>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<%if(request.getAttribute("javax.servlet.forward.request_uri")!=null){ %>
<link rel="alternate" media="only screen and (max-width: 640px)" href="http://m.indiatoday.in/<%=request.getAttribute("javax.servlet.forward.request_uri").toString()%>" />
<%} %>
<%if(request.getAttribute("javax.servlet.forward.request_uri")!=null){ %>
<link rel="alternate" media="only screen and (max-width: 640px)" href="http://m.indiatoday.in/<%=request.getAttribute("javax.servlet.forward.request_uri").toString()%>" />
<script type="text/javascript">
function canonicalUrlRedirection() {

var canonicalUrl = "";var links = document.getElementsByTagName("link");
for (var i = 0; i < links.length; i ++) {if (links[i].getAttribute("rel") == "alternate") {
canonicalUrl = links[i].getAttribute("href");break;}}if (canonicalUrl != "") {window.location.href = canonicalUrl;
}}
var redirectagent=navigator.userAgent.toLowerCase();
var mode=window.location.toString().split("mode=")[1];
var redirect_devices=["vnd.wap.xhtml+xml","sony","symbian","S60","SymbOS","nokia","samsung","mobile","windows ce","epoc","opera mini","nitro","j2me","midp-","cldc-","netfront","mot","up.browser","up.link","audiovox","blackberry","ericsson","panasonic","philips","sanyo","sharp","sie-","portalmmm","blazer","avantgo","danger","palm","series60","palmsource","pocketpc","smartphone","rover","ipaq","au-mic","alcatel","ericy","vodafone","wap1","wap2","teleca","playstation","lge","lg-","iphone","android","htc","dream","webos","bolt","nintendo"];
if(!(redirectagent.indexOf("ipad")>=0)){
for(var i in redirect_devices){
if(redirectagent.indexOf(redirect_devices[i])!=-1){
if(mode!="classic"){
canonicalUrlRedirection();
}}}};
</script>
<%} %>
<%if(categoryId==39){%>
<!--<script src="http://adserver.brandgeni.com/ad-server/js/ad-server-bootstrap.js?domain=indiatoday.intoday.in"></script>
<script type="text/javascript" src="http://adcdn.forkmedia.in/impulse3/intoday.impulse.js"></script>-->

<%}else{%>
<!--<script type="text/javascript" src="http://adcdn.forkmedia.in/impulse3/intoday.impulse.js"></script>
-->
<%}%>
<script type="text/javascript">
window._taboola = window._taboola || [];
_taboola.push({photo:'auto'});
!function (e, f, u) {
e.async = 1;
e.src = u;
f.parentNode.insertBefore(e, f);
}(document.createElement('script'), document.getElementsByTagName('script')[0], 'http://cdn.taboola.com/libtrc/indiatoday-indiatoday/loader.js');
</script>
<!-- html5.js for IE less than 9 -->
<!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- css3-mediaqueries.js for IE less than 9 -->
<!--[if lt IE 9]>
	<script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
<![endif]-->
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
--><!--<link href="css/jquery.bxslider.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="js/sitejs.js"></script>
<link href='http://fonts.googleapis.com/css?family=Roboto:100,200,300,700,500,400,900' rel='stylesheet' type='text/css'>-->
<script>
var loadlinkk=window.location.hash+"";
if(loadlinkk)
{
var galleryId="<%=galleryId%>";
var currentPhotoNo="<%=currentPhotoNo%>";
var totalPhotoCount="<%=totalPhotoCount%>";

}
</script>
<script type="text/javascript">var _sf_startpt=(new Date()).getTime()</script>

<%if(rightNavigationPath.trim().length() != 0) { %>
<style>
#spc-topnav { margin: 0 auto; width: 1003px; }
#spc-rightnav {width:300px; float:right; text-align:left}	

</style>

<%} %>


<style type="text/css">
.pagination a.currentpage {
    border-color: #ccc #333 #333 #ccc;
    border-style: solid;
    border-width: 1px;
    cursor: default;
    font-weight: 700;
}
.pagination li a {
    color: #000;
    text-decoration: none;
}
.pagination a, .pagination a:visited {
    color: #000 !important;
    padding: 2px 5px;
}
.centerdiv {
    margin: 0 auto;
    overflow: hidden;
    padding: 10px 0 15px;
    width: 1000px;
}
.phcont {
    background-color: #fff;
    float: left;
    margin-bottom: 2%;
    padding-bottom: 1.5%;
    width: 1000px;
}
.phpadding {
    clear: both;
    margin-top: 20px;
    padding-left: 0.5%;
}
.phleftcont {
    border: 1px solid #e3e3e3;
    box-shadow: 0 0 10px #e3e3e3;
    display: inline-block;
    padding: 4px;
    position: relative;
    text-align: left;
    width: 66.3%;
}
.phcont h1 {
    color: #000;
    float: left;
    font: 700 32px/36px Roboto;
    margin: 0 0 1%;
    padding: 0;
    text-align: left;
}
.phnext, .phprev {
    height: 35px;
    position: absolute;
    text-indent: -9999px;
    top: 37% !important;
    width: 16px;
}
a.prev {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/photo_left_arrow.png") no-repeat scroll 0 0;
    cursor: pointer;
    left: 7px;
    padding: 15px;
    position: absolute;
    text-indent: -9999px;
    top: 44px;
}
a.next {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/photo_right_arrow.png") no-repeat scroll 0 0;
    cursor: pointer;
    padding: 15px;
    position: absolute;
    right: 0;
    text-indent: -9999px;
    top: 44px;
}
.phprev, .phprev:hover {
    opacity: 1;
}
a.phprev {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -169px -281px;
    height: 62px;
    left: 0;
    width: 22px;
}
a.phnext {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -219px -281px;
    height: 61px;
    right: -1px;
    width: 25px !important;
}
.numbertab {
    color: #999;
}
.phleftcont > img {
    width: 100%;
}
.phnext, .phnext:hover {
    opacity: 1;
}
.new_pagination {
    background-color: #f6f4f5;
    color: #fff;
    font: 12px arial;
    height: 110px;
    margin-left: -5px;
    margin-top: 5px;
    position: relative;
    z-index: 99;
}
#newGallery {
    float: left;
}
#slider1 {
    height: 90px;
    overflow: hidden;
    padding: 20px 0 3px;
}
#slider1 .viewport {
    float: left;
    height: 78px;
    left: 34px;
    overflow: hidden;
    position: relative;
    width: 626px;
}
#slider1 .overview {
    list-style: outside none none;
    margin: 0 10px 0 5px;
    padding: 3px 0 0;
    position: absolute;
    top: 0;
}
#slider1 .overview li {
    float: left;
    padding: 0 33px 0 0;
    width: 88px;
}
.tabactive {
    color: #ec0400;
}
.numbertab {
    display: none;
    font: 900 16px/20px roboto;
    margin: 5px auto 15px;
    text-align: center;
    width: 20px;
}
#slider1 .overview li img {
    border: 3px solid #fff;
    box-shadow: 0 0 3px 0 #999;
}

.pagination a.currentpage {
    border-color: #ccc #333 #333 #ccc;
    border-style: solid;
    border-width: 1px;
    cursor: default;
    font-weight: 700;
}
.pagination li a {
    color: #000;
    text-decoration: none;
}
.pagination a, .pagination a:visited {
    color: #000 !important;
    padding: 2px 5px;
}
.centerdiv {
    margin: 0 auto;
    overflow: hidden;
    padding: 10px 0 15px;
    width: 1000px;
}
.phcont {
    background-color: #fff;
    float: left;
    margin-bottom: 2%;
    padding-bottom: 1.5%;
    width: 1000px;
}
.phpadding {
    clear: both;
    margin-top: 20px;
    padding-left: 0.5%;
}
.phleftcont {
    border: 1px solid #e3e3e3;
    box-shadow: 0 0 10px #e3e3e3;
    display: inline-block;
    padding: 4px;
    position: relative;
    text-align: left;
    width: 66.3%;
}
.phcont h1 {
    color: #000;
    float: left;
    font: 700 32px/36px Roboto;
    margin: 0 0 1%;
    padding: 0;
    text-align: left;
}
.phnext, .phprev {
    height: 35px;
    position: absolute;
    text-indent: -9999px;
    top: 37% !important;
    width: 16px;
}
a.prev {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/photo_left_arrow.png") no-repeat scroll 0 0;
    cursor: pointer;
    left: 7px;
    padding: 15px;
    position: absolute;
    text-indent: -9999px;
    top: 44px;
}
a.next {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/photo_right_arrow.png") no-repeat scroll 0 0;
    cursor: pointer;
    padding: 15px;
    position: absolute;
    right: 0;
    text-indent: -9999px;
    top: 44px;
}
.phprev, .phprev:hover {
    opacity: 1;
}
a.phprev {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -169px -281px;
    height: 62px;
    left: 0;
    width: 22px;
}
a.phnext {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -219px -281px;
    height: 61px;
    right: -1px;
    width: 25px !important;
}
.numbertab {
    color: #999;
}
.phleftcont > img {
    width: 100%;
}
.phnext, .phnext:hover {
    opacity: 1;
}
.new_pagination {
    background-color: #f6f4f5;
    color: #fff;
    font: 12px arial;
    height: 110px;
    margin-left: -5px;
    margin-top: 5px;
    position: relative;
    z-index: 99;
}
#newGallery {
    float: left;
}
#slider1 {
    height: 90px;
    overflow: hidden;
    padding: 20px 0 3px;
}
#slider1 .viewport {
    float: left;
    height: 78px;
    left: 34px;
    overflow: hidden;
    position: relative;
    width: 626px;
}
#slider1 .overview {
    list-style: outside none none;
    margin: 0 10px 0 5px;
    padding: 3px 0 0;
    position: absolute;
    top: 0;
}
#slider1 .overview li {
    float: left;
    padding: 0 33px 0 0;
    width: 88px;
}
.tabactive {
    color: #ec0400;
}
.numbertab {
    display: none;
    font: 900 16px/20px roboto;
    margin: 5px auto 15px;
    text-align: center;
    width: 20px;
}
#slider1 .overview li img {
    border: 3px solid #fff;
    box-shadow: 0 0 3px 0 #999;
}
.imgborder {
    border: 3px solid #ea0500 !important;
}
.phrightcont {
    float: right;
    position: relative;
    width: 31%;
}
.right {
    float: right;
}
.photocap {
    color: #414141;
    font: 16px/20px roboto !important;
    padding: 0 5px 5px 0;
}
.photosynd {
    box-shadow: 0 0 2px #ccc;
    padding: 5px;
}
.phrightcont .likedisdiv {
    background: #fafafa none repeat scroll 0 0;
    border: medium none;
    padding: 5px 10px;
    text-align: left;
}
.photo {
    color: #969696;
    padding: 10px 0 20px;
}
.photo_h {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -21px -194px;
    display: inline-block;
    height: 20px;
    margin-bottom: -5px;
    width: 22px;
}
ul.rel_links {
    background: #fafafa none repeat scroll 0 0;
    float: left;
    margin: 15px 0 10px;
    padding: 10px;
    width: 94%;
}
ul.rel_links li {
    list-style-type: none;
    padding: 0 0 10px;
}
ul.rel_links li a {
    color: #777;
    font-size: 14px;
    line-height: 18px;
    text-decoration: none;
}
ul.rel_links li span {
    color: #777;
    display: block;
    float: left;
    margin: -2px 0 11px;
    padding: 0;
    width: 14px;
}
.likedisdiv {
    border-bottom: 1px dotted #ccc;
    border-top: 1px dotted #ccc;
    color: #9a9a9a;
    font: 100 18px/32px Roboto,sans-serif;
    margin-bottom: 10px;
    overflow: hidden;
    padding: 10px 0 0;
    text-align: center;
    text-transform: uppercase;
}
.like_dislike_area {
    float: right;
    line-height: 25px;
    width: 225px;
}
.likeimg {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -329px -337px;
    cursor: pointer;
    display: inline-block;
    height: 35px;
    margin-bottom: -3px;
    width: 33px;
}
.likecount {
    color: #208302;
    font: 700 22px/22px roboto,serif;
    margin: 0 5px;
}
.st_social {
    float: left;
    overflow: hidden;
    width: auto;
}
.st_social ul {
    margin: 0;
    padding: 0;
}
.st_social ul li {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/social_devider.gif") no-repeat scroll right center;
    color: #afafaf;
    float: left;
    font-size: 10px;
    font-weight: 500;
    line-height: 18px;
    list-style: outside none none;
    margin-right: 20px;
    padding-right: 20px;
    width: auto;
}
.st_social ul li .icon_f {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -171px -440px;
    display: inline-block;
    height: 16px;
    margin: 0 auto;
    width: 10px;
}
.st_social ul li .icon_t {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -200px -440px;
    display: inline-block;
    height: 16px;
    margin: 0 auto;
    width: 17px;
}
.st_social ul li .icon_c {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -228px -440px;
    display: inline-block;
    height: 16px;
    margin: 0 auto;
    width: 23px;
}
.st_social ul li b {
    font-size: 32px;
    font-weight: 700;
    line-height: 25px;
}
.st_more {
    background: rgba(0, 0, 0, 0) url("http://media2.intoday.in/indiatoday/images/homenew/Sprit-IT-Home.png") repeat scroll -256px -441px;
    color: #afafaf;
    display: block;
    float: left;
    font-size: 10px !important;
    height: 25px;
    padding-top: 12px;
    width: 25px;
}
</style>

</head>
<body>
<%@ include file="/jsp/common/header.jsp" %>
<div class="clearfix"></div>
<!--body section-->
<div class="wrapper">
<div id="body_section"> 
<div class="skinnin-ad-container">
<%if(rightNavigationPath.trim().length() == 0) { %>
<%//@include file="navigation_topnav_2015.jsp"%>
<%}else{ %>
<div id="spc-topnav"><jsp:include page="<%=topNavigationPath%>" flush="true" /></div>
<%} %>

<div id="main_container" style="position:relative; ">
<div id="wapper">
<%if(categoryId==137){%>
<div style="padding:15px 0"><img src="http://media2.intoday.in/microsites/mast/it/golden-globe-2015.JPG" border="0"></div>
<%} %>
<%if(categoryId==139){%> 
<div style="padding:15px 0"><a href="http://indiatoday.intoday.in/elections/assembly/2015/delhi/index.jsp"><img border="0" src="http://media2.intoday.in/indiatoday/election_delhi_2015/delhi_election2015.gif"></a></div>
<%} %>
<div class="phcont" id="show" style="display:block!Important;">

<div class='clr'></div>
<%
String galleryPlayStart="";
String galleryPlayEnd="";
String galleryPlayComplete="";
String galleryPlayLeft="";
String galleryPlayRight="";
String galleryBackNext="";
String galleryCaption="";
String galleryRelated="";
String galleryUtility="";
String galleryLikeDislike="";
String galleryComments="";
String gallerySocial="";
String imgborder="";
String GALLERYURL=MegacriticCommonConstants.galleryURL(gallerySefTitle,1,galleryId);

//ArrayList related = (ArrayList) MegacriticCommonConstants.relatedContent(""+galleryId, "photo");
ArrayList related =null;
if(related != null && related.size() > 0)
{
	galleryRelated="<ul class='rel_links' >";
	for(int y=0;y<related.size();y++)
	{
		RelatedContentDTO RSB = (RelatedContentDTO) related.get(y);
		if(RSB.getRelatedType().trim().equals("text"))
		{
			galleryRelated = galleryRelated + "<li><span>&#187;</span> "+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.storyURL(RSB.getRelatedContentSefTitle(), 1, RSB.getRelatedContentId())+"'>"+RSB.getRelatedTitle()+"</a></li>";
		} else if(RSB.getRelatedType().trim().equals("photo")) {
			galleryRelated = galleryRelated + "<li class='p_rel'><span>&#187;</span>"+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(RSB.getRelatedContentSefTitle(), 1, RSB.getRelatedContentId())+"'>"+RSB.getRelatedTitle()+"</a></li>";
		} else if(RSB.getRelatedType().trim().equals("video")) {
			galleryRelated = galleryRelated + "<li class='v_rel'><span>&#187;</span>"+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.videoURL(RSB.getRelatedContentSefTitle(), 1, RSB.getRelatedContentId())+"'>"+RSB.getRelatedTitle()+"</a></li>";
		}
	}
	galleryRelated=galleryRelated+ "</ul>";

}
 
    galleryPlayLeft=galleryPlayLeft+"<div class='phpadding'><div class='phleftcont'><h1>"+galleryTitle+"</h1>";
    galleryPlayLeft=galleryPlayLeft+"<img width=\"658\"  src='http://media2.intoday.in/indiatoday/images/Photo_gallery/"+photoTitle+"'  border=\"0\"  alt=\""+photoAltText+"\" title=\""+photoAltText+"\" />";
    if(currentPhotoNo>1 && totalPhotoCount>1) {
	galleryPlayLeft=galleryPlayLeft+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(gallerySefTitle, backPhotoNo, galleryId)+"' title='#photo"+backPhotoNo+"'  name='"+galleryTitle.replaceAll("\'","")+" - India Today - photo "+backPhotoNo+"'  rel='"+MegacriticCommonConstants.SITE_URL+"gallery_data.jsp?galleryId="+galleryId+"&currentPhotoNo="+backPhotoNo+"&totalPhotoCount="+totalPhotoCount+"' class='phprev switch_button prev'>Previous</a>";
	}

if(currentPhotoNo<totalPhotoCount && totalPhotoCount>1) {
	galleryPlayLeft=galleryPlayLeft+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(gallerySefTitle, nextPhotoNo, galleryId)+"' title='#photo"+nextPhotoNo+"' name='"+galleryTitle.replaceAll("\'","")+" - India Today - photo "+nextPhotoNo+"'  rel='"+MegacriticCommonConstants.SITE_URL+"gallery_data.jsp?galleryId="+galleryId+"&currentPhotoNo="+nextPhotoNo+"&totalPhotoCount="+totalPhotoCount+"'  class='phnext switch_button next' >Next</a><div class=\"clear\"></div>";
}
     
          //SLIDER STSRAT FROM HERE
//newSlider = "<div class='new_pagination'><div id='newGallery'><div class='thumbs-wrapper'><div id='slider1'><a class='buttons prev' href=\"javascript:void(0);\">left</a><div class='viewport'><ul class='overview' style='width:"+thumbwidth +";left:-"+thumbleft+"'>";
newSlider = newSlider + "<div class='new_pagination'><div id='newGallery'><div class='thumbs-wrapper'><div id='slider1'>";
if(totalPhotoCount > 6) {
	newSlider = newSlider + "<a class='buttons prev' href=\"javascript:void(0);\">left</a>";
}
            newSlider = newSlider + "<div class='viewport'><ul class='overview' style='width:"+thumbwidth +";left:-"+thumbleft+"'>";
if (gallerySmallImages != null && gallerySmallImages.size() > 0) {
	for (int iCtr = 0; iCtr < gallerySmallImages.size(); iCtr++) {
		GalleryDTO imageDTO = (GalleryDTO) gallerySmallImages.get(iCtr);
		newSlider = newSlider + "<li><div class='numbertab ";
		imgborder=imgborder+"";
		if((iCtr+1) == currentPhotoNo)
			newSlider = newSlider + " tabactive ";
		if((iCtr+1) == currentPhotoNo){imgborder="class=\"imgborder\"";}else{imgborder="";}

		newSlider = newSlider + "'>"+(iCtr+1)+"</div><a href=\""+(MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(gallerySefTitle,(iCtr+1),galleryId))+"\" alt=\""+imageDTO.getPhotoAltText()+"\" title=\""+imageDTO.getPhotoAltText()+"\" name=\""+galleryTitle.replaceAll("\'","")+" - India Today - photo "+(iCtr+1)+"\" class='switch_small_button movenext'><img "+imgborder+" width='88' height='66'  src=\""+MegacriticCommonConstants.GALLERY_IMG_PATH+imageDTO.getPhotoTitle()+"\"></a></li>";
	}
}
//newSlider = newSlider + "</ul></div><a class='buttons next' href='javascript:void(0)'>right</a></div></div></div></div>";
newSlider = newSlider + "</ul></div>";
if(totalPhotoCount > 6) {
	newSlider = newSlider + "<a class='buttons next' href='javascript:void(0);'>right</a>";
}
newSlider = newSlider + "</div></div></div></div> <div class=\"clear\"></div> ";
galleryPlayRight = newSlider;
galleryPlayRight =galleryPlayRight+ "<div class='photosynd'><a href='http://syndicationstoday.com/' target='_blank'><img src='http://indiatoday.intoday.in/images/syn.gif' border='0'/></a>"; 
galleryPlayRight =galleryPlayRight+ "<iframe width='468' scrolling='no' height='60' frameborder='0' src='http://indiatoday.intoday.in/ads-468x60.html'></iframe></div>";
galleryPlayRight =galleryPlayRight+ "<div class='clear'></div> </div><div class='phrightcont'>";
gallerySocial="<div class='right' style=\"display:none\"><div class='fl'><a href='http://www.facebook.com/sharer.php?u=http%3A%2F%2Findiatoday.intoday.in/"+MegacriticCommonConstants.galleryURL(gallerySefTitle, 1, galleryId)+"'><img border='0' src='http://media2.intoday.in/indiatoday/images/f.jpg'></a></div><div class='fl'><a href='http://twitter.com/?status="+galleryTitle+"%20http%3A%2F%2Findiatoday.intoday.in/"+MegacriticCommonConstants.galleryURL(gallerySefTitle, 1, galleryId)+" @indiatoday'><img border='0' src='http://media2.intoday.in/indiatoday/images/t.jpg'></a></div> <div class='fl'><a href='#'><img border='0' src='http://media2.intoday.in/indiatoday/images/b.jpg'></a></div><div class='fl'><a href='#'><img border='0' src='http://media2.intoday.in/indiatoday/images/g.jpg'></a> </div></div>  <div class='clear'></div>";
            

galleryCaption="<div class='photocap'>"+imageTitle+photoCaption+"</div>";
if(photoSource.trim().length() > 0)
galleryCaption =  galleryCaption+"<div class='photo'>"+photoSource+"</div>";       
galleryLikeDislike=galleryRelated+"<div class='clr'></div><script type='text/javascript'>ajaxinclude('"+MegacriticCommonConstants.SITE_URL+"jsp/likes/like-dislike_photo.jsp?contentId="+photoId+"&contentType=photo&ScfUrl="+gallerySefTitle+"&galleryId="+galleryId+"')</script><div class='clear'></div>";            
galleryLikeDislike=galleryLikeDislike+"<div class='clr'></div><div class='clear'></div>";            
  
galleryLikeDislike=galleryLikeDislike+"<script type='text/javascript'>ajaxinclude('"+MegacriticCommonConstants.SITE_URL+"commentbox/comment_photo_box.jsp?slideid="+photoId+"&contenttype=photo&source=website&sourceurl="+MegacriticCommonConstants.SITE_URL+"&contentid="+galleryId+"&contenttitle="+java.net.URLEncoder.encode(galleryTitle) +"')</script><div class='clear'></div>";        
galleryLikeDislike=galleryLikeDislike+"<div class='phtopmarg'><iframe width='300' scrolling='no' height='250' frameborder='0' allowtransparency='true' marginwidth='0' marginheight='0' src='http://indiatoday.intoday.in/photoad.html'></iframe></div></div></div>";      
galleryPlayComplete=galleryPlayLeft+galleryPlayRight+gallerySocial+galleryCaption+galleryLikeDislike;

%>
<%=galleryPlayComplete %>
</div>
<div class="clear"></div>
<div class="phvid-leftnav">
<%if(currentPhotoNo>1) { %>
	<%-- <script type="text/javascript">ajaxinclude("<%=MegacriticCommonConstants.SITE_URL+"jsp/home/"%>galleriesfrom_chunk.jsp?galleryIdToAvoid=<%=galleryId%>&categoryId=<%=categoryId%>")</script> --%>
<% } else { %>
	<%-- <jsp:include page="galleriesfrom_chunk.jsp" flush="true" >
		<jsp:param name="galleryIdToAvoid" value="<%=galleryId%>" />
		<jsp:param name="categoryId" value="<%=categoryId%>" />
	</jsp:include> --%>
<% } %>
</div>
<%if(rightNavigationPath.trim().length() == 0) { %>
<%//@include file="navigation_rightnav_2015.jsp"%>
<%}else{ %>
<div id="spc-rightnav"><jsp:include page="<%=rightNavigationPath%>" flush="true" /></div>
<%} %>
</div>
<div class="clear"></div>

<%if(rightNavigationPath.trim().length() == 0) { %>
<%//@include file="navigation_footernav_2015.jsp"%>
<%}else{%>
<jsp:include page="<%=bottomNavigationPath%>" flush="true" />
<%} %>




<script type="text/javascript">
var message="Unauthorised use of pictures is prohibited. Copyright 2015 India Today Group";
function clickIE4(){
if (event.button==2){
alert(message);
return false;
}
}
function clickNS4(e){
if (document.layers||document.getElementById&&!document.all){
if (e.which==2||e.which==3){
alert(message);
return false;
}
}
}
if (document.layers){
document.captureEvents(Event.MOUSEDOWN);
document.onmousedown=clickNS4;
}
else if (document.all&&!document.getElementById){
document.onmousedown=clickIE4;
}
document.oncontextmenu=new Function("alert(message);return false")
</script>
<script type="text/javascript" src="http://apis.google.com/js/plusone.js"></script>
<%} else {
	System.out.println("No Content Found - Gallery Page ("+galleryId+")");
	response.sendRedirect(MegacriticCommonConstants.PAGE_NOT_FOUND);
}
%>

</div>

</div>
   <div id="left_section"> 
   
	<%--   <s:include value="photoSection.jsp"></s:include>  --%>
	  
	<div class="video_main_cont">
	<ul class="bg">
    <s:iterator id="photo" value="%{photos}" status="stat">
    <li><div class="video_box_h">
    <div class="video_img">
     <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#photo.contentUrl}"/>">
    <img src="<%=MegacriticCommonConstants.GALLERY_IMG_PATH %><s:property value="%{#photo.smallImage}"/>" alt="img" />
    </a>
    <div class="camera"></div>
    </div>
    <div class="video_des">
   <s:property value="%{#photo.galleryName}"/>
    </div>
    </div></li>
    
    </s:iterator>
    </ul>
   
    </div>
    
    
	  </div>
 <!--right section-->
    <div id="right_section"> 
    <s:include value="rightNavigation.jsp"></s:include>        
    </div>
</div>

</div>
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>


<%if(rightNavigationPath.trim().length() != 0) { %>
<script src="http://indiatoday.intoday.in/js/jquery.lazyload.js?v=4" type="text/javascript" charset="utf-8"></script>
<script>
$(function() {
		$(document).find("img[data-original]").lazyload({
	      failure_limit : 20 
	    });
	});	
 </script>
 <%} %>


<script type="text/javascript">
    var ttsmi2_data = { siteid: 38824, count: 'site' };
    (function() {
      var sc = document.createElement('script'); sc.type = 'text/javascript'; sc.async = true;
      sc.src = '//target.smi2.net/client/target.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(sc, s);
    }());
  </script>
  <!--NEW from-->
<script type="text/javascript">
var ftemp = jQuery.noConflict();
var counter_thumb =1;
var len = '';
ftemp(document).ready(function(){
	var len = $('.overview li').length;
	var glestw = $('.overview li').width();
	var finalwid = len*(glestw+33)
	    $('.overview').css('width', finalwid);
	
	$('.prev').css('opacity', '0.5');
	$('.prev').on("click", function(){
		if (counter_thumb == 1) {
			$('.prev').css('opacity', '0.5');
		} else {
			$('.overview').animate({
				left : '+=120'
			});
			counter_thumb -=1;
			$('.next').css('opacity', '1');
		}
	});
	$('.next').on("click", function(){
		if (counter_thumb == len-4) {
			$('.next').css('opacity', '0.5');
		} else if (counter_thumb<len){
			$('.overview').animate({
				left : '-=120'
			});
			counter_thumb +=1;
			$('.prev').css('opacity', '1');
		}
	});
	
	$(".most_main").mCustomScrollbar({});
});



</script>
<!--NEW till-->

</body></html>
</cache:cache>
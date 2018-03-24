<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ include file="/jsp/common/css-js.jsp" %>


<!--header-->
<%@ include file="/jsp/common/header.jsp" %>

<div class="wrapper">



<!--body section-->


  
    <!--left section-->
    
    
    <%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@page import="com.indiatoday.megacritic.service.MegacriticHomeServiceImpl"%>
<%@page import="com.indiatoday.megacritic.service.MegacriticHomeService"%>
<%@page import="com.indiatoday.megacritic.domain.Video"%>
<%@ page language="java" import="java.util.ArrayList,java.util.regex.Matcher,java.util.regex.Pattern" pageEncoding="ISO-8859-1"%>
<% 
String youtubeUrl="";
String baseUrl = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getServletPath()))+"/";	
	if(request.getServerName().contains("origin-")) {
		baseUrl = MegacriticCommonConstants.SITE_URL;
	}
	try{
int videoId = 421835;
int currentVideoPageNo =1 ;
if(request.getAttribute("currentVideoId")!=null)
	videoId = Integer.parseInt(request.getAttribute("currentVideoId").toString());
if(request.getAttribute("currentVideoPageNo")!=null)
	currentVideoPageNo = (Integer)request.getAttribute("currentVideoPageNo"); 
%>
<%
//String nm = "";
String mp4video = "";
String mp4videoWebPath = "";
int mp4videoFlag = 0;
String ThreeGPvideoPath="";
String ThreeGPvideoPath2="";
String ThreeGPvideoPath3="";
String ThreeGPvideoPathFinal="";
String videoTitle = "";
String videoTitleAlias = "";
String videoDescription = "";
String videoSefTitle = "";
String videoByline = ""; 
String videoCreatedDate = "";
String pageMetaTitle = "";
String pageMetaKeywords = "";
String pageMetaDescription = "" ;
String topNavigationPath = "" ;
String rightNavigationPath = "" ;
String bottomNavigationPath = "" ;
String leftNavigationPath = "" ;
String headerImage = "";
String extraLargeImage="";
String kickerImage="";
//int totalVideoCount = 0;
int commentCount=0;
int sectionId = 0;
String sectionTitle  = "" ;
String sectionSefTitle  = "" ;
int primaryCategoryId = 0;
String primaryCategory = "";
String primaryCategoryTitle  = "" ;
String primaryCategorySefTitle  = "" ;
int primaryCategoryLength = 0;
String currentVideoFileType = "";
String currentVideoFileName = "";

String cacheErrMsg = request.getParameter("message");
if(cacheErrMsg==null)
	cacheErrMsg = "";

String videoFileNameComplete = "";
String videoFileFolderName = "";
int isExternalVideo = 0;
String largeKickerImage = "";
String urlUpdate= "";
String logoAndroidUrl="";

 Video aDTO=null;
MegacriticHomeService megacriticHomeService=new MegacriticHomeServiceImpl();
aDTO=megacriticHomeService.getVideoDetail(videoId, 1);
if (aDTO != null){
	
		videoTitle = aDTO.getVideoTitle()==null ?"":aDTO.getVideoTitle();
		videoTitleAlias = aDTO.getVideoTitleAlias();
		videoSefTitle = aDTO.getVideoSefTitle();
		videoByline = aDTO.getVideoByline();
		topNavigationPath = aDTO.getTopNavigationPath();
		rightNavigationPath = aDTO.getRightNavigationPath();
		bottomNavigationPath = aDTO.getBottomNavigationPath();
		leftNavigationPath = aDTO.getLeftNavigationPath();
		primaryCategory = aDTO.getPrimaryCategory();
		videoCreatedDate = aDTO.getVideoCreatedDate();
		videoDescription = aDTO.getVideoDescription();
		headerImage = aDTO.getHeaderImage();
		extraLargeImage=aDTO.getVideoLargeKickerImage();
		largeKickerImage=aDTO.getVideoLargeKickerImage();
		kickerImage=aDTO.getVideoKickerImage();
		mp4videoFlag = aDTO.getMp4VideoFlag();
		sectionId = aDTO.getVideoSectionId();
		sectionTitle = aDTO.getVideoSectionTitle();
		sectionSefTitle = aDTO.getVideoSectionSefTitle();
		if(aDTO.getExternalVideoUrl().trim().length() > 0) {
			isExternalVideo = 1;
		}
		youtubeUrl=aDTO.getYoutubeUrl();

		primaryCategory = aDTO.getPrimaryCategory(); 
		primaryCategoryLength = aDTO.getPrimaryCategoryLength();
		primaryCategoryTitle = aDTO.getVideoSectionTitle();
		if(primaryCategoryLength == 2) {
			primaryCategoryId = aDTO.getVideoCategoryId();
			primaryCategoryTitle = aDTO.getVideoCategoryTitle();
			primaryCategorySefTitle = aDTO.getVideoCategorySefTitle();
		}

		pageMetaTitle = (videoTitleAlias + " | " + primaryCategoryTitle + " Videos | - India Today").replaceAll("\\<.*?>","");
		pageMetaKeywords = aDTO.getMetaKeywords().replaceAll("\\<.*?>","");
		pageMetaDescription = aDTO.getMetaDescription().replaceAll("\\<.*?>","");
		if(currentVideoPageNo > 1) {
			pageMetaTitle = pageMetaTitle + " - Part "+currentVideoPageNo;
			pageMetaKeywords = pageMetaKeywords + " - Part "+currentVideoPageNo;
			pageMetaDescription = pageMetaDescription + " - Part "+currentVideoPageNo;
		}

		videoFileNameComplete = aDTO.getVideoFile();
		if(videoFileNameComplete.trim().length() == 0){
			videoFileNameComplete=aDTO.getExternalVideoUrl();
		}
		videoFileFolderName = aDTO.getVideoFolder();
		commentCount = aDTO.getVideoCommentCount();

		//System.out.print("videoFileNameComplete--->"+videoFileNameComplete+"----videoFileFolderName--->"+videoFileFolderName);
	}
if(pageMetaTitle.trim().length() <= 0) {
	pageMetaTitle = "India Today: India News, Latest India News, Breaking News India, News in India, World, Business, Cricket, Sports, Bollywood News India : India Today";
}

if(youtubeUrl!=null && youtubeUrl.equalsIgnoreCase("<br>"))
{
StringBuffer videoFilePathSB_CS=new StringBuffer();

ArrayList videoFilesAL = (ArrayList) MegacriticCommonConstants.videoFileNameAL(videoFileNameComplete);
int noofvideos = videoFilesAL.size();
if (videoFilesAL != null && videoFilesAL.size() > 0) {
	for (int ctr = 0; ctr < videoFilesAL.size(); ctr++) {
		if(videoFileNameComplete.contains("http://")){
			videoFilePathSB_CS.append('"'+(String)videoFilesAL.get(ctr)+'"');
		}else{
			//videoFilePathSB_CS.append('"'+Constants.VIDEO_PATH);
			videoFilePathSB_CS.append('"'+"http://mediacloud.intoday.in/indiatoday/video/");

			if(videoFileFolderName.trim().length()>0) {
				videoFilePathSB_CS.append(videoFileFolderName+"/");
			}
			videoFilePathSB_CS.append((String)videoFilesAL.get(ctr)+'"');
		}
		if(ctr!=videoFilesAL.size()-1)
			videoFilePathSB_CS.append(",");
	}
}
int part = 0;
if (request.getParameter("part")!=null) {
	part = Integer.parseInt(request.getParameter("part"));
} else {
	part = currentVideoPageNo -1;
	if(part < 0 || part >= noofvideos)
		part = 0;
}

String[] videoFilesSA1 = null;
if(videoFilePathSB_CS.indexOf(",") > 0) {
	videoFilesSA1 = videoFilePathSB_CS.toString().split(",");
	currentVideoFileName = videoFilesSA1[part].replaceAll("\"", "");
} else {
	currentVideoFileName = videoFilePathSB_CS.toString().replaceAll("\"", "");
}


if(currentVideoFileName.length() > 0 && currentVideoFileName.indexOf(".") > 0) {
	currentVideoFileType=currentVideoFileName.substring(currentVideoFileName.lastIndexOf

(".")+1,currentVideoFileName.length());
}
request.setAttribute("videoCatidForAd", ""+primaryCategoryId); 
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>| Video | <%=pageMetaTitle%></title>
<meta name="description" content="<%=pageMetaDescription%>" />
<meta name="keywords" content="<%=pageMetaKeywords%>" />
<link rel="canonical" href="<%=MegacriticCommonConstants.SITE_URL+MegacriticCommonConstants.videoURL(videoSefTitle, 1, videoId) %>" />
 <script type="text/javascript" src="http://media2.intoday.in/microsites/affle-player/jwplayer/jwplayer.js"></script>
 <script type="text/javascript" src="http://media2.intoday.in/microsites/affle-player/jwplayer/ripple.js"></script>
<style>
.share-story ul { display:block}
.share-story li {padding: 0 18px 0 0;}
</style> 
<%
if(currentVideoFileType.equals("flv") || currentVideoFileType.equals("mp4")) {
	int streamer=1;
	String arrPlaylistnew[]={videoFilePathSB_CS.toString()};
	String splittedArray[]=arrPlaylistnew[0].split(",");
	String mp4videoWebPathnew[]=new String [splittedArray.length];
	String mp4videonew[]=new String [splittedArray.length];
	String ThreeGPvideoPathFinalnew[]=new String [splittedArray.length];
	String mp4basepath = "";
	String mp4path = "";
	for(int i=0;i<splittedArray.length;i++){
	if(splittedArray[i].indexOf(".mp4") >= 0 && (splittedArray[i].indexOf("videodeliverys3") >= 0 || splittedArray[i].indexOf("medias3d") >= 0)) {
		mp4videoWebPathnew[i]  = "mp4:"+splittedArray[i].replace("http://videodeliverys3.s3.amazonaws.com/","").replace("http://medias3d.intoday.in/", "").replaceAll("\"","");
		}else{
			mp4videoWebPathnew[i] = "mp4:"+splittedArray[i].replace("http://videodeliverys3.s3.amazonaws.com/", "").replace("http://medias3d.intoday.in/", "").replace(".flv", ".mp4").replaceAll("\"","");
		}
		
		if(splittedArray[i].indexOf(".flv") > 0 && mp4videoFlag==0)
		{
			mp4videoWebPathnew[i]=splittedArray[i];
		     streamer=0;
				}
		else{	if(splittedArray[i].indexOf("mediacloud.intoday.in") > 0) {
			mp4videoWebPathnew[i] = "mp4:"+splittedArray[i].replace("http://mediacloud.intoday.in/", "").replace(".flv", ".mp4").replaceAll("\"","");
			mp4videoWebPathnew[i] = mp4videoWebPathnew[i].substring(0, mp4videoWebPathnew[i].lastIndexOf("_")) + ".mp4";
							streamer=1; 
							} else {
								mp4videoWebPathnew[i] = "mp4:"+splittedArray[i].replace("http://videodeliverys3.s3.amazonaws.com/", "").replace("http://medias3d.intoday.in/", "").replace(".flv", ".mp4").replaceAll("\"","");
							streamer=1; 
							}
						}
		
		if(isExternalVideo==1) {
			if(splittedArray[i].indexOf(".flv") > 0) {
				splittedArray[i] = splittedArray[i].substring(0, splittedArray[i].lastIndexOf("."))+".mp4";
			}
			mp4videonew[i] = splittedArray[i];
			if(mp4videonew[i].indexOf("http://videodeliverys3.s3.amazonaws.com/indiatoday/video/") >= 0) {
				mp4videonew[i] = mp4videonew[i].replaceAll("http://videodeliverys3.s3.amazonaws.com/indiatoday/video/", "http://d1jhvk1xjm92rd.cloudfront.net/vods3/_definst_/mp4:amazons3/videodeliverys3/indiatoday/video/");
			}
			if(mp4videonew[i].indexOf("http://mediacloud.intoday.in/indiatoday/video/") >= 0) {
				mp4videonew[i] = mp4videonew[i].replaceAll("http://mediacloud.intoday.in/indiatoday/video/", "http://d1jhvk1xjm92rd.cloudfront.net/vods3/_definst_/mp4:amazons3/videodeliverys3/indiatoday/video/");
			}
		} else {
			//mp4basepath = "http://videodeliverys3.s3.amazonaws.com/indiatoday/video/";
			mp4basepath = "http://d1jhvk1xjm92rd.cloudfront.net/vods3/_definst_/mp4:amazons3/videodeliverys3/indiatoday/video/";
			if(splittedArray[i].indexOf(".flv") > 0) {
				mp4path = splittedArray[i].substring(splittedArray[i].lastIndexOf("/")+1, splittedArray[i].lastIndexOf("_"))+".mp4";
			} else {
				mp4path = splittedArray[i].substring(splittedArray[i].lastIndexOf("/")+1, splittedArray[i].length());
			}
			mp4videonew[i] = mp4basepath+""+videoFileFolderName+"/"+mp4path;
		}
		if(mp4videonew[i].indexOf("http://d1jhvk1xjm92rd.cloudfront.net/vods3/_definst_/mp4:amazons3/videodeliverys3") >= 0) {
			mp4videonew[i] = mp4videonew[i] + "/playlist.m3u8";
		} 
			
		 if(splittedArray[i].toString().indexOf(".flv")>0){
	         ThreeGPvideoPath=splittedArray[i].replace(".flv", ".3gp");
	         }
	         else if(splittedArray[i].indexOf(".mp4")>0)
	         {
	       	  ThreeGPvideoPath=splittedArray[i].replace(".mp4", ".3gp");
	       	  
	         }
	         if(ThreeGPvideoPath.contains("media1.intoday.in")){
	         ThreeGPvideoPathFinal=ThreeGPvideoPath.replace("http://media1.intoday.in","http://mediacloud.intoday.in");
	         }
	         else{
	       int lastslash=  ThreeGPvideoPath.lastIndexOf("/");
	        ThreeGPvideoPath2=ThreeGPvideoPath.substring(0,lastslash)+"/3gp";
	        ThreeGPvideoPath3=ThreeGPvideoPath.substring(lastslash,ThreeGPvideoPath.length());
	        ThreeGPvideoPathFinalnew[i]=ThreeGPvideoPath2+ThreeGPvideoPath3;
	       }
		
	}
		urlUpdate=videoFilePathSB_CS.toString();
         	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");
%>

	<script type="text/javascript">	
	var myUserAgent = navigator.userAgent;
	var currentItem=<%=part%>;
	var videoSectionId=<%=primaryCategoryId%>;
	var vdopiavideoid=<%=videoId%>;
	//	var arrPlaylist=[<%//=videoFilePathSB_CS.toString()%>];
	var arrPlaylist=[<%=urlUpdate%>];
	var autoplay="true";
	var mp4videoFlagJS = <%=mp4videoFlag%>;
	if(myUserAgent.search("Android") >=0 && (myUserAgent.substring(myUserAgent.indexOf("Android")+8, myUserAgent.indexOf("Android")+9)) >= 4) {
	//alert("santosh");
		<% if(splittedArray.length==1){

         	urlUpdate=mp4videonew[0].replaceAll("\"","");
         	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");
         	logoAndroidUrl=urlUpdate;
         	%>
         	 $(document).ready(function() {
	        $("#videoplayer").append("<A HREF=\"<%=urlUpdate%>\"><img src=\"<%=MegacriticCommonConstants.STORY_IMG_PATH+largeKickerImage%>\"  style='margin:15px 0;width:480px' /><span class='pmedia-play-icon' style='bottom: 149px;display:block;height: 38px;position: absolute;right: 299px;width: 37px;z-index: 100;'></A>");
	});
	<%	
	}else{
	%>
	 $(document).ready(function() {
	<%
	StringBuffer sbuffer= new StringBuffer();
	for(int ctr2=0; ctr2 < splittedArray.length; ctr2++) { 	
 	urlUpdate=mp4videonew[ctr2].replaceAll("\"","");
	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");	
	if(currentVideoPageNo==(ctr2+1)){
	logoAndroidUrl=urlUpdate;
	%>
	$("#videoplayer").append("<A style=\"float:left;clear:both;\" HREF=\"<%=urlUpdate%>\"><img src=\"<%=MegacriticCommonConstants.STORY_IMG_PATH+largeKickerImage%>\"  style='margin:15px 0;width:480px;' /><span class='pmedia-play-icon'     style='bottom: 149px;display: block;height: 38px;position: absolute;right: 299px;width: 37px;z-index:100;'></span></A><div style='clear:both;width:100%;height:10px;'></div>");
	<%	
	}
	}
 	for(int ctr2=0; ctr2 < splittedArray.length; ctr2++) {
	%>
	$("#videoplayer").append("<a style=\"float:center;padding:2px 4px;\" href=\"<%=MegacriticCommonConstants.videoURL(videoSefTitle,ctr2+1,videoId)%>\">Part <%=ctr2+1%></A>");
	<%	
	}
	%>
	});
	<%
	} %>
	}else{
            $(document).ready(function() {
                jwplayer("videoplayer").setup({
                    'flashplayer': "http://media2.intoday.in/microsites/affle-player/jwplayer/player.swf",
                    'controlbar.position': 'bottom',
                    'image': 'http://media2.intoday.in/indiatoday/images/stories/<%=extraLargeImage%>',
		        	'autostart': true,
				    'stretching': 'fill',
					'skin': 'http://media2.intoday.in/microsites/affle-player/newtubedark1/NewTubeDark.xml',	 
					
					<% if(splittedArray.length==1){ %>
					 	
					'width': 480,
                    'height': 360,
                    <% if(streamer==1){ %>
                    'provider': "rtmp",	 'streamer': "rtmp://mediaclouds3.intoday.in:80/cfx/st",
		 
		 <%}%>
                    
				 'file': '<%=mp4videoWebPathnew[0].replaceAll("\"","")%>',					

	
					'modes': [
        {type: 'flash', src: 'http://media2.intoday.in/microsites/affle-player/jwplayer/player.swf',
        config: {
		 'file': '<%=mp4videoWebPathnew[0].replaceAll("\"","")%>'
		 
		}
		},
		{
          type: 'html5',
          config: {
          <%
         	urlUpdate=mp4videonew[0].replaceAll("\"","");
         	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");
         	%>
          
           'file': '<%=urlUpdate%>',
           'provider': 'video'
          }
		  
        },
		{
          type: 'download',
          config: {
         
          <%
         	urlUpdate=ThreeGPvideoPathFinalnew[0].replaceAll("\"","");
         	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");
         	%>
           'file': '<%=urlUpdate%>',
           'provider': 'video'
          }

        }
    ],   
    
    <%} else { %>
    	'width': 480,
        'height': 480,
    'playlist': [
    	<% for(int ctr=0; ctr < splittedArray.length; ctr++) {%>
                    {'title': "Part<%=ctr+1%>: <%=videoTitle%>  ",
                    'image': 'http://media2.intoday.in/indiatoday/images/stories/<%=extraLargeImage%>',
                    
                    <% if(streamer==1){ %>
		 'streamer': "rtmp://mediaclouds3.intoday.in:80/cfx/st",
		 'provider': 'rtmp',
		 <%}%>
		 file: '<%=mp4videoWebPathnew[ctr].replaceAll("\"","")%>' }
		 <% if(ctr+1<splittedArray.length) out.print(","); }%>
		 
    		],modes: [
          { 'type': 'flash', 'src': 'http://media2.intoday.in/microsites/affle-player/jwplayer/player.swf'},
		{
          type: 'html5',
		  config: {'playlist': [
		   <% for(int ctr2=0; ctr2 < splittedArray.length; ctr2++) { %>
		    {'title': "Part<%=ctr2+1%>: <%=videoTitle%>  ",
			 'image': "http://media2.intoday.in/indiatoday/images/stories/<%=extraLargeImage%>", 
			
					'provider': "video",
			<%
         	urlUpdate=mp4videonew[ctr2].replaceAll("\"","");
         	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");
         	%>
           'file': '<%=urlUpdate%>',	
			 
			 } 			 
			<% if(ctr2+1<splittedArray.length) out.print(",");  } %>]
			}

        },
		{
          type: 'download',
		  config: {
		  <%
         	urlUpdate=ThreeGPvideoPathFinalnew[0].replaceAll("\"","");
         	urlUpdate=urlUpdate.replaceAll("http://videodeliverys3.s3.amazonaws.com","http://medias3d.intoday.in");
         	%>
           'file': '<%=urlUpdate%>',		    
		   'provider': 'video'

		  }
			
        }
    ], "playlist.position": "bottom",
        "playlist.size": 120,
    
    <% }%>
	

	'plugins': {

		<%if (primaryCategoryId==705) {%>      
     related:{"heading":"Recommended Videos","oncomplete": true,"onpause": true,"dimensions":"155x115", "onclick": "link",file: "http://indiatoday.intoday.in/rss/sosorry-rss.jsp?id=<%=videoId%>"}, <%}%>

	       
                        'http://media2.intoday.in/microsites/affle-player/jwplayer/ova-jw.swf': {
                        <% if(splittedArray.length>1){ %>
                        'allowPlaylistControl': true,
                        <%} %>
                       
                        "debug": {
                     "levels": "none" },
                       'like-1': {},
						                            'ads': {
														

'enforceLinearAdsOnPlaylistSelection': true,   
							  'companions': {
									'class':"storm-vast-companion",
                                    'restore': false,
                                    'regions': [
                                        {
                                        'id': "companion",
                                        'width': 300,
                                        'height': 250
                                        }
                                    ]
                                },
                                'vpaid': {
                                    'holdingClipUrl': "http://medias3d.intoday.in/indiatoday/video/jwplayer/blank.mp4"
                                },
                                'schedule': [
                                    {
                                    'position': "pre-roll",
                                    <% if(primaryCategoryId==427 || primaryCategoryId==218 || videoId==154230 || 

videoId==362149){%>
                                    'tag': "",
                                    <%}else {%>
									<% if(splittedArray.length==1){%>
                                    'tag': "http://xp1.zedo.com/jsc/d2/fns.vast?n=821&c=2040/1137&d=39&s=2&v=vast2&pu=__page-url__&ru=__referrer__&pw=__player-width__&ph=__player-height__&z=__random-number__",
										 <%} else{%>
									'tag': "http://xp1.zedo.com/jsc/d2/fns.vast?n=821&c=2040/1137&d=39&s=2&v=vast2&pu=__page-url__&ru=__referrer__&pw=__player-width__&ph=__player-height__&z=__random-number__",
                                    <%}}%>
                                    'duration': 25
                                    }
                                ]
                            }
                        }
                    }
                }); 
            });
        	
	}
	</script>
<%}%>
<%if(rightNavigationPath!=null && rightNavigationPath.trim().length() != 0) { %>
<style>
#spc-topnav { margin: 0 auto; width: 1000px; }
#spc-rightnav {width:300px; float:right; text-align:left}	

</style>
<%} %>




</head>
<body>
<div class="skinnin-ad-container">
<%if(rightNavigationPath!=null && rightNavigationPath.trim().length() == 0) { %>
<%-- <%@//include file="navigation_topnav_2015.jsp"%> --%>
<%}else{ %>
<div id="spc-topnav"><jsp:include page="<%=topNavigationPath%>" flush="true" /><div>
<%} %>

<div id="main_container" style="position:relative; ">
<div >
<%if(primaryCategoryId==963){%>
<div style="padding:15px 0"><a href="http://indiatoday.intoday.in/elections/assembly/2015/delhi/index.jsp"><img border="0" 

src="http://media2.intoday.in/indiatoday/election_delhi_2015/delhi_election2015.gif"></a></div>
<%} %>
<div class="phvid-leftnav">
<div class="phvidpathway"><div class="path lft">
<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="lft pathone"></div> <%if(primaryCategoryId!=0) {%><div itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="lft pathtwo"><a href="<%=MegacriticCommonConstants.videoListURL(primaryCategorySefTitle, 1,primaryCategoryId)%>" itemprop="url"><span itemprop="title"></span></a></div> <%}%><div itemscopeitemtype="http://data-vocabulary.org/Breadcrumb" class="lft paththree"> <img src="http://media2.intoday.in/indiatoday/images/bed-arrow.png" border="0"></div></div></div>
<div class="clear"></div>
<div class="video-boxcont">
<div class="videocont">
	<%if (currentVideoFileType.equals("wmv")) {%>
		<script type="text/javascript">AC_AX_RunContent( 'id','Player2','classid','CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6','style','display:block;','width','278','height','247','type','application/x-mplayer2','src','<%=currentVideoFileName%>','name','Player','autostart','true','stretchtofit','True','uimode','full','url','<%=currentVideoFileName%>' ); //end AC code
</script><noscript><object id="Player2" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" style="display: block;" 

width="278" height="247">
		<param name="autostart" value="true" id="A1">
		<param name="stretchToFit" value="True">
		<param name="uiMode" value="full">
		<param name="URL" 	value="<%=currentVideoFileName%>">
		<embed type="application/x-mplayer2" src="<%=currentVideoFileName%>" name="Player" autostart="true" width="278" 

height="247"></object></noscript>
		<script type="text/javascript">AC_AX_RunContent( 'id','Player3','classid','CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6','style','display: none;','width','278','height','247','type','application/x-mplayer2','src','<%=currentVideoFileName%>','name','Player','autostart','false','stretchtofit','True','uimode','full','url','<%=currentVideoFileName%>' ); //end ACcode
</script><noscript><object id="Player3" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" style="display: none;" width="278" 

height="247">
		<param name="autostart" value="false" id="A1">
		<param name="stretchToFit" value="True">
		<param name="uiMode" value="full">
		<param name="URL" 	value="<%=currentVideoFileName%>">
		<embed type="application/x-mplayer2" src="<%=currentVideoFileName%>" name="Player" autostart="true" width="278" 

height="247">
		</object></noscript>
<%} else if (currentVideoFileType.equals("flv") || currentVideoFileType.equals("mp4")) { %>
<script>
	var mp4VideoParts="";
	if(myUserAgent.search("Android") >=0 && (myUserAgent.substring(myUserAgent.indexOf("Android")+8, myUserAgent.indexOf("Android")+9)) >= 4) {
		document.write('<div style=\"padding: 2px 0 0 0px; margin: 0px 5px;\"><div style=\"margin:0 auto;position:relative; width:100%; text-align:center;\"><div align=\"center\" style=\"display:inline-block\" id=\"videoplayer\"></div></div></div><div style=\"color:#FF9900;background-color:#1f1f1f;margin-left:5px;padding:2px;\">')
		document.write('</div>');
	}else{
		document.write('<div style=\"padding: 2px 0 0 0px; margin: 0px 5px;\"><div style=\"margin:0 auto; \"><div align=\"center\" id=\"videoplayer\"></div></div></div><div style=\"color:#FF9900;background-color:#1f1f1f;margin-left:5px;padding:2px;\">')
		document.write('</div>');
		}
</script>
<% }}else{ %>
<div class="skinnin-ad-container">
<%if(rightNavigationPath!=null && rightNavigationPath.trim().length() == 0) { %>
<%-- <%@//include file="navigation_topnav_2015.jsp"%> --%>
<%}else{ %>
<div id="spc-topnav"><jsp:include page="<%=topNavigationPath%>" flush="true" /><div>
<%} %>

<div id="main_container" style="position:relative; ">
<div >
<%if(primaryCategoryId==963){%>
<div style="padding:15px 0"><a href="http://indiatoday.intoday.in/elections/assembly/2015/delhi/index.jsp"><img border="0" 

src="http://media2.intoday.in/indiatoday/election_delhi_2015/delhi_election2015.gif"></a></div>
<%} %>
<div class="phvid-leftnav">
<div class="phvidpathway"><div class="path lft">
<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="lft pathone"></div> <%if(primaryCategoryId!=0) {%><div itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="lft pathtwo"><a href="<%=MegacriticCommonConstants.videoListURL(primaryCategorySefTitle, 1,primaryCategoryId)%>" itemprop="url"><span itemprop="title"></span></a></div> <%}%><div itemscopeitemtype="http://data-vocabulary.org/Breadcrumb" class="lft paththree"> <img src="http://media2.intoday.in/indiatoday/images/bed-arrow.png" border="0"></div></div></div>
<div class="clear"></div>
<div class="video-boxcont">
<div class="videocont">
	<%if (currentVideoFileType.equals("wmv")) {%>
		<script type="text/javascript">AC_AX_RunContent( 'id','Player2','classid','CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6','style','display:block;','width','278','height','247','type','application/x-mplayer2','src','<%=currentVideoFileName%>','name','Player','autostart','true','stretchtofit','True','uimode','full','url','<%=currentVideoFileName%>' ); //end AC code
</script><noscript><object id="Player2" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" style="display: block;" 

width="278" height="247">
		<param name="autostart" value="true" id="A1">
		<param name="stretchToFit" value="True">
		<param name="uiMode" value="full">
		<param name="URL" 	value="<%=currentVideoFileName%>">
		<embed type="application/x-mplayer2" src="<%=currentVideoFileName%>" name="Player" autostart="true" width="278" 

height="247"></object></noscript>
		<script type="text/javascript">AC_AX_RunContent( 'id','Player3','classid','CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6','style','display: none;','width','278','height','247','type','application/x-mplayer2','src','<%=currentVideoFileName%>','name','Player','autostart','false','stretchtofit','True','uimode','full','url','<%=currentVideoFileName%>' ); //end ACcode
</script><noscript><object id="Player3" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" style="display: none;" width="278" 

height="247">
		<param name="autostart" value="false" id="A1">
		<param name="stretchToFit" value="True">
		<param name="uiMode" value="full">
		<param name="URL" 	value="<%=currentVideoFileName%>">
		<embed type="application/x-mplayer2" src="<%=currentVideoFileName%>" name="Player" autostart="true" width="278" 

height="247">
		</object></noscript>
		<%} %>
<div style="padding: 2px 0 0 0px; margin: 0px 5px;"><div style="margin:0 auto; "><div align="center" id="videoplayer">
<iframe width="560" height="315" src="<%=youtubeUrl%>" frameborder="0" allowfullscreen></iframe></div></div></div>
 <!--<div style="color:#FF9900;background-color:#1f1f1f;margin-left:5px;padding:2px;" ></div>-->
<%} %>
</div>
<style>
.videobox { padding:10px 10px;}
.videobox h2{ color:#fff;}
.videobox p{ color:#fff;}
</style>
<div class="videobox">
<h2><%=videoTitle%></h2>
<p><%=videoDescription%></p>

	<%
	if(videoByline!=null && !videoByline.trim().equals("")) {
		//out.print(videoByline);
	}
	if(videoCreatedDate!=null &&(!videoByline.trim().equals("") && videoByline!=null) && (!videoCreatedDate.trim().equals

(""))) {
		//out.print(" | ");
	}		 
	%>
<div class="clear"></div>
</div>
</div>





<%}catch(Exception e){
	e.printStackTrace();
//response.sendRedirect(Constants.PAGE_NOT_FOUND);
} %>

    
    
   
    
    
    
    
    <div class="video_main_cont">  <div class="com_head" style="margin-top:10px">
          <h2><strong>Latest Videos</strong><span></span><small></small></h2>
        </div>
    <ul class="bg">
    
     <s:iterator id="video" value="%{videos}" status="stat">
    <li><div class="video_box_h">
    <div class="video_img">
    <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>">
    <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.kickerImage}"/>" alt="img" />
   </a>
    <div class="play_icon_h"></div>
    </div>
    <div class="video_des">
   <s:property  value="%{#video.videoTitle}"/>
    </div>
    </div></li>
    </s:iterator>
        
  
   
    </ul>
    </div>
    
    
    <div class="video_main_cont">  
    <div class="com_head">
          <h2><strong>Others Videos</strong><span></span><small></small></h2>
        </div>
    
    <ul class="bg">
    
     <s:iterator id="video" value="%{videos}" status="stat">
    <li><div class="video_box_h">
    <div class="video_img">
    <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>">
    <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.kickerImage}"/>" alt="img" />
    </a>
    <div class="play_icon_h"></div>
    </div>
    <div class="video_des">
   <s:property  value="%{#video.videoTitle}"/>
    </div>
    </div></li>
    </s:iterator>
        
  
   
    </ul>
    </div>
    
   
     </div>
     </div>
  
   
    

    
   
  
   
   
    
      <div id="right_section"> 
    <!--right section-->
     <s:include value="/jsp/home/rightNavigation.jsp"></s:include>     
  </div>
   </div>
  </div>
   </div>
</div>
<!--footer-->
<div class="clearfix"></div></div>
<s:include value="/jsp/common/footer.jsp"></s:include>

</body>
</html>






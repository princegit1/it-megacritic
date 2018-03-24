<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Video Gallery</title>
<%@ include file="/jsp/common/css-js.jsp" %>
</head>
<body>
<!--header-->
<%@ include file="/jsp/common/header.jsp" %>
<!--body section-->
<div class="wrapper">
  <div id="body_section">
    <!--left section-->
    <div id="left_section">
    <div class="video_main_cont">
    <s:iterator id="video" value="%{videos}" status="stat">
    <s:if test="%{#stat.count==1}">
    <div class="top_photo_main_h">
    <div class="top_photo_img">
      <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>">
    <img alt="img" src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.extraLargeKickerImage}"/>">
    </a>
    <div class="l_play_icon_h"></div>
    </div>
    <div class="top_photo_des"><a href="#"><s:property  value="%{#video.videoTitle}"/></a></div>
    </div>
    <ul class="bg">
    </s:if>
    <s:else>
    <li><div class="video_box_h">
    <div class="video_img">
     <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>">
    <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.kickerImage}"/>" alt="img">
    </a>
    <div class="play_icon_h"></div>
    </div>
    <div class="video_des">
   <s:property  value="%{#video.videoTitle}"/>
    </div>
    </div></li>
    </s:else>
    </s:iterator>
    </ul>
    </div>
    </div>
      <div id="right_section"> 
    <!--right section-->
     <s:include value="/jsp/home/rightNavigation.jsp"></s:include>     
  </div>
</div>
</div>
<!--footer-->
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>
</body>
</html>

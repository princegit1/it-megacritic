<!DOCTYPE html>
<html>
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<head>
<meta charset="UTF-8">
<%@taglib uri="/struts-tags" prefix="s" %>
<title>Meta Critic</title>
<%@ include file="/jsp/common/css-js.jsp" %>
</head>
<body>
<!--header-->
<%@ include file="/jsp/common/header.jsp" %>
<div class="clearfix"></div>
<!--body section-->
<div class="wrapper">
  <div id="body_section"> 
    <!--left section-->
    <div id="left_section"> 
     <!--     TRAILERS & VIDEOS -->
     <div class="video_cont_new video_trailers_h">
     <s:iterator id="video" value="%{videos}" status="stat">
      <s:if test="%{#stat.count==1}">
       <div class="video_t_top">
          <div class="video_t_left"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.largeKickerImage}"/>" alt="Video"> <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>">
            <div class="video_icon"></div>
            </a> </div>
          <div class="video_t_right">
            <div class="video_hd">
              <h3><span><s:property  value="%{#video.videoTitle}"/></span></h3>
              <p>by yashraj</p>
            </div>
            <div class="clearfix"></div>
            <div class="video_des"> <span class="duration">Duration </span> <span class="watch_st">2382 watched this</span> </div>
          </div>
        </div>
        <ul>
        </s:if>
        <s:else>
          <li>
            <div class="box_vd">
              <div class="box_vd_img"><img width="180px" height="118px" src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.kickerImage}"/>" alt="video_tr_lg">
              <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>">
                <div class="vd_pl_icon"></div>
                </a>
                <span class="box_vd_bkt">
             <%--    <strong>2:30</strong> --%>
                </span> </div>
              <div class="box_vd_des"><s:property  value="%{#video.videoTitle}"/></div>
            </div>
          </li>
        </s:else>
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
<!--footer-->
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>
</body>
</html>

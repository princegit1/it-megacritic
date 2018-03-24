<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@taglib uri="/struts-tags" prefix="s" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Mega User Review</title>

<%@ include file="/jsp/common/css-js.jsp" %>

<style>
.critic_review .user_review .cont_area {
    padding: 10px 0;
}
</style>
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
      <!--bollywood rating-->
      <div class="brating">
        <h2>Bollywood Rating</h2>
        <div class="bbox">
            <ul>
            <li>
              <div class="rpanel"> <span class="star"><em>7.5</em></span>
                <div class="imgpanel"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/rating_img01.jpg"  alt="" /> </div>
                <strong>Happy Ending</strong> </div>
            </li>
            <li>
              <div class="rpanel"> <span class="star starsec"><em>7.5</em></span>
                <div class="imgpanel bgsec"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/rating_img01.jpg"  alt="" /> </div>
                <strong>Happy Ending</strong> </div>
            </li>
            <li>
              <div class="rpanel"> <span class="star starthd"><em>7.5</em></span>
                <div class="imgpanel bgthd"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/rating_img01.jpg"  alt="" /> </div>
                <strong>Happy Ending</strong> </div>
            </li>
            <li>
              <div class="rpanel"> <span class="star starfrth"><em>7.5</em></span>
                <div class="imgpanel bgfrth"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/rating_img01.jpg"  alt="" /> </div>
                <strong>&nbsp;</strong> </div>
            </li>
            <li>
              <div class="rpanel"> <span class="star starfth"><em>7.5</em></span>
                <div class="imgpanel bgfth"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/rating_img01.jpg"  alt="" /> </div>
                <strong>&nbsp;</strong> </div>
            </li>
          </ul>
        </div>
      </div>
      <!--trailers and video-->
      <div id="trailers_videos">
        <div class="com_head">
          <h2>Star <em style="font-style:normal;font-weight:bold;">Cast</em></h2>
        </div>
        <div class="star_cast">
  <div class="scr_left">
    <div class="scrl_l"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/left_arr.jpg" alt="left_arrow" /> </div>
  </div>
  <div class="scr_cont">
    <ul style="position:relative">
    <s:iterator id="starCast" value="%{starCastList}" status="stat">
      <li><a href="#">
        <div class="scroll_cont_h">
          
          <div class="scroll_cont_img"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#starCast.thumbImage}"/>" alt="img" /> </div>
          <div class="scroll_cont_des"><s:property value="%{#starCast.title}" /> </div>
        </div>
        </a></li>
        </s:iterator>
     
    </ul>
  </div>
  <div class="scr_right">
    <div class="scrl_r"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/right_arr.jpg" alt="Right_arrow" /></div>
  </div>
  <div class="clearfix"></div>
</div>

        <!--<div class="arrow_center">
          <div class="bottom_arrow"> </div>
        </div>-->
      </div>
      
      <div class="clearfix"></div>
  <!--critic review-->
<div class="critic_review">
  <div class="top_panel">
    <div class="top_panel_hd">
      <ul>
              
            <li><a href="critic-review">CRITIC Review</a></li>
        <li><a  class="active" href="user-review">USER Review</a></li>
      </ul>
    </div>
    <div class="clearfix"></div>
    <div class="top_cpanel">
      <div class="top_cpanel_left"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{review.mediumKickerImage}"/>" alt="left_revie" /> </div>
      <div class="top_cpanel_right">
        <h3>Mega Critic Score</h3>
        <p class="fl_name"><strong>Mardani</strong> (2014)</p>
       
       
        <div class="rating-box-common">
  <div class="rating-wrapper">
  
<div class="rating" style="width:<s:property value="%{review.commentAvg*20}"/>%;"></div>
</div>

 </div>
 
 
        <div class="clearfix"></div>
        <div class="rating_t"> Ratings: <s:property value="%{review.commentAvg}"/>/5 from <s:property value="%{review.storyCommentCount}"/> users </div>
        <div class="f_desc"><s:property value="%{review.title}"/> </div>
        <div class="social_shares">
          <ul>
            <li><a href="#">
              <div class="fb"></div>
              </a></li>
            <li><a href="#">
              <div class="tw"></div>
              </a></li>
            <li><a href="#">
              <div class="gp"></div>
              </a></li>
            <li><a href="#">
              <div class="rs"></div>
              </a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="clearfix"></div>
    <div class="user_review">
      <div class="user_review_hd"> USER <span>REVIEWS</span> </div>
      <div class="cont_area">
<script type="text/javascript">
ajaxinclude("<%=MegacriticCommonConstants.SITE_URL%>commentbox/comment_box.jsp?sId=<s:property value='%{review.id}'/>&website=megacritic&content_type=story&ScfUrl=<s:property value='%{review.title}'/>&StoryTitle=<s:property value='%{review.title}'/>&message=<%="test message"%>&sectionInfo=&storytemplate=special");
</script> 
      </div>
      <!-- <div class="user_rev_but">
        <input type="submit" class="btn_sb" value="POST REVIEW" />
      </div> -->
    </div>
  
   
  </div>
</div>

      <!--songs-->
      
      <div id="songs">
        <div class="com_head">
          <h2><strong>Latest <em>Trailers & Songs</em></strong><span></span><small></small></h2>
        </div>
        
        <div class="clearfix"></div>
 <div class="latest_trailers">
 
 <s:iterator id="video" value="%{videos}" status="stat">
   <s:if test="%{#stat.count==1}">
      
  <div class="l_trail_left">
    <div class="l_trail_left_img"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.largeKickerImage}"/>" alt="latest_tr" /> <a class="vplay" href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>"></a></div>
    <div class="l_trail_left_des"> <s:property  value="%{#video.videoTitle}"/> </div>
  </div>
 
  <div class="l_trail_right">
    <ul>
     </s:if>
     <s:else>
      <li>
        <div class="box_cnt"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.kickerImage}"/>" alt="img" />
          <div class="cover_bx">
            <div class="cover_text"><s:property  value="%{#video.videoTitle}"/></div>
            <div class="cover_socials">
              <ul>
                <li><a href="#">
                  <div class="fb"></div>
                  </a></li>
                <li><a href="#">
                  <div class="tw"></div>
                  </a></li>
                <li><a href="#">
                  <div class="gp"></div>
                  </a></li>
                <li><a href="#">
                  <div class="rs"></div>
                  </a></li>
              </ul>
            </div>
          </div>
        </div>
      </li>
      </s:else>
        </s:iterator>
    
    </ul>
  </div>
  </div> 
    <%--   <div id="songs">
     <div class="clearfix"></div>
  <s:include value="/jsp/home/videoSection.jsp"></s:include> 
      </div> --%>
      <!--photos-->
     <s:include value="/jsp/home/photoSection.jsp"></s:include>   
       <div class="clearfix"></div>
      <!--  Add Comment -->
 
     
    </div>
     </div>
    <!--right section-->
    <div id="right_section">

     <script src="http://ittemp.intoday.in/megacritic/js/jquery.mCustomScrollbar.concat.min.js"></script>
      <s:include value="/jsp/home/rightNavigation.jsp"></s:include>   
    </div>
 
</div>
<!--footer-->
<div class="clearfix"></div>
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>

</body>
</html>

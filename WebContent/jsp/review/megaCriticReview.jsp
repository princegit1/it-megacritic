<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@taglib uri="/struts-tags" prefix="s" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Mega Critic Review</title>

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
          <h2><strong>Star <em>Cast</em></strong><span></span><small></small></h2>
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
    <li><a style="color:#F8FB00" class="active" href="critic-review">CRITIC Review</a></li>
        <li ><a href="user-review">USER Review</a></li>
      </ul>
    </div>
    <div class="clearfix"></div>
    <div class="top_cpanel">
      <div class="top_cpanel_left"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{review.mediumKickerImage}"/>" alt="left_revie" /> </div>
      <div class="top_cpanel_right">
        <h3>Mega Critic Score</h3>
        <p class="fl_name"><strong>Mardani</strong> (2014)</p>
        <div class="fl_stars">
          <ul>
            <li class="fullstar"></li>
            <li class="fullstar"></li>
            <li class="fullstar"></li>
            <li class="halfstar"></li>
            <li class="blankstar"></li>
          </ul>
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
     <%--  <div class="user_review_hd"> USER <span>REVIEWS</span> </div> --%>
      
     <!--  <div class="user_rev_but">
        <input type="submit" class="btn_sb" value="POST REVIEW" />
      </div> -->
    </div>
    <div class="clearfix"></div>
    <div class="critic_f_main_panel">
    <ul>
        <li> <a href="#">
         <div class="critic_f_panel">
    
 <script type="text/javascript">
ajaxinclude("<%=MegacriticCommonConstants.SITE_URL%>commentbox/comment_box_critic_display.jsp?sId=<s:property value='%{review.id}'/>&website=megacritic&content_type=story&ScfUrl=<s:property value='%{review.title}'/>&StoryTitle=<s:property value='%{review.title}'/>&message=<%="test message"%>&sectionInfo=aaa&storytemplate=special");
</script>
</div>
</a>
</li>
</ul> 
      <!-- <ul>
        <li> <a href="#">
          <div class="critic_f_panel">
            <div class="critic_f_img"><img src="http://media2.intoday.in/indiatoday/megacritic/images/critic_f_panel.jpg" alt="Critic_f_panel" /></div>
            <div class="critic_f_cont">
              <h3> Thalaivar's 3 hours on-screen darshan, what else needed..!!! </h3>
              
              <p> If you are a critic or a movie lover of logic & sensible films, then please don't jump for Lingaa. It's only for SUPERSTAR fans.. </p>
            </div>
            <div class="clearfix"></div>
          </div>
          </a></li>
      </ul> -->
    </div>
    <div class="clearfix"></div>
   <!--  <div class="see_more_h"><a href="#">SEE MORE</a></div> -->
  </div>
</div>

      <!--songs-->
      <div id="songs">
     <div class="clearfix"></div>
  <s:include value="/jsp/home/videoSection.jsp"></s:include> 
      </div>
      <!--photos-->
     <s:include value="/jsp/home/photoSection.jsp"></s:include>   
       <div class="clearfix"></div>
      <!--  Add Comment -->
 
      <div class="clearfix"></div>
    <%--   <div id="add_comment_h">
      <div class="add_comm_h">
      <div class="add_cmt_hd">Add A COMMENT</div>
      <div class="ad_txt">
      <textarea></textarea>
      </div>
      <div class="ad_btn">
      <div class="post_comn">POST COMMENT</div>
      
      <div class="login_fb">
      <div class="login_w">Login with</div>
       <div class="login_img"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_sm.jpg" alt="Facebook" /></div>
      </div>
      
      <div class="login_gl">
      <div class="login_w">Login with</div>
      <div class="login_img"><img src="http://media2.intoday.in/indiatoday/megacritic/images/gplus.jpg" alt="Google Plus" /></div>
      </div>
      
      <div class="login_tw">
      <div class="login_w">Login with</div>
      <div class="login_img"><img src="http://media2.intoday.in/indiatoday/megacritic/images/tw_sm.jpg" alt="Twitter" /></div>
      </div>
      
      </div>
      
      <div class="clearfix"></div>
      
      <div class="btm_rev_panel">
      <div class="list_pnl">
      <div class="left_pn"><img src="http://media2.intoday.in/indiatoday/megacritic/images/user_rv.jpg" alt="img" /></div>
      <div class="right_pn">
      <h3>Thalaivarâs 3 hours on-screen darshan, what else needed. </h3>
       <em>January20, 2015</em>
       <p>If you are a critic or a movie lover of logic & sensible films, then please don;t jump for lingaaa. itâs only for SUPERSTAR fans...</p>
       
       <div class="clearfix"></div>
       <div class="thumbs_h">
       <span class="likearea"> <a class="like" href="#"></a> <a class="dislike" href="#"></a> </span>
       <div class="thmb_up"></div>
       
       <div class="thmb_down"></div>
       </div>
       
      </div>
      <div class="clearfix"></div>
      </div>
      </div>
      
      </div>
       <div class="clearfix"></div>
      </div>
 --%>    </div>
    <!--right section-->
      <div id="right_section">
      <script src="http://ittemp.intoday.in/megacritic/js/jquery.mCustomScrollbar.concat.min.js"></script>
      <s:include value="/jsp/home/rightNavigation.jsp"></s:include>   
    </div> 
  </div>
</div>
<!--footer-->
<div class="clearfix"></div>
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>

</body>
</html>

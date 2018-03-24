<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@taglib uri="/struts-tags" prefix="s" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>News Story</title>
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
       
    <div class="txt_news_story">
  <div class="story_cont_news">
    <p> <s:property  value="%{storyData.title}"/> </p>
    <p class="img_sec"><div class="news_cont"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property  value="%{storyData.extraLargeImage}"/>" alt="img" width="100%" height="" /></div> </p>
    <p> <s:property  value="%{storyData.shortDescription}"/> </p>
      </div>
   <div id="add_comment_h">
   
   
    <div class="add_comm_h">
    
 <script type="text/javascript">
ajaxinclude("<%=MegacriticCommonConstants.SITE_URL%>commentbox/comment_box.jsp?sId=<s:property value='%{storyData.id}'/>&website=megacritic&content_type=story&ScfUrl=<s:property value='%{storyData.title}'/>&StoryTitle=<s:property value='%{storyData.title}'/>&message=<%="test message"%>&sectionInfo=&storytemplate=special");
</script>  
     <!--  <div class="add_cmt_hd">Add A COMMENT</div>
      <div class="ad_txt">
        <textarea></textarea>
      </div>
      <div class="ad_btn">
        <div class="post_comn">POST COMMENT</div>
        <div class="login_fb">
          <div class="login_w">Login with</div>
          <div class="login_img"><img alt="Facebook" src="http://media2.intoday.in/indiatoday/megacritic/images/fb_sm.jpg"></div>
        </div>
        <div class="login_gl">
          <div class="login_w">Login with</div>
          <div class="login_img"><img alt="Google Plus" src="http://media2.intoday.in/indiatoday/megacritic/images/gplus.jpg"></div>
        </div>
        <div class="login_tw">
          <div class="login_w">Login with</div>
          <div class="login_img"><img alt="Twitter" src="http://media2.intoday.in/indiatoday/megacritic/images/tw_sm.jpg"></div>
        </div>
      </div>
      <div class="clearfix"></div>
      <div class="list_all_txt">
        <div class="ul_list">
         
          <div class="clearfix"></div>
        </div>
      </div> -->
    </div>
    <div class="clearfix"></div>
    <div class="bottom_comment"> <%-- <span class="more_txt">See More</span>  --%></div>
  </div>
</div>
    
 
    </div>
    <!--</div>-->
      <div id="right_section"> 
    <!--right section-->
    <script src="http://ittemp.intoday.in/megacritic/js/jquery.mCustomScrollbar.concat.min.js"></script>
     <s:include value="/jsp/home/rightNavigation.jsp"></s:include>     
  </div>

</div>
<!--footer-->
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>

</body>
</html>

<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<!DOCTYPE html>
<html>
<head>
<%@taglib uri="/struts-tags" prefix="s" %>
<meta charset="UTF-8">
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
      <!--bollywood rating-->
      <s:include value="bollywoodRatingSection.jsp"></s:include>
      <div class="clearfix"></div>
      
     
     <!--     TRAILERS & VIDEOS -->
      <s:include value="videoSection.jsp"></s:include>
 
     <!--   songs -->
      <s:include value="songSection.jsp"></s:include>
      
      <!--photos-->
	  <s:include value="photoSection.jsp"></s:include>         
      
       <!--Social Section-->
      <div class="social_like_b">
    
     <!-- Fb Like -->
      <s:include value="like.jsp"></s:include>      
        <!--<div class="fb_like_b">
        
       
        
        <div class="fb_like_hd">
        <div class="fb_like_hd_left">
        <img src="http://media2.intoday.in/indiatoday/megacritic/images/like_fb.png" alt="img" />
        </div>
        <div class="fb_like_hd_right">
        <p>1,21,560 likes MegaCritic</p>
        <p class="fb_h">Follow us at <span>FACEBOOK</span></p>
        </div>
        
        
        </div>
        
        <div class="fb_like_btn">
        <div class="fb_like_btn_left"><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_like.png" alt="fb" /></a></div>
        <div class="fb_like_btn_right">
        <ul>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        </ul>
        </div>
        </div>
        </div>-->
             <!-- tw Like -->
         
         <!--<div class="tw_follow_box">
         
         <div class="follow_btn_tw"><span>Follow on twitter</span> @megacritic</div>
         <div class="tw_des_cont"><span>1,12,560</span> Followers</div>
         <div class="list_ul_tw">
         <ul>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        </ul>
         </div>
         </div>-->
         
         
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

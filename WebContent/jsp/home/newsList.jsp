<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<!DOCTYPE html>
<html>
<head>
<%@taglib uri="/struts-tags" prefix="s" %>
<meta charset="UTF-8">
<title>Meta Critic</title>
<%@ include file="/jsp/common/css-js.jsp" %>
<script>
$(document).ready(function(){
 var mglen  = $('ul.sld_blt li').length;
	var mgwidth = $('ul.sld_blt li').width();
	var fwidth1 = (mgwidth)*mglen;
	$('ul.sld_blt').css('width', fwidth1);
	var counters2 = 1;
	$('.next_top_sld').click(function(){
		if(counters2 <= mglen-1)
		{
				$('ul.sld_blt').animate({
					
					left: '-='+mgwidth
					
					
				});
				 counters2 += 1;
				 
				
		}
		else{
			
		}
	});
	$('.prev_top_sld').click(function(){
		if(counters2 == 1)
		{
				
		}
		else{
			$('ul.sld_blt').animate({
					left: '+='+mgwidth
				});
			counters2 -= 1;
			
		}
	});
	
})
</script>

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
    <div class="heading_m_txt">Latest Cinema News</div>
    <div class="news_top_slider_container">
  <div class="news_top_slider_cont"> 
    <div class="slider_c_belt">
<span class="prev_top_sld"></span>
<span class="next_top_sld"></span>
  <ul class="sld_blt">
     <s:iterator id="news" value="%{newsDataList}" status="stat">
    <li>
      <div class="sld_cont_m"> <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#news.contentUrl}"/>"> 
      <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#news.largeKickerImage}"/>" alt="img"></a>
        <div class="bottom_btm">
          <div class="hdn"><s:property  value="%{#news.title}"/></div>
          <%-- <div class="desc"> <s:property  value="%{#news.title}"/> </div> --%>
        </div>
      </div>
      <div class="clearfix"></div>
    </li>
    </s:iterator>
     
  </ul>
</div>
    
  </div>
</div>

<div class="clearfix"></div>
    <div class="heading_m_txt">More News</div>
<div class="more_news_listing_cont">
  <div class="more_news_main_cont">
    <ul>
    
     <s:iterator id="news" value="%{newsDataList}" status="stat">
      <li>
        <div class="cont_b">
          <div class="left_side"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#news.largeKickerImage}"/>" alt="img" /> </div>
          <div class="right_side">
            <div class="top_txt"><s:property  value="%{#news.title}"/><a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#news.contentUrl}"/>"> Read more</a> </div>
            <div class="share_comnt">
              <div class="comment_sec"> <img src="http://media2.intoday.in/indiatoday/megacritic/images/comment_2.jpg" alt="imgt"> <span><s:property  value="%{#news.storyCommentCount}"/> Comments</span> </div>
              <div class="socials_plg">
                <ul>
                 <li> <a target="_blank" href="<s:property   value="%{#news.facebookShare}"/>" class="fb"></a></li>
                 <li><a target="_blank" href="<s:property  value="%{#news.twitterShare}"/>" class="tw"></a> </li>
                 <li><a target="_blank" href="<s:property  value="%{#news.googleShare}"/>" class="gp"></a></li>
                 <li><a href="#" class="rss"></a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </li>
      </s:iterator>
     
     
     
     
    </ul>
  </div>
<!--   <div class="pagination_h1">
    <div class="pagination_cont">
      <div class="prev_cont">Previous</div>
      <div class="belt_cont">
        <ul>
          <li><a href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li class="active"><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          <li><a href="#">5</a></li>
        </ul>
      </div>
      <div class="next_cont">Next</div>
    </div>
  </div> -->
</div>

      
    </div>
    <!--right section-->
    <div id="right_section"> 
      <s:include value="/jsp/home/rightNavigation.jsp"></s:include>
        
    </div>
  </div>
</div>
<!--footer-->
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>
</body>
</html>

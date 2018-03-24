
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>UpComming Movies</title>
<%@ include file="/jsp/common/css-js.jsp" %>
<script>
$(document).ready(function() {
	var btm_len1 = $('.sld_cont_up ul li').length;
		var btm_width1 = $('.sld_cont_up ul li').width();

		btm_width1 = btm_width1 * btm_len1+10;
		
		$('.sld_cont_up ul').css('width', btm_width1+10 );
		
		var btm_counter1 = 1;
		$('.right_arr_up').click(function(){
		
			if (btm_counter1 < btm_len1)
				{
				$('.sld_cont_up ul').animate({
					left :-98,
				})
			btm_counter1 += 1;
		}else
		{
			
		}
		});		
		$('.left_arr_up').click(function(){
		
			if (btm_counter1 >= 3)
				{
				$('.sld_cont_up ul').animate({
					left :0,
				})
			btm_counter1 -= 1;
		}else
		{
			
		}
		});
		
		});
</script>
</head>
<body>
<!--header-->
<%@ include file="/jsp/common/header.jsp" %>
<!--body section-->
<div class="wrapper">
  <div id="body_section">
    <!--left section-->
    <div id="left_section">
     <s:iterator id="upCommingMovies" value="%{upcomingMoviesList}" status="stat">
    <div class="upcoming_movies">
        <div class="left_m"> <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#upCommingMovies.mediumKickerImage}"/>" alt="upc" /> </div>
        <div class="right_m">
          <div class="hd">
            <h3> <a href="<s:property value="%{#upCommingMovies.contentUrl}"/>"><s:property value="%{#upCommingMovies.title}"/> </a></h3>
             <s:if test="%{#upCommingMovies.commentQuestion.length()>0}">
            <p>In theaters:<s:property value="%{#upCommingMovies.commentQuestion}"/></p>
            </s:if>
            
           
          </div>
          <div class="lk_btns">
            <div class="like_h">
             <!--  <div class="lk_icon"><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/lke.png" alt="Like" /></a></div> -->
            <!--   <div class="lk_des">0 Want to watch</div> -->
             <script type="text/javascript">
	                ajaxinclude("<%=MegacriticCommonConstants.SITE_URL%>jsp/likes/like-dislike.jsp?titleData=no&contentId=<s:property value='%{#upCommingMovies.id}'/>&contentType=text&ScfUrl='<s:property value='%{#upCommingMovies.sefTitle}'/>");
                  </script>  
            </div>
            <s:if test="%{#upCommingMovies.blurb.length()>0}">
            <div class="video_h">
              <div class="vd_icon"><a href="<s:property value="%{#upCommingMovies.blurb}"/>"><img src="http://media2.intoday.in/indiatoday/megacritic/images/video.png" alt="Like" /></a></div>
              <div class="vd_des">Watch Trailer</div>
            </div>
            </s:if>
          </div>
          <s:if test="%{#upCommingMovies.startCasts.size()>0}">
          <div class="scrls">
            <div class="scrls_hd">Star <span>Cast</span></div>
            <div class="scrls_cont">
              <div class="left_arr_up">
                <div class="left_icon"></div>
              </div>
              <div class="sld_cont_up <s:property value="%{#stat.count}"/>">
              
                <ul>
                  <s:iterator id="starCast" value="%{#upCommingMovies.startCasts}" status="star">
                  <li>
                    <div class="box_cont">
                      <div class="box_img"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#starCast.thumbImage}"/>" alt="img"  height="88px"/></div>
                      <div class="box_cont"><s:property value="%{#starCast.title}"/></div>
                    </div>
                  </li>
                 </s:iterator>
                </ul>
               
               </div>
              <div class="right_arr_up">
                <div class="right_icon"></div>
              </div>
            </div>
          </div>
          </s:if>
          <div class="scl_btns">
            <div class="likes_m">
              <div class="fb_likes">
                <div class="text_lk">Follow With</div>
                <div class="img_lk"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_sm.jpg" alt="fb"></div>
                <div class="clearfix"></div>
              </div>
              <div class="tw_likes">
                <div class="text_lk">Follow With</div>
                <div class="img_lk"><img src="http://media2.intoday.in/indiatoday/megacritic/images/tw_sm.jpg" alt="tw"></div>
                <div class="clearfix"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
       <div class="clearfix"></div>
      </s:iterator>
    </div>
      <div id="right_section"> 
      <s:include value="/jsp/home/rightNavigationSection.jsp"></s:include>  
  </div>
</div>
</div>
<!--footer-->
<div class="clearfix"></div>
<s:include value="/jsp/common/footer.jsp"></s:include>

</body>
</html>

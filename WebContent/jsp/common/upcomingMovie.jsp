
 <%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
  <div id="most_watched3" class="most_watched">
        <div class="comheading">
    
          <h2><a href="upcommingmovies"><strong>UPCOMING</strong> MOVIES</a></h2>
          <em class="mwtv"></em> </div>
        <div class="most_main">
          <ul>
             <s:iterator id="upcomingMovies" value="%{upcomingMoviesList}" status="stat">
             <li>
               <div class="img_panel">
               <s:if test="%{#upcomingMovies.smallImage.length()>0}">
                <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#upcomingMovies.smallImage}"/>" alt="No image" />
               </s:if>
               <s:else>
                <img src="" alt="No image" />
               </s:else>
                <!--  <a href="#" class="like_icon_on_img"></a> -->
                 <script type="text/javascript">
	                ajaxinclude("<%=MegacriticCommonConstants.SITE_URL%>jsp/likes/like-dislike.jsp?titleUrl=<s:property  value='%{#upcomingMovies.contentUrl}'/>&titleData=<s:property value='%{#upcomingMovies.title}'/>&contentId=<s:property value='%{#upcomingMovies.id}'/>&contentType=text&ScfUrl='<s:property value='%{#upcomingMovies.sefTitle}'/>");
                  </script>  
            </li>
            </a>
            </s:iterator>
          </ul>
        </div>
      </div>
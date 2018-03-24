

<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
  <div id="most_watched1" class="most_watched">
        <div class="comheading">
          <h2><a href="#"><strong>NEWS</strong> </a></h2>
          <em class="mwtv"></em> </div>
        <div class="most_main">
          <ul>
             <s:iterator id="news" value="%{newsList}" status="stat">
            <li>
              <div class="img_panel"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#news.smallImage}"/>" alt="" />
              
              </div>
              <div class="content_panel">
              <h3>   <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#news.contentUrl}"/>" ><s:property  value="%{#news.title}"/></a> </h3>
               </div>
            </li>
            </s:iterator>
          </ul>
        </div>
      </div>
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<div class="songs clearfix">
        <div class="com_head">
          <h2>TRAILERS  <em style=" font-style:normal;">AND VIDEOS</em></h2>
        </div>
        <div class="common_section_main">
          <div class="belt">
            <div class="inner-belt">
             <s:iterator id="video" value="%{videos}" status="stat">
              <div class="section"><a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#video.contentUrl}"/>"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#video.largeKickerImage}"/>" alt="" /></a> <a class="vplay" href="#"></a> 
              <strong>
              <s:property  value="%{#video.videoTitle}"/>
              </strong> 
               <span class="social_area">
              <a href="<s:property  value="%{#video.facebookShare}"/>" class="facebook" target="_blank"></a>
              <a href="<s:property  value="%{#video.twitterShare}"/>" class="twitter" target="_blank"></a>
              <a href="<s:property  value="%{#video.googleShare}"/>" class="gplus" target="_blank"></a>
              <a href="#" class="rss"></a>
              </span>
              </div>
                
					</s:iterator>	
            
            </div>
          </div>
          <div class="thumb">
            <ul>
              <li id="_1"></li>
              <li id="_2"></li>
              <li id="_3"></li>
            </ul>
          </div>
        </div>
      </div>
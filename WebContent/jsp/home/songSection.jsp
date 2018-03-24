<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<div class="songs clearfix">
        <div class="com_head">
          <h2><strong>S</strong>ONGS<span></span><small></small></h2>
        </div>
        <div class="common_section_main">
          <div class="belt">
            <div class="inner-beltsg">
            
            <s:iterator id="song" value="%{songs}" status="stat">
              <div class="section"><a href="<%=MegacriticCommonConstants.SITE_URL %><s:property  value="%{#song.contentUrl}"/>"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#song.largeKickerImage}"/>" alt="" /></a> <a class="vplay" href="#"></a> <strong>  <s:property  value="%{#song.videoTitle}"/></strong> 
              <span class="social_area">
             <a href="<s:property  value="%{#song.facebookShare}"/>" class="facebook" target="_blank"></a>
              <a href="<s:property  value="%{#song.twitterShare}"/>" class="twitter" target="_blank"></a>
              <a href="<s:property  value="%{#song.googleShare}"/>" class="gplus" target="_blank"></a>
              <a href="#" class="rss"></a>
              </span>
              </div>
             	</s:iterator>	
              
              
             

            </div>
          </div>
          <div class="thumbsg">
            <ul>
              <li class="_1"></li>
              <li class="_2"></li>
              <li class="_3"></li>
             <!-- <li class="_4"></li>
              <li class="_5"></li>-->
            </ul>
          </div>
        </div>
      </div>
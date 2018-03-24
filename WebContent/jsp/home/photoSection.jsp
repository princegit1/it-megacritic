 <%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
 <div class="com_head">
          <h2><strong>P</strong>HOTOS<span></span><small></small></h2>
        </div> 
     <div id="photos">
        <div class="main">
          <div class="home_slider">
            <div class="belt-outer">
             <s:iterator id="photo" value="%{photos}" status="stat">
              <div class="box<s:property value="%{#stat.index}"/> catlist">
                <div class="home_box"> <img src="<%=MegacriticCommonConstants.GALLERY_IMG_PATH %><s:property value="%{#photo.extralargeImage}"/>" alt=""><a href="<%=MegacriticCommonConstants.SITE_URL %>
                <s:property value="%{#photo.contentUrl}"/>" class="camera"></a> </div>
              </div>
               </s:iterator> 
            </div>
          </div>
          <div class="bottom-slider">
            <div class="bottom-base clearfix">
              <div style="display: block;" class="btm_left"></div>
              <div  class="btm_right"></div>
              <div class="btm_belt">
                <ul style="left: 0px;">
                 <s:iterator id="photo" value="%{photos}" status="stat">
                  <li class="current_<s:property value="%{#stat.index}"/>"><span></span>
                    <div class="list-cont"><img src="<%=MegacriticCommonConstants.GALLERY_IMG_PATH %><s:property value="%{#photo.smallImage}"/>" alt="" />
                    <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property value="%{#photo.contentUrl}"/>" class="camera"></a> </div>
                    <strong> <a href="<%=MegacriticCommonConstants.SITE_URL %><s:property value="%{#photo.contentUrl}"/>"><s:property value="%{#photo.galleryName}"/></a> </strong> </li>
                    </s:iterator>
                </ul>
              </div>
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
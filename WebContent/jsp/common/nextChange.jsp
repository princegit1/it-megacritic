 <%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
  <div id="most_watched2" class="most_watched">
        <div class="comheading">
          <h2><a href="<%=MegacriticCommonConstants.SITE_URL%>nextchanges"><strong>NEXT</strong> CHANGE</a></h2>
          <em class="mwtv"></em> </div>
          <div class="most_main">
          <ul>
             <s:iterator id="nextChanges" value="%{nextChangesList}" status="stat">
            <li>
              <div class="img_panel"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><s:property value="%{#nextChanges.smallImage}"/>" alt="" />
                   <script type="text/javascript">
	                ajaxinclude("<%=MegacriticCommonConstants.SITE_URL%>jsp/likes/like-dislike.jsp?titleUrl=<s:property  value='%{#nextChanges.contentUrl}'/>&titleData=<s:property value='%{#nextChanges.title}'/>&contentId=<s:property value='%{#nextChanges.id}'/>&contentType=text&ScfUrl='<s:property value='%{#nextChanges.sefTitle}'/>");
                  </script>
            </li>
            </s:iterator>
          </ul>
        </div>
      </div>
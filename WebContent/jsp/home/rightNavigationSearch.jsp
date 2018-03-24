<%@page import="com.indiatoday.megacritic.service.MegacriticHomeServiceImpl"%>
<%@page import="com.indiatoday.megacritic.domain.Story"%>
<%@page import="java.util.List"%>

<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@taglib uri="/struts-tags" prefix="s" %>
      <!--advertisement-->
      <div class="advertisement">
        <h3>.............................Advertisement.............................</h3>
        <div class="addsec"> 
          <!-- Javascript tag: --> 
          <!-- begin ZEDO for channel: IT Homepage Rightnav MR 1 , publisher: India Today , Ad Dimension: Medium Rectangle - 300 x 250 --> 
          
       <script language="JavaScript">
       var zflag_nid="821"; var zflag_cid="1140/1137"; var zflag_sid="2"; var zflag_width="300"; var zflag_height="250"; var zflag_sz="9";
     </script> 
          <script src="http://d2.zedo.com/jsc/d2/fo.js" language="JavaScript"></script> 
        
          <!-- end ZEDO for channel: IT Homepage Rightnav MR 1 , publisher: India Today , Ad Dimension: Medium Rectangle - 300 x 250 --> 
        </div>
      </div>
      <!--buzz-->
      <div class="clearfix"></div>
      <div id="most_watched1" class="most_watched">
        <div class="comheading">
          <h2><a href="#"><strong>NEWS</strong> </a></h2>
          <em class="mwtv"></em> </div>
        <div class="most_main">
          <ul>
          <%
          List<Story> searchNews=new MegacriticHomeServiceImpl().getStoryList("category",615,5,5,"0");
          if(searchNews!=null && searchNews.size()>0){
          for(Story story:searchNews )
          {
          
           %>
               <li>
              <div class="img_panel"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH %><%=story.getKickerImage() %>" alt="" />
              
              </div>
              <div class="content_panel">
              <h3>   <a href="<%=MegacriticCommonConstants.SITE_URL %>" ><%=story.getTitle() %></a> </h3>
               </div>
            </li>
         <%}} %>
          </ul>
        </div>
      </div>

        <div class="clearfix"></div>
   
    
    
      <!--twitter-->
   
        
        
        <div class="twitter" >
        	<div class="twit_head" >
            	<h2 >Follow at<span>#moviereview</span></h2>
                </div>
                <div class="twitter-frame">
              
         <a class="twitter-timeline" height="365" href="https://twitter.com/Showbiz_IT/lists/celebs" data-widget-id="560409903253032961">Tweets from https://twitter.com/Showbiz_IT/lists/celebs</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

          
           </div>
                
                <!--<img src="images/twitter.jpg" width="35" height="29"  />-->
            </div>
         
        
        

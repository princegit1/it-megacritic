<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@page import="com.indiatoday.megacritic.domain.ContentChunkDTO,com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@page import="com.indiatoday.megacritic.domain.ContentChunkHelper"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String galleryIdToAvoid="0";
String categoryIdToDisplay="0";
String latestGalleryIdToAvoid="0"; 
if(request.getParameter("galleryIdToAvoid")!=null && !request.getParameter("galleryIdToAvoid").equals("")){
	galleryIdToAvoid=request.getParameter("galleryIdToAvoid");
}
if(request.getParameter("categoryId")!=null && !request.getParameter("categoryId").equals("")){
	categoryIdToDisplay=request.getParameter("categoryId");
}
if(categoryIdToDisplay.trim().length()==0 || categoryIdToDisplay.trim().equals("0")) {
	categoryIdToDisplay="3";
}
%>
<div class="divclear"></div>
<div id='taboola-below-main-column'></div>
<script type="text/javascript">
    window._taboola = window._taboola || [];
    _taboola.push({mode:'thumbs-2r', container:'taboola-below-main-column', placement:'below-main-column'});
</script>

<!--Taboola's last code -->
<script type="text/javascript">
window._taboola = window._taboola || [];
_taboola.push({flush:true});
</script>
<div class="divclear"></div>
<cache:cache key=""  scope="application " time="0" refresh="t" >
<%
ArrayList galleryListData = null;
int mainGalleryDisplay = 6;
int mainPhotoCategoryToDisplay = Integer.parseInt(categoryIdToDisplay);
galleryListData = (ArrayList) ContentChunkHelper.latestGallery(mainPhotoCategoryToDisplay, mainGalleryDisplay, latestGalleryIdToAvoid);
//System.out.println("Main -->"+galleryListData.size());
//galleryListData = (ArrayList) GalleryHelper.latestGallery(1, 6, galleryIdToAvoid, Integer.parseInt(categoryIdToDisplay));
int Ctr = 2;
if (galleryListData != null && galleryListData.size() > 0) {
	out.print("<div class=\"phvid-listing\"><div class=\"phvidmargin\">");
	for (int vCtr = 0; vCtr < galleryListData.size(); vCtr++) {
		ContentChunkDTO latestGallery = (ContentChunkDTO) galleryListData.get(vCtr);
		if(latestGalleryIdToAvoid.equals("")) {
			latestGalleryIdToAvoid = ""+latestGallery.getId();
		} else {
			latestGalleryIdToAvoid = latestGalleryIdToAvoid + ", "+ latestGallery.getId();
		}
		if(vCtr==0) {
%>
			<div class="headline"><strong><%if(latestGallery.getCategoryTitle().trim().length() > 0) { out.print("<a href=\""+MegacriticCommonConstants.SITE_BASEPATH+latestGallery.getCategoryURL()+"\">More Galleries From " + latestGallery.getCategoryTitle()+"</a>"); }%></strong><span class="photo_more"><a href="#">More &#187;</a></span></div><div class="clear"></div>
<%	}				
			if(vCtr==Ctr){			
				Ctr=Ctr+3;
				out.println("<div class='col endcol'>");
			 } else { 
				out.println("<div class='col colspc'>");
			} %>
		    <%if(vCtr==4){
		    %>
		     <div class="inner">
		    <div class="image_icon">		    
		    <a href="http://indiatoday.intoday.in/applications" target="_blank" rel="nofollow"><img src="http://media2.intoday.in/indiatoday/images/179X134.jpg"  width="185"  /></a>
		    </div>
		    </div>
		    		    
		   <% }else{ %>
		     <div class="inner">
		    <div class="image_icon">		    
		    <a href="<%=MegacriticCommonConstants.SITE_BASEPATH+latestGallery.getContentURL()%>"><img src="http://media2.intoday.in/indiatoday/lazyload-grey.gif" data-original="<%= MegacriticCommonConstants.GALLERY_IMG_PATH+latestGallery.getKickerImage()%>" width="185" height="120" /><img class="mediaimg" alt="<%=latestGallery.getTitle()%>" title="<%=latestGallery.getTitle()%>" src="http://media2.intoday.in/indiatoday/images/homenew/photo_icon.png"></a>
		    </div>
		    <div class="phvidTitle"><a href="<%=MegacriticCommonConstants.SITE_BASEPATH+latestGallery.getContentURL()%>"><%=latestGallery.getTitle()%></a></div>
		    
		    </div>
		    <%} %>
		    
		    </div>
			<%	if(vCtr== galleryListData.size()-1) {	%>
				<div class="morevidphtxt" style="display:none;"><a href="<%=MegacriticCommonConstants.SITE_BASEPATH+latestGallery.getCategoryURL()%>">More <%=latestGallery.getCategoryTitle()%> Galleries</a></div><div class="divclear"></div>
			<%	}
			if ((vCtr % 3 == 2) )  
				out.print("<div class=\"divclear\"></div>");
			if (vCtr == galleryListData.size()-1 && (vCtr % 3 != 2))  
				out.print("<div class=\"divclear\"></div>");

	}
	out.print("</div></div><div class=\"divclear\"></div>");
}%>
<%
galleryListData = null;
//Latest Photos Loop Till and Photo Categories Starts
String[] photoCategoriesToDisplay = {"2", "39", "3", "48"};
	ArrayList photodata1 = null;
	for(int i=0; i<photoCategoriesToDisplay.length; i++) {
		//System.out.println("photoCategoriesToDisplay->"+photoCategoriesToDisplay[i]+" -- categoryIdToDisplay->"+categoryIdToDisplay);
		if(!photoCategoriesToDisplay[i].equals(categoryIdToDisplay)) {
			int galleryDisplay = 6;
			int photoCategoryToDisplay = Integer.parseInt(photoCategoriesToDisplay[i]);
			photodata1 = (ArrayList) ContentChunkHelper.latestGallery(photoCategoryToDisplay, 7, latestGalleryIdToAvoid);
			Ctr = 2;
			if (photodata1 != null && photodata1.size() > 0) {
				if(photodata1.size() < galleryDisplay)
					galleryDisplay = photodata1.size();
					for (int a = 0; a < galleryDisplay; a++) {
						ContentChunkDTO photos1 = (ContentChunkDTO) photodata1.get(a);
						if(a==0) {
						%>
						<div class="phvid-listing"><div class="phvidmargin"><div class="headline"><strong><a href="<%=MegacriticCommonConstants.SITE_BASEPATH+photos1.getCategoryURL()%>"><%=photos1.getCategoryTitle()%></a></strong><span class="photo_more"><a href="#">More &#187;</a></span></div><div class="clear"></div>
					<%	}
				if(a==Ctr){			
					Ctr=Ctr+3;
					out.print("<div class='col endcol'>");
				} else { 
					out.print("<div class='col colspc'>");
				} %>
				<div class="inner"><div class="image_icon"><a href="<%=MegacriticCommonConstants.SITE_BASEPATH+photos1.getContentURL()%>"> <img src="http://media2.intoday.in/indiatoday/lazyload-grey.gif" data-original="<%= MegacriticCommonConstants.GALLERY_IMG_PATH+photos1.getKickerImage()%>" width="185" height="120" /><img class="mediaimg" alt="<%=photos1.getTitle()%>" title="<%=photos1.getTitle()%>" src="http://media2.intoday.in/indiatoday/images/homenew/photo_icon.png"></a></div><div class="phvidTitle"><a href="<%=MegacriticCommonConstants.SITE_BASEPATH+photos1.getContentURL()%>"><%=photos1.getTitle()%></a></div></div></div>
			<%	if(a== galleryDisplay-1) {	%>
				<div class="morevidphtxt" style="display:none;"><a href="<%=MegacriticCommonConstants.SITE_BASEPATH+photos1.getCategoryURL()%>">More <%=photos1.getCategoryTitle()%> Galleries</a></div><div class="divclear"></div></div></div>
			<%	}
						if ((a % 3 == 2)) { 
							out.println("<div class='divclear'></div>");
						}
					}
				}
				photodata1 = null;
		}
	}
//Photo Categories Ends
%>
</cache:cache>
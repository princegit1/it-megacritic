<%@page import="com.indiatoday.megacritic.utils.Dbconnection"%>
<%@page import="com.indiatoday.megacritic.domain.RelatedContentDTO"%>
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@page import="com.indiatoday.megacritic.domain.CommentDTO"%>
<%@page import="com.indiatoday.megacritic.domain.GalleryDTO"%>
<%@page import="com.indiatoday.megacritic.domain.GalleryHelper"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" import="java.sql.*" pageEncoding="ISO-8859-1"%>
<!-- Begin comScore Tag -->
<script >
  var _comscore = _comscore || [];
  _comscore.push({ c1: "2", c2: "8549097" });
  (function() {
    var s = document.createElement("script"), el = document.getElementsByTagName("script")[0];
    s.src = (document.location.protocol == "https:" ? "https://sb" : "http://b") + ".scorecardresearch.com/beacon.js";
    el.parentNode.insertBefore(s, el);
  })();
</script> 
<noscript>
  <img src="http://b.scorecardresearch.com/p?c1=2&c2=8549097&cv=2.0&cj=1" />
</noscript>
<!-- End comScore Tag -->
<%
String baseUrl = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getServletPath()))+"/";
int galleryId = 0;
int currentPhotoNo = 1;
int totalPhotoCount = 0;
if(request.getParameter("galleryId")!=null)
	galleryId = Integer.parseInt(request.getParameter("galleryId"));
if(request.getParameter("totalPhotoCount")!=null)
	totalPhotoCount = Integer.parseInt(request.getParameter("totalPhotoCount"));
if(request.getParameter("currentPhotoNo")!=null)
{
	String checktext=request.getParameter("currentPhotoNo");
	if (checktext.contains("photo")) {
		currentPhotoNo= Integer.parseInt(checktext.substring(5));
	} else {
		currentPhotoNo = Integer.parseInt(request.getParameter("currentPhotoNo"));
	}
}
int sliderStartFrom = currentPhotoNo;
if(currentPhotoNo <= 6) {
	sliderStartFrom = 1;
} else if(currentPhotoNo > 6 && (totalPhotoCount -currentPhotoNo) >= 5) {
	sliderStartFrom = currentPhotoNo;
} else {
	sliderStartFrom = (totalPhotoCount - 6) + 1;
}
ArrayList photoDetails = null;
photoDetails = GalleryHelper.photoDetailsAjax(galleryId, currentPhotoNo);
ArrayList gallerySmallImages = null;
String lastDiv = "";
String galleryPlayStart="";
String galleryPlayEnd="";
String galleryPlayComplete="";
String galleryPlayLeft="";
String galleryPlayRight="";
String galleryBackNext="";
String galleryCaption="";
String galleryRelated="";
String galleryUtility="";
String galleryLikeDislike="";
int photoId = 0;
String photoTitle = "";
String photoCaption = "";
int photoWidth = 0;
int photoHeight = 0;
String photoKeywords = "" ;
String photoSource = "";
String photoAltText = "";
String galleryStrapHeadline="";
String imageStrapHeadline="";
String galleryTitle = "";
String galleryMetaKeywords = "";
String galleryMetaDescription = "" ;
String gallerySefTitle = "";
String galleryComments="";
int categoryId = 0;
String categoryTitle  = "" ;
String categorySefTitle  = "" ;
String imageTitle = "";
String newSlider = "";
String gallerySocial="";
String imgborder="";

if (photoDetails != null && photoDetails.size() > 0) {
	gallerySmallImages = GalleryHelper.photogallerySmallImages(galleryId);
	for (int pCtr = 0; pCtr < photoDetails.size(); pCtr++) {
		GalleryDTO galleryDTO = (GalleryDTO) photoDetails.get(pCtr);
		if (pCtr == 0) {
			photoId = galleryDTO.getPhotoId();
			photoTitle = galleryDTO.getPhotoTitle();
			photoCaption = galleryDTO.getPhotoCaption();
			//photoSource = galleryDTO.getPhotoSource().trim().length() == 0 ? "" : "PHOTO: "+galleryDTO.getPhotoSource();
			photoWidth = galleryDTO.getPhotoWidth(); 
			photoHeight = galleryDTO.getPhotoHeight();
			photoKeywords = galleryDTO.getPhotoMetaKeywords();
			galleryId = galleryDTO.getGalleryId();
			if(galleryId==6301) {
				photoSource = galleryDTO.getPhotoSource().trim().length() == 0 ? "" : "<div class='photo' style='text-transform:none;'><span>Cartoon by "+galleryDTO.getPhotoSource()+"</span></div>";
			} else {
				photoSource = galleryDTO.getPhotoSource().trim().length() == 0 ? "" : "<div class='photo'><span>PHOTO: "+galleryDTO.getPhotoSource()+"</span></div>";
			}

			galleryTitle = galleryDTO.getGalleryTitle();
			galleryStrapHeadline=galleryDTO.getStrapHeadline();
			imageStrapHeadline=galleryDTO.getImageStrapHeadline();
			gallerySefTitle = galleryDTO.getGallerySefTitle();
			galleryMetaKeywords = galleryDTO.getMetaKeywords();
			galleryMetaDescription = galleryDTO.getMetaDescription();
			categoryId = galleryDTO.getCategoryId();
			categoryTitle = galleryDTO.getCategoryTitle();
			categorySefTitle = galleryDTO.getCategorySefTitle();
			currentPhotoNo =galleryDTO.getCurrentPhotoNum();
			photoAltText = galleryDTO.getPhotoAltText();
			imageTitle = galleryDTO.getImageTitle();
		} 
	}
}
	
String LikeDislikeStr = MegacriticCommonConstants.LikeDislike(photoId,"photo");

String[] temp;
String delimiter = "-";
temp = LikeDislikeStr.split(delimiter);
int upcount=Integer.parseInt(temp[0]);
int downcount=Integer.parseInt(temp[1]);
int totalcount=Integer.parseInt(temp[2]);
int backPhotoNo=currentPhotoNo-1;
int nextPhotoNo=currentPhotoNo+1;
if(currentPhotoNo>1 && totalPhotoCount>1) {
	backPhotoNo=currentPhotoNo-1;
}
if(currentPhotoNo<totalPhotoCount && totalPhotoCount>1) {
	nextPhotoNo=currentPhotoNo+1;
}

ArrayList resultComment = (ArrayList) MegacriticCommonConstants.contentCommentAll(galleryId, "photo", 3, 0,photoId);
if(resultComment.size() > 0){
	galleryComments=" <div id='surfercommt'> <div class='readsurfer' ><strong>Read Surfers\' Comments</strong></div>";
}
if (resultComment != null && resultComment.size() > 0) {
	int countComment = 0;
	int counter = 0;
	if(resultComment.size() > 2) {
		counter = 2;
	} else {
		counter = resultComment.size();
	}
	for (int z = 0; z < counter; z++) {
		CommentDTO comments = (CommentDTO) resultComment.get(z);
		galleryComments=galleryComments+"<div class='post_comment' id='read_comment'>";
		galleryComments=galleryComments+"<div class='postedby'>Posted by: <b>"+comments.getFirstName()+"</b>";
		if((comments.getDisplayEmail()) == 1){
			galleryComments=galleryComments+"(<a href='mailto:"+comments.getEmail() +"'>"+comments.getEmail() +"</a>)";
			}else {};
			galleryComments=galleryComments+"</div>";
			galleryComments=galleryComments+"<div class='posted_time_stamp'>"+comments.getCity() +" | "+comments.getCommentDate()+"</div>";
			galleryComments=galleryComments+comments.getComment()+"</div>";
}
}
if(resultComment.size() > 2) {
	galleryComments=galleryComments+"<div class='story_more_comments' style='font:bold 11px verdana'><a href='comment/photo/1/"+galleryId+" '>More Comments &raquo;</a></div>";
}
if(resultComment.size() > 0) {
galleryComments=galleryComments+"<div class='disclaimer'><strong>Disclaimer:</strong> Please note that all your comments, feedback and suggestions are published on our websites unless found libellous, inciteful, defamatory, vulgar, pornographic and abusive. We also like to specify that the comments are views of the surfers alone and do not necessarily reflect those of the India Today Group.</div></div>";
}

if(currentPhotoNo <= totalPhotoCount) { 


ArrayList related = (ArrayList) MegacriticCommonConstants.relatedContent(""+galleryId, "photo");
if(related != null && related.size() > 0)
{
	galleryRelated="<ul class='rel_links' >";
	for(int y=0;y<related.size();y++)
	{
		RelatedContentDTO RSB = (RelatedContentDTO) related.get(y);
		if(RSB.getRelatedType().trim().equals("text"))
		{
			galleryRelated = galleryRelated + "<li>"+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.storyURL(RSB.getRelatedContentSefTitle(), 1, RSB.getRelatedContentId())+"'>"+RSB.getRelatedTitle()+"</a></li>";
		} else if(RSB.getRelatedType().trim().equals("photo")) {
			galleryRelated = galleryRelated + "<li class='p_rel'>"+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(RSB.getRelatedContentSefTitle(), 1, RSB.getRelatedContentId())+"'>"+RSB.getRelatedTitle()+"</a></li>";
		} else if(RSB.getRelatedType().trim().equals("video")) {
			galleryRelated = galleryRelated + "<li class='v_rel'>"+"<a href='"+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.videoURL(RSB.getRelatedContentSefTitle(), 1, RSB.getRelatedContentId())+"'>"+RSB.getRelatedTitle()+"</a></li>";
		}
	}
	galleryRelated=galleryRelated+ "</ul>";

}
 
    galleryPlayLeft=galleryPlayLeft+"<div class='phpadding'><div class='phleftcont'><h1>"+galleryTitle+"</h1>";
    galleryPlayLeft=galleryPlayLeft+"<img  src='http://media2.intoday.in/indiatoday/images/Photo_gallery/"+photoTitle+"'  border=\"0\"  alt=\""+photoAltText+"\" title=\""+photoAltText+"\" />";
    if(currentPhotoNo>1 && totalPhotoCount>1) {
	galleryPlayLeft=galleryPlayLeft+"<a title='#photo"+backPhotoNo+"'  name='"+galleryTitle.replaceAll("\'","")+" - India Today - photo "+backPhotoNo+"'  rel='"+MegacriticCommonConstants.SITE_URL+"gallery_data.jsp?galleryId="+galleryId+"&currentPhotoNo="+backPhotoNo+"&totalPhotoCount="+totalPhotoCount+"' class='phprev switch_button prev'>Previous</a>";
	}

if(currentPhotoNo<totalPhotoCount && totalPhotoCount>1) {
	galleryPlayLeft=galleryPlayLeft+"<a title='#photo"+nextPhotoNo+"' name='"+galleryTitle.replaceAll("\'","")+" - India Today - photo "+nextPhotoNo+"'  rel='"+MegacriticCommonConstants.SITE_URL+"gallery_data.jsp?galleryId="+galleryId+"&currentPhotoNo="+nextPhotoNo+"&totalPhotoCount="+totalPhotoCount+"'  class='phnext switch_button next'>Next</a><div class=\"clear\"></div>";
}
     
	 String thumbwidth = "";
thumbwidth = (totalPhotoCount * 103) +"px";
String thumbleft = "";
if(totalPhotoCount > 6) {
	if(currentPhotoNo>1) {
			thumbleft = ((currentPhotoNo-1) *103)+"px";
	} else {
		thumbleft = "0";
	}
} else {
	thumbleft = "0";
}
	 
          //SLIDER STSRAT FROM HERE
//newSlider = "<div class='new_pagination'><div id='newGallery'><div class='thumbs-wrapper'><div id='slider1'><a class='buttons prev' href=\"javascript:void(0);\">left</a><div class='viewport'><ul class='overview' style='width:"+thumbwidth +";left:-"+thumbleft+"'>";
newSlider = newSlider + "<div class='new_pagination'><div id='newGallery'><div class='thumbs-wrapper'><div id='slider1'>";
if(totalPhotoCount > 6) {
	newSlider = newSlider + "<a class='buttons prev' href=\"javascript:void(0);\">left</a>";
}
            newSlider = newSlider + "<div class='viewport'><ul class='overview' style='width:"+thumbwidth +";left:-"+thumbleft+"'>";
if (gallerySmallImages != null && gallerySmallImages.size() > 0) {
	for (int iCtr = 0; iCtr < gallerySmallImages.size(); iCtr++) {
		GalleryDTO imageDTO = (GalleryDTO) gallerySmallImages.get(iCtr);
		newSlider = newSlider + "<li><div class='numbertab ";
		if((iCtr+1) == currentPhotoNo)
			newSlider = newSlider + " tabactive ";
		if((iCtr+1) == currentPhotoNo){imgborder="class=\"imgborder\"";}else{imgborder="";}

		newSlider = newSlider + "'>"+(iCtr+1)+"</div><a href=\""+(MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(gallerySefTitle,(iCtr+1),galleryId))+"\" alt=\""+imageDTO.getPhotoAltText()+"\" title=\""+imageDTO.getPhotoAltText()+"\" name=\""+galleryTitle.replaceAll("\'","")+" - India Today - photo "+(iCtr+1)+"\" class='switch_small_button movenext'><img  "+imgborder+" width='88' height='66'  src=\""+MegacriticCommonConstants.GALLERY_IMG_PATH+imageDTO.getPhotoTitle()+"\"></a></li>";
	}
}
//newSlider = newSlider + "</ul></div><a class='buttons next' href='javascript:void(0)'>right</a></div></div></div></div>";
newSlider = newSlider + "</ul></div>";
if(totalPhotoCount > 6) {
	newSlider = newSlider + "<a class='buttons next' href='javascript:void(0);'>right</a>";
}
newSlider = newSlider + "</div></div></div></div> <div class=\"clear\"></div> ";
galleryPlayRight = newSlider;
galleryPlayRight =galleryPlayRight+ "<div class='photosynd'><a href='http://syndicationstoday.com/' target='_blank'><img src='http://indiatoday.intoday.in/images/syn.gif' border='0'/></a>"; 
galleryPlayRight =galleryPlayRight+ "<iframe width='468' scrolling='no' height='60' frameborder='0' src='http://indiatoday.intoday.in/ads-468x60.html'></iframe></div>";
galleryPlayRight =galleryPlayRight+ "<div class='clear'></div> </div><div class='phrightcont'>";
gallerySocial="<div class='right'><div class='fl'><a href='http://www.facebook.com/sharer.php?u=http%3A%2F%2Findiatoday.intoday.in/"+MegacriticCommonConstants.galleryURL(gallerySefTitle, 1, galleryId)+"'><img border='0' src='http://media2.intoday.in/indiatoday/images/f.jpg'></a></div><div class='fl'><a href='http://twitter.com/?status="+galleryTitle+"%20http%3A%2F%2Findiatoday.intoday.in/"+MegacriticCommonConstants.galleryURL(gallerySefTitle, 1, galleryId)+" @indiatoday'><img border='0' src='http://media2.intoday.in/indiatoday/images/t.jpg'></a></div> <div class='fl'><a href='#'><img border='0' src='http://media2.intoday.in/indiatoday/images/b.jpg'></a></div><div class='fl'><a href='#'><img border='0' src='http://media2.intoday.in/indiatoday/images/g.jpg'></a> </div></div>  <div class='clear'></div>";
            

galleryCaption="<div class='photocap'>"+imageTitle+photoCaption+"</div>";
if(photoSource.trim().length() > 0)
galleryCaption =  galleryCaption+"<div class='photo'>"+photoSource+"</div>";   



String tempStrDisp = "Do you like this photo?";
if(galleryId==8629) {	tempStrDisp = "What do you think?";	}
if(galleryId==8661) {	tempStrDisp = "Do you agree?";	}
galleryLikeDislike=galleryRelated+"<div class='clr'></div><div class='phlikedisdiv'><a  onClick=\"javascript:changeRating('"+photoId+"','photo','1')\"><span class='likeimg'></span></a><span class='likecount' id=\"upcount\">"+upcount+"</span> <a  onClick=\"javascript:changeRating('"+photoId+"','photo','2')\"><span class='dislikeimg'></span></a><span class='dislcount' id=\"downcount\">"+downcount+"</span><br>"+tempStrDisp+" </div><div class='clear'></div>";      
galleryLikeDislike=galleryLikeDislike+"<iframe src='"+MegacriticCommonConstants.SITE_BASEPATH+"commentbox/comment_photo_box.jsp?slideid="+photoId+"&contenttype=photo&source=website&sourceurl="+MegacriticCommonConstants.SITE_URL+"&contentid="+galleryId+"&contenttitle="+java.net.URLEncoder.encode(galleryTitle) +"' height='485' width='319' frameborder='0' allowtransparency='true' scrolling='no'></iframe><div class='clear'></div>";        
galleryLikeDislike=galleryLikeDislike+"<div class='phtopmarg'><iframe width='300' scrolling='no' height='250' frameborder='0' allowtransparency='true' marginwidth='0' marginheight='0' src='http://indiatoday.intoday.in/photoad.html'></iframe></div></div></div>";      
galleryPlayComplete=galleryPlayLeft+galleryPlayRight+gallerySocial+galleryCaption+galleryLikeDislike;



	//You Tube DIV from
		if(currentPhotoNo==totalPhotoCount) {
		//ArrayList galleryListData = (ArrayList) MegacriticCommonConstants.mustSee(0, 6, ""+galleryId);
		ArrayList galleryListData =null;
		if (galleryListData != null && galleryListData.size() > 0) {
			lastDiv="<div id='photooverlay' style='max-width: 910px; display:none; position: absolute; height: 470px; margin: 6px 0pt 0pt 0px; color: rgb(255, 255, 255); top: 65px;z-index: 99;'><div class='innerOverlay'><span class='otherTitle'>Latest Photo Galleries</span><span class='close'><a onclick='divshow();return false;' href='javascript:divshow();return false;'><img border='0' alt='close' src='http://indiatoday.intoday.in/images/close-btn.png'></a></span> <table style='height:330px; width:auto; margin:0 auto;' cellpadding='10' cellspacing='10'><tbody>";
			for (int a = 0; a < galleryListData.size(); a++) {
				//LatestContentDTO mustread = (LatestContentDTO) galleryListData.get(a);
				if (a % 3 ==0) {
					lastDiv= lastDiv + "<tr>";
				}
				//lastDiv = lastDiv + "<td><div class='otherGalleryThumb'><a href=\""+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(mustread.getSefTitle(),1,mustread.getId())+"\" style='display:block; position:relative;'><img width='185' src=\""+MegacriticCommonConstants.GALLERY_IMG_PATH+mustread.getSmallImage()+"\"  alt=\""+mustread.getTitle()+"\" title=\""+mustread.getTitle()+"\" /></a><a href=\""+MegacriticCommonConstants.SITE_BASEPATH+MegacriticCommonConstants.galleryURL(mustread.getSefTitle(),1,mustread.getId())+"\" class='galleryTitle'>"+mustread.getTitle()+"</a></div></td>";
				if (a % 3 == 2) 
					lastDiv = lastDiv + "</tr>";
			}

			if(galleryListData.size() % 3 > 0) {
				for (int a1 = (galleryListData.size() % 3); a1 < 3; a1++) {
					lastDiv = lastDiv + "<td></td>";
				}
				lastDiv = lastDiv + "</tr>";
			}
			lastDiv = lastDiv + "</tbody></table></div></div>";
		}
		galleryPlayComplete=galleryPlayComplete+lastDiv;
	}
	//You Tube DIV till

	//New Gallery Template Till
	if(galleryPlayComplete != null) {
		response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		//System.out.println(galleryPlayComplete);
		response.getWriter().write(galleryPlayComplete);
	} else {
		//nothing to show
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	}
}


if(currentPhotoNo==totalPhotoCount) {

String nextGalleryListData = null;
nextGalleryListData = (String) getNextPreviousGallery(galleryId);
if (nextGalleryListData != null) {	

%>
<script type="text/javascript">

function Redirect()
{
    window.location="<%=MegacriticCommonConstants.SITE_BASEPATH+nextGalleryListData%>";
}

setTimeout('Redirect()', 10000);

</script>
<%
}}
%> 

<%!
public static String getNextPreviousGallery(int contentId) throws Exception
            {
                        Connection pnconn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs=null;
                        int contentIdOrdering = 0;
                        String categoryId = "";
                        String contentURL = "";
                        try {
                                  	Dbconnection connect = null;
	            					connect = Dbconnection.getInstance();
	            					pnconn = connect.getConnection();
                                    String sql = "SELECT primary_category FROM jos_gallerynames where id="+contentId;
                                    System.out.println("Primary Category Query -> " + sql);
                                    pstmt = pnconn.prepareStatement(sql);
                                    rs = pstmt.executeQuery(sql);                                        
                                    while (rs.next()) {
                                                categoryId = rs.getString("primary_category");
                                    }
                                    sql = "";
                                    rs=null;
                                    pstmt=null;
                                    if(categoryId.trim().length() > 0) {
                                                if(categoryId.trim().indexOf("#") > 0) {
                                                            categoryId = categoryId.substring(categoryId.indexOf("#")+1);
                                                }
                                    }
                                    sql = "SELECT ordering FROM jos_gallery_section where cat_id="+categoryId+" and content_id="+contentId;
                                    System.out.println("Ordering Query -> " + sql);
                                    pstmt = pnconn.prepareStatement(sql);
                                    rs = pstmt.executeQuery(sql);                                        
                                    while (rs.next()) {
                                                contentIdOrdering = rs.getInt("ordering");
                                    }
                                    sql = "";
                                    rs=null;
                                    pstmt=null;
                                    if(contentIdOrdering>0 && !categoryId.equals("")) {
                                                sql="SELECT gn.content_url FROM jos_gallerynames gn, jos_photocategories pc, jos_gallery_section gs " +
                                                                        "where gs.cat_id="+categoryId+" and pc.id=gs.cat_id and gn.id=gs.content_id and gn.published=1 and " +
                                                                                                "pc.published=1 and gs.ordering < "+contentIdOrdering+" group by gn.id order by gs.ordering desc limit 1";
                                                System.out.println("Content URL Query -> " + sql);
                                                pstmt = pnconn.prepareStatement(sql);
                                                rs = pstmt.executeQuery();                                             
                                                if(rs.next()) {
                                                            contentURL = rs.getString("content_url") == null ? "" : rs.getString("content_url"); 
                                                }
                                    }
                        } catch (Exception e) {
                                    System.out.println("Previous Next Content SQLException (GalleryHelper.java-getNextPreviousGallery) -> " + e);
                        } finally {
                                    if(rs!=null)
                                                rs.close();
                                    if(pstmt!=null)
                                                pstmt.close();
                                    if(pnconn!=null)
                                                pnconn.close();
                        }
                        return contentURL;
            }



%>
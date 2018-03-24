<%
    String storyTitle = "";
	String storySefUrl = "";
	String pageIdentity = "";
	
	String comment_site="indiatoday";
	String comment_source="";
	String comment_type="general";
	String article_id="0";
	
if (request.getParameter("StoryTitle") != null
			&& !request.getParameter("StoryTitle").equals("")) {
		storyTitle =request.getParameter("StoryTitle").replaceAll("'", "%27");
	}
	if (request.getParameter("ScfUrl") != null
			&& !request.getParameter("ScfUrl").equals("")) {
		storySefUrl = request.getParameter("ScfUrl");
	}
	if (request.getParameter("page") != null
			&& !request.getParameter("page").equals("")) {
		pageIdentity =request.getParameter("page");
	}
	
	if (request.getParameter("sId") != null
			&& !request.getParameter("sId").equals("")) {
		article_id =request.getParameter("sId");
	}
	
	if (request.getParameter("website") != null
			&& !request.getParameter("website").equals("")) {
		comment_site = request.getParameter("website");
	}
	
	
%>

<div id="vuukle_div"></div>
<script src="http://vuukle.com/js/vuukle.js" type="text/javascript"></script><script type="text/javascript">
var UNIQUE_ARTICLE_ID = "<%=article_id%>"; //article id or post id
var SECTION_TAGS =  "<%=storySefUrl%>";
var ARTICLE_TITLE ="<%=storyTitle%>";
var GA_CODE = "UA-795349-17";
var VUUKLE_API_KEY = "dc34b5cc-453d-468a-96ae-075a66cd9eb7"; // This is your Vuukle API KEY
var TRANSLITERATE_LANGUAGE_CODE = "en"; //"en" for English, "hi" for hindi
var VUUKLE_COL_CODE = "d00b26";
var ARTICLE_AUTHORS = btoa("author1@newspaper.com,author2@newspaper.com"); // if author email is not available, please pass the author names
create_vuukle_platform(VUUKLE_API_KEY, UNIQUE_ARTICLE_ID, "0", SECTION_TAGS, ARTICLE_TITLE, TRANSLITERATE_LANGUAGE_CODE , "1", "", GA_CODE, VUUKLE_COL_CODE, ARTICLE_AUTHORS);
</script>

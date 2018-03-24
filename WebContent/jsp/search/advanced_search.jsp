<%@page import="com.indiatoday.megacritic.domain.SearchBean"%>
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<%@ page import="org.apache.lucene.document.Document, org.apache.lucene.document.Field,org.apache.lucene.analysis.Analyzer, org.apache.lucene.analysis.standard.StandardAnalyzer,org.apache.lucene.search.IndexSearcher,
 org.apache.lucene.search.Query, org.apache.lucene.search.Hits, org.apache.lucene.search.*,org.apache.lucene.queryParser.QueryParser,org.apache.lucene.store.Directory,
  org.apache.lucene.store.FSDirectory,org.apache.lucene.index.IndexWriter, org.apache.lucene.index.Term, org.apache.lucene.index.IndexReader,java.util.Date, java.util.*,java.text.*"%>
  <%!
String PHOTO_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/photo/";
String PHOTOSECTION_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/photosection/"; 
String STORY_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/story/";
String STORYSECTION_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/storysection/";
String VIDEO_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/video/";
String VIDEOSECTION_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/videosection/";
String SPECIAL_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/special/";
String PROFILE_INDEXPATH = "/home/jboss-4.2.2.GA/server/default/deploy/lucenesearch.war/indiatoday/profile/";
%><%	
String searchStatementSpecial = ""; 
String[][] contentSpecialDisplayArray = null; //(id, title, sef title, content type, templatepath) 
String searchTextConditionSpecial=""; 
String searchStatementProfile = "";
String[][] contentProfileDisplayArray = null; //(id, title, sef title, content type, templatepath) 
String searchTextConditionProfile="";
String advancedSearchParameters = request.getQueryString();
String advancedSearchCompleteURL = MegacriticCommonConstants.SITE_URL+"jsp/search/advanced_search.jsp?"+advancedSearchParameters;
//out.println("advancedSearchCompleteURL->"+advancedSearchCompleteURL+"<br />");
String contentBaseURL = MegacriticCommonConstants.SITE_URL; 

int fulltextSearch = 0;
if(request.getParameter("advsearch")!=null && !request.getParameter("advsearch").equals("")){
	fulltextSearch=Integer.parseInt(request.getParameter("advsearch"));
	if(fulltextSearch != 1)
		fulltextSearch = 0;
}
//System.out.println(fulltextSearch);

int pageCount=1;
int displayCountOnPage=15;
int displayPaginationCount = 5;
int limitStart = 0;
int limitEnd = displayCountOnPage;
int lastPageNo = 0;

String[] tempArray = null;
String searchStatement = "";
String searchStatementSection = "";
int totalSearchResults=0;
int photoTotalResults=0;
int videoTotalResults=0;
String[][] contentDisplayArray = null; //(id, title, sef title, small image, small image alt text, introtext) 
String[][] contentSectionDisplayArray = null; //(id, title, sef title, content type, templatepath) 
String[][] photoContentDisplayArray = null; //(id, title, sef title, small image, small image alt text, introtext) 
String[][] photoContentSectionDisplayArray = null; //(id, title, sef title, content type, templatepath) 
String[][] videoContentDisplayArray = null; //(id, title, sef title, small image, small image alt text, introtext) 
String[][] videoContentSectionDisplayArray = null; //(id, title, sef title, content type, templatepath) 
//Code for Current Date START
DateFormat year = new SimpleDateFormat("yyyy");
DateFormat month = new SimpleDateFormat("M");
DateFormat day = new SimpleDateFormat("d");
String yearFinal = year.format(new Date());
String monthFinal = month.format(new Date());
if(monthFinal.length()==1)
	monthFinal="0"+monthFinal;
String dayFinal = day.format(new Date());
if(dayFinal.length()==1)
	dayFinal="0"+dayFinal;
String currentDate = yearFinal+monthFinal+dayFinal;
//System.out.println("currentDate->"+currentDate);
//Code for Current Date END

//search criteria and parameters FROM
String searchFileName = "advanced_search.jsp";
String searchText="";
String searchTextCondition="";
int byline=0;
String searchPhrase = "exact"; //any/all/exact
//Commented on 160514String searchType = "mixed"; //story/video/photo/mixed/profile

String searchType = "story"; //story/video/photo/mixed/profile
//String searchType = "story"; //story/video/photo
String searchSection="";
String startDate = "";
String endDate = "";
int currentPageNo=1;
String displayOrdering="descending"; //ascending/descending

if(request.getParameter("searchtext")!=null && !request.getParameter("searchtext").equals("")){
	searchText=request.getParameter("searchtext");
	if(searchText.equals("Search..."))
		searchText="";
}
if(request.getParameter("searchword")!=null && !request.getParameter("searchword").equals("")){
	searchText=request.getParameter("searchword");
	if(searchText.equals("Search..."))
		searchText="";
}

//out.println("Before-> "+searchText);
searchText = searchText.replaceAll("\\<.*?>","");
searchText = searchText.replaceAll("\\:","\\\\:").replaceAll("\\@","").replaceAll("\"","\\\\\"").replaceAll("http://","");
//+ - && || ! ( ) { } [ ] ^  ~ * ? : "\
//out.println("After-> "+searchText);

if(request.getParameter("byline")!=null && request.getParameter("byline").length()>0){
	if(Integer.parseInt(request.getParameter("byline"))==1)
		byline=1;
}
if(request.getParameter("searchphrase")!=null && request.getParameter("searchphrase").length()>0){
	searchPhrase=request.getParameter("searchphrase");
	if(!searchPhrase.equals("exact") && !searchPhrase.equals("all") && !searchPhrase.equals("any"))
		searchPhrase="exact";
}
if(request.getParameter("searchtype")!=null && request.getParameter("searchtype").length()>0){
	searchType=request.getParameter("searchtype");
}
if(searchType.equals("text"))
	searchType="story";
if(request.getParameter("section")!=null && request.getParameter("section").length()>0){
	searchSection=request.getParameter("section");
}
if(request.getParameter("startdate")!=null && !request.getParameter("startdate").equals("")){
	startDate=request.getParameter("startdate").replaceAll("-","").replaceAll("\\<.*?>","").replaceAll("\\:","\\\\:").replaceAll("\\@","").replaceAll("\"","\\\\\"").replaceAll("http://","");
}
if(request.getParameter("enddate")!=null && !request.getParameter("enddate").equals("")){
	endDate=request.getParameter("enddate").replaceAll("-","").replaceAll("\\<.*?>","").replaceAll("\\:","\\\\:").replaceAll("\\@","").replaceAll("\"","\\\\\"").replaceAll("http://","");
}

if(request.getParameter("page")!=null && request.getParameter("page").length()>0){
	currentPageNo=Integer.parseInt(request.getParameter("page"));
}

String searchURL = searchFileName;
String searchURLTab = searchFileName;
if(searchText.trim().length()>0) {
	searchURL = searchURL + "?searchtext="+searchText;
	if(byline==1)
		searchURL = searchURL + "&byline="+byline;
	if(searchPhrase.trim().length()>0)
		searchURL = searchURL + "&searchphrase="+searchPhrase;
	if(searchSection.trim().length()>0)
		searchURL = searchURL + "&section="+searchSection;
	if(startDate.trim().length()>0)
		searchURL = searchURL + "&startdate="+startDate;
	if(endDate.trim().length()>0)
		searchURL = searchURL + "&enddate="+endDate;

	searchURLTab = searchURL;
	if(searchType.trim().length()>0)
		searchURL = searchURL + "&searchtype="+searchType;
} else {
	searchURL = "";
	if(startDate.trim().length()>0)
		searchURL = searchURL + "?startdate="+startDate;
	if(startDate.trim().length()>0 && endDate.trim().length()>0)
		searchURL = searchURL + "&enddate="+endDate;
	if(startDate.trim().length()==0 && endDate.trim().length()>0)
		searchURL = searchURL + "?enddate="+endDate;
	if(startDate.trim().length()==0 && endDate.trim().length()==0)
		searchURL = searchURL + "?startdate="+currentDate + "&enddate="+currentDate;
	searchURLTab = searchURL;
}

//System.out.println("searchURL->"+searchURL);
//search criteria and parameters TILL

//out.println("searchtext-->"+searchText);

searchStatement = searchText;
if(!searchStatement.equals("")) {
	if(searchText.contains(" ") && searchPhrase.equals("exact") ) {
		searchTextCondition = '"'+searchText+'"';
	} else if(searchText.contains(" ") && searchPhrase.equals("all") ) {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " AND ";
		}
	} else {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " OR ";
		}
	}

		if(byline==0) {
		 if(searchType.equals("video")) {
				searchStatement = "(title:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") introtext:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+"))";
			} else if(searchType.equals("photo")) {
				searchStatement = "(title:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") photocaption:("+searchTextCondition+") photometakeyword:("+searchTextCondition+") photoalttext:("+searchTextCondition+"))";
			} else if(searchType.equals("archive")) {
				if(fulltextSearch==0) 
					searchStatement = "(title:("+searchTextCondition+") titlemagazine:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+") introtext:("+searchTextCondition+") -issueid:(0))";
				else
					searchStatement = "(title:("+searchTextCondition+") titlemagazine:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+") fulltext:("+searchTextCondition+") introtext:("+searchTextCondition+") -issueid:(0))";
			}else {
				if(fulltextSearch==0) 
					searchStatement = "(title:("+searchTextCondition+") titlemagazine:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+") introtext:("+searchTextCondition+") )";
				else
					searchStatement = "(title:("+searchTextCondition+") titlemagazine:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+") fulltext:("+searchTextCondition+") introtext:("+searchTextCondition+"))";
			}
		} else {
				searchStatement = " (byline:("+searchText+"))";
		}

		String[] tempArraySpecial = null;
		tempArraySpecial = searchText.split(" ");
		searchTextConditionSpecial = "";
		for(int i=0; i < tempArraySpecial.length;i++) {
			searchTextConditionSpecial += tempArraySpecial[i];
			if(i < tempArraySpecial.length-1)
				searchTextConditionSpecial += " AND ";
		}
		String[] tempArrayProfile = null;
		tempArrayProfile = searchText.split(" ");
		searchTextConditionProfile = "";
		for(int i=0; i < tempArrayProfile.length;i++) {
			searchTextConditionProfile += tempArrayProfile[i];
			if(i < tempArrayProfile.length-1)
				searchTextConditionProfile += " AND ";
		}

}

//if(!searchStatement.equals("") && byline!=0) {
//	searchStatement = searchStatement + " OR (byline:("+searchText+"))";
//}
if(!searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+endDate+"]";
} else if(!searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+currentDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+endDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+currentDate+"]";
}

//220515 for default blank page FROM
/*if(searchStatement.trim().length() ==0) {
	searchStatement = " createddate:("+currentDate+")";
}*/
//220515 for default blank page TILL
//out.println("searchStatement SA1->"+searchStatement+"<br />");
//out.println("searchText->"+searchText+"<br />");

List<SearchBean> alist = new ArrayList<SearchBean>();
SearchBean sb= null,sb1= null,sb2= null;
int mixedContentTotalResults=0;

//Section search Function START
if(!searchText.trim().equals("")) {
	searchStatementSection = "(title:("+searchTextCondition+"))";
	searchStatementSpecial = "(title:("+searchTextConditionSpecial+") metakeyword:("+searchTextConditionSpecial+") metadescription:("+searchTextConditionSpecial+") shortdescription:("+searchTextConditionSpecial+"))";
	searchStatementProfile = "(headline:("+searchTextConditionProfile+") metakeyword:("+searchTextConditionProfile+") metadescription:("+searchTextConditionProfile+") maintext:("+searchTextConditionProfile+"))";
	//searchStatementSection = "(title:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+"))";
	//out.println("searchStatementSection->"+searchStatementSection);
	if(searchType.equals("video")) {
		try {
			IndexSearcher isS = new IndexSearcher(VIDEOSECTION_INDEXPATH);
			Analyzer analyzerS = new StandardAnalyzer();
			QueryParser parserS = new QueryParser("title", analyzerS);
			Query queryS = parserS.parse(searchStatementSection);
			Hits hitsS = isS.search(queryS);
			totalSearchResults = hitsS.length();
			contentSectionDisplayArray = new String[totalSearchResults][4];
			//System.out.println("totalSearchResults Section->"+totalSearchResults);

			for (int i=0; i<totalSearchResults; i++) {
				Document docS = hitsS.doc(i);
					contentSectionDisplayArray[i][0] = docS.get("id");
					contentSectionDisplayArray[i][1] = docS.get("title");
					contentSectionDisplayArray[i][2] = docS.get("seftitle");
					contentSectionDisplayArray[i][3] = docS.get("templatepath").trim().length()==0?"":docS.get("templatepath");
			}
			isS.close();
		} catch(Exception ee){
			System.out.println("video section search display -> "+ee.toString());
		} finally{
		}
		/*if(contentSectionDisplayArray != null && contentSectionDisplayArray.length>0) {
			for (int i=0; i<contentSectionDisplayArray.length; i++) {
				System.out.println(i + "---- " + contentSectionDisplayArray[i][0] + "---- " + contentSectionDisplayArray[i][1] + "---- " + contentSectionDisplayArray[i][2] + "---- " + contentSectionDisplayArray[i][3]+"<br /><br />");
			}
		}*/
	} else if(searchType.equals("photo")) {
		try {
			IndexSearcher isS = new IndexSearcher(PHOTOSECTION_INDEXPATH);
			Analyzer analyzerS = new StandardAnalyzer();
			QueryParser parserS = new QueryParser("title", analyzerS);
			Query queryS = parserS.parse(searchStatementSection);
			Hits hitsS = isS.search(queryS);
			totalSearchResults = hitsS.length();
			contentSectionDisplayArray = new String[totalSearchResults][3];
			//System.out.println("totalSearchResults Section->"+totalSearchResults);

			for (int i=0; i<totalSearchResults; i++) {
				Document docS = hitsS.doc(i);
					contentSectionDisplayArray[i][0] = docS.get("id");
					contentSectionDisplayArray[i][1] = docS.get("title");
					contentSectionDisplayArray[i][2] = docS.get("seftitle");
			}
			isS.close();
		} catch(Exception ee){
			System.out.println("photo section search display -> "+ee.toString());
		} finally{
		}
		/*if(contentSectionDisplayArray != null && contentSectionDisplayArray.length>0) {
			for (int i=0; i<contentSectionDisplayArray.length; i++) {
				System.out.println(i + "---- " + contentSectionDisplayArray[i][0] + "---- " + contentSectionDisplayArray[i][1] + "---- " + contentSectionDisplayArray[i][2]+"<br /><br />");
			}
		}*/
	} else {
		try {
			IndexSearcher isS = new IndexSearcher(STORYSECTION_INDEXPATH);
			Analyzer analyzerS = new StandardAnalyzer();
			QueryParser parserS = new QueryParser("title", analyzerS);
			Query queryS = parserS.parse(searchStatementSection);
			Hits hitsS = isS.search(queryS);
			totalSearchResults = hitsS.length();
			contentSectionDisplayArray = new String[totalSearchResults][5];
			//System.out.println("totalSearchResults Section->"+totalSearchResults);

			for (int i=0; i<totalSearchResults; i++) {
				Document docS = hitsS.doc(i);
					contentSectionDisplayArray[i][0] = docS.get("id");
					contentSectionDisplayArray[i][1] = docS.get("title");
					contentSectionDisplayArray[i][2] = docS.get("seftitle");
					contentSectionDisplayArray[i][3] = docS.get("templatepath");
					contentSectionDisplayArray[i][4] = docS.get("contenttype");
			}
			isS.close();
		} catch(Exception ee){
			System.out.println("photo section search display -> "+ee.toString());
		} finally{
		}
		/*if(contentSectionDisplayArray != null && contentSectionDisplayArray.length>0) {
			for (int i=0; i<contentSectionDisplayArray.length; i++) {
				System.out.println(i + "---- " + contentSectionDisplayArray[i][0] + "---- " + contentSectionDisplayArray[i][1] + "---- " + contentSectionDisplayArray[i][2]+"<br /><br />");
			}
		}*/
		try {
			IndexSearcher isSp = new IndexSearcher(SPECIAL_INDEXPATH);
			Analyzer analyzerSp = new StandardAnalyzer();
			QueryParser parserSp = new QueryParser("title", analyzerSp);
			Query querySp = parserSp.parse(searchStatementSpecial);
			Hits hitsSp = isSp.search(querySp);
			totalSearchResults = hitsSp.length();
			contentSpecialDisplayArray = new String[totalSearchResults][2];
			//out.println("totalSearchResults Special->"+totalSearchResults);

			for (int i=0; i<totalSearchResults; i++) {
				Document docSp = hitsSp.doc(i);
					contentSpecialDisplayArray[i][0] = docSp.get("title");
					contentSpecialDisplayArray[i][1] = docSp.get("url");
					//out.println("contentSpecialDisplayArray[i][0]--->"+contentSpecialDisplayArray[i][0]);
					//out.println("contentSpecialDisplayArray[i][1]--->"+contentSpecialDisplayArray[i][1]);
			}
			isSp.close();
		} catch(Exception ee){
			System.out.println("special search display -> "+ee.toString());
		} finally{
		}
		try {
			IndexSearcher isPro = new IndexSearcher(PROFILE_INDEXPATH);
			Analyzer analyzerPro = new StandardAnalyzer();
			QueryParser parserPro = new QueryParser("headline", analyzerPro);
			Query queryPro = parserPro.parse(searchStatementProfile);
			Hits hitsPro = isPro.search(queryPro);
			totalSearchResults = hitsPro.length();
			contentProfileDisplayArray = new String[totalSearchResults][2];
			//out.println("totalSearchResults Special->"+totalSearchResults);

			for (int i=0; i<totalSearchResults; i++) {
				Document docPro = hitsPro.doc(i);
					contentProfileDisplayArray[i][0] ="http://megacritictemp.intoday.in/";
					contentProfileDisplayArray[i][1] = docPro.get("contenturl");
					out.println("contentSpecialDisplayArray[i][0]--->"+contentSpecialDisplayArray[i][0]);
					out.println("contentSpecialDisplayArray[i][1]--->"+contentSpecialDisplayArray[i][1]);
			}
			isPro.close();
		} catch(Exception ee){
			System.out.println("profile search display -> "+ee.toString());
		} finally{
		}


	}
}

//Section search Function END


if(!searchStatement.trim().equals("")) {
	//out.println("searchStatement-->"+searchStatement+"<br /><br />");
	if(searchType.equals("mixed")) {
	
		
		
	
	//out.println("searchStatement-->"+searchStatement+"<br /><br />");
	
	
		try {
		if(request.getParameter("page")!=null && !request.getParameter("page").equals("")){
	currentPageNo=Integer.parseInt(request.getParameter("page"));
}
pageCount=1;
displayCountOnPage=15;
limitStart = 0;
limitEnd = displayCountOnPage;	
searchStatement="";		
searchStatement = searchText;
if(!searchStatement.equals("")) {
	if(searchText.contains(" ") && searchPhrase.equals("exact") ) {
		searchTextCondition = '"'+searchText+'"';
	} else if(searchText.contains(" ") && searchPhrase.equals("all") ) {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " AND ";
		}
	} else {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " OR ";
		}
	}

		if(byline==0) {
	
				searchStatement = "(title:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") introtext:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+"))";
			
		} else {
				searchStatement = " (byline:("+searchText+"))";
		}

		String[] tempArraySpecial = null;
		tempArraySpecial = searchText.split(" ");
		searchTextConditionSpecial = "";
		for(int i=0; i < tempArraySpecial.length;i++) {
			searchTextConditionSpecial += tempArraySpecial[i];
			if(i < tempArraySpecial.length-1)
				searchTextConditionSpecial += " OR ";
		}
		String[] tempArrayProfile = null;
		tempArrayProfile = searchText.split(" ");
		searchTextConditionProfile = "";
		for(int i=0; i < tempArrayProfile.length;i++) {
			searchTextConditionProfile += tempArrayProfile[i];
			if(i < tempArrayProfile.length-1)
				searchTextConditionProfile += " OR ";
		}

}

//if(!searchStatement.equals("") && byline!=0) {
//	searchStatement = searchStatement + " OR (byline:("+searchText+"))";
//}
if(searchStatement.length()>0 && startDate.length()>0 && endDate.length()>0) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+endDate+"]";
} else if(!searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+currentDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+endDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+currentDate+"]";
}

if(searchStatement.trim().length() ==0) {
	searchStatement = " createddate:("+currentDate+")";
}
		
			IndexSearcher is = new IndexSearcher(VIDEO_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("title", analyzer);
			Query query = parser.parse(searchStatement);
			SortField sortField = new SortField("createddatetime", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			videoTotalResults=totalSearchResults;
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);

			if(videoTotalResults%displayCountOnPage==0) {
				pageCount = videoTotalResults / displayCountOnPage;
			} else {
				pageCount = (videoTotalResults / displayCountOnPage)+1;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && videoTotalResults%displayCountOnPage!=0) {
				limitEnd = videoTotalResults%displayCountOnPage;
				videoContentDisplayArray = new String[limitEnd][11];
			} else {
				if(videoTotalResults >=displayCountOnPage) {
					videoContentDisplayArray = new String[displayCountOnPage][11];
				} else {
					videoContentDisplayArray = new String[videoTotalResults][11];
				}
			}

			//System.out.println("totalSearchResults->"+totalSearchResults+"----limitStart-> "+limitStart+"----contentDisplayArray.length->"+videoContentDisplayArray.length+"----limitEnd->"+limitEnd);
			//System.out.println("remaining content->"+totalSearchResults/displayCountOnPage);
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			
			
			//System.out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);
			for (int i=0, ctr=0; i<videoTotalResults && ctr < limitEnd; i++) {
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);
				if(i>=limitStart) {
					videoContentDisplayArray[ctr][0] = doc.get("id");
					videoContentDisplayArray[ctr][1] = doc.get("title");
					videoContentDisplayArray[ctr][2] = doc.get("seftitle");
					videoContentDisplayArray[ctr][3] = doc.get("byline").trim().length()==0?"":doc.get("byline");
					videoContentDisplayArray[ctr][4] = doc.get("city").trim().length()==0?"":doc.get("city");
					videoContentDisplayArray[ctr][5] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					videoContentDisplayArray[ctr][6] = doc.get("image").trim().length()==0?"":doc.get("image");
					videoContentDisplayArray[ctr][7] = doc.get("imagealttext").trim().length()==0?"":doc.get("imagealttext");
					videoContentDisplayArray[ctr][8] = doc.get("introtext").trim().length()==0?"":doc.get("introtext");
					videoContentDisplayArray[ctr][9] = doc.get("contenttype");
					videoContentDisplayArray[ctr][10] = doc.get("contenturl");
					
					
					sb= new SearchBean();
					sb.setId(doc.get("id"));
					sb.setPublishDate(doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay"));
					sb.setTitle(doc.get("title"));
					sb.setSefUrl(doc.get("seftitle"));
					sb.setIntrotext(doc.get("introtext").trim().length()==0?"":doc.get("introtext"));
					sb.setThumbImage(doc.get("image").trim().length()==0?"":doc.get("image"));
					sb.setContentURL(doc.get("contenturl").trim().length()==0?"":doc.get("contenturl"));
					sb.setSection("video");					
					alist.add(sb);
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("video content search -> "+ee.toString());
			
		} finally{
		}
	
	
		try {
if(request.getParameter("page")!=null && !request.getParameter("page").equals("")){
	currentPageNo=Integer.parseInt(request.getParameter("page"));
}	


 pageCount=1;
 displayCountOnPage=15;
 limitStart = 0;
 limitEnd = displayCountOnPage;
		
searchStatement="";			
searchStatement = searchText;
if(!searchStatement.equals("")) {
	if(searchText.contains(" ") && searchPhrase.equals("exact") ) {
		searchTextCondition = '"'+searchText+'"';
	} else if(searchText.contains(" ") && searchPhrase.equals("all") ) {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " AND ";
		}
	} else {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " OR ";
		}
	}

		if(byline==0) {
		
				searchStatement = "(title:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") photocaption:("+searchTextCondition+") photometakeyword:("+searchTextCondition+") photoalttext:("+searchTextCondition+"))";
			
		} else {
				searchStatement = " (byline:("+searchText+"))";
		}

		String[] tempArraySpecial = null;
		tempArraySpecial = searchText.split(" ");
		searchTextConditionSpecial = "";
		for(int i=0; i < tempArraySpecial.length;i++) {
			searchTextConditionSpecial += tempArraySpecial[i];
			if(i < tempArraySpecial.length-1)
				searchTextConditionSpecial += " OR ";
		}
		String[] tempArrayProfile = null;
		tempArrayProfile = searchText.split(" ");
		searchTextConditionProfile = "";
		for(int i=0; i < tempArrayProfile.length;i++) {
			searchTextConditionProfile += tempArrayProfile[i];
			if(i < tempArrayProfile.length-1)
				searchTextConditionProfile += " OR ";
		}

}

//if(!searchStatement.equals("") && byline!=0) {
//	searchStatement = searchStatement + " OR (byline:("+searchText+"))";
//}
if(!searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+endDate+"]";
} else if(!searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+currentDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+endDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+currentDate+"]";
}

if(searchStatement.trim().length() ==0) {
	searchStatement = " createddate:("+currentDate+")";
}
		
			IndexSearcher is = new IndexSearcher(PHOTO_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("title", analyzer);
			Query query = parser.parse(searchStatement);
			SortField sortField = new SortField("createddatetime", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			photoTotalResults=totalSearchResults;
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);
	
			if(photoTotalResults%displayCountOnPage==0) {
				pageCount = photoTotalResults / displayCountOnPage;
			} else {
				pageCount = (photoTotalResults / displayCountOnPage)+1;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
		
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && photoTotalResults%displayCountOnPage!=0) {
				limitEnd = photoTotalResults%displayCountOnPage;
				photoContentDisplayArray = new String[limitEnd][6];
			} else {
				if(photoTotalResults >=displayCountOnPage) {
					photoContentDisplayArray = new String[displayCountOnPage][6];
				} else {
					photoContentDisplayArray = new String[photoTotalResults][6];
				}
			}
		//out.println("5_____________________>"+currentPageNo+"limit " +limitEnd);	
		//out.println("################"+displayCountOnPage+"limit " +limitStart+"@@@@@@@@@"+totalSearchResults);
			//System.out.println("totalSearchResults->"+totalSearchResults+" ----limitStart->"+limitStart+"---- contentDisplayArray.length-> "+photoContentDisplayArray.length+"----limitEnd-> "+limitEnd+"-----remaining content->"+totalSearchResults/displayCountOnPage);
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			//System.out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);
			
			

			for (int i=0, ctr=0; i<photoTotalResults && ctr < limitEnd; i++) {
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);
				//Document doc = hits.doc(i);
				if(i>=limitStart) {
					photoContentDisplayArray[ctr][0] = doc.get("id");
					photoContentDisplayArray[ctr][1] = doc.get("title");
					photoContentDisplayArray[ctr][2] = doc.get("seftitle");
					photoContentDisplayArray[ctr][3] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					photoContentDisplayArray[ctr][4] = doc.get("image").trim().length()==0?"":doc.get("image");
					photoContentDisplayArray[ctr][5] = doc.get("contenturl").trim().length()==0?"":doc.get("contenturl");
					
					sb1= new SearchBean();
					sb1.setId(doc.get("id"));
					sb1.setPublishDate(doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay"));
					sb1.setTitle(doc.get("title"));
					sb1.setSefUrl(doc.get("seftitle"));					
					sb1.setThumbImage(doc.get("image").trim().length()==0?"":doc.get("image"));
					sb1.setContentURL(doc.get("contenturl").trim().length()==0?"":doc.get("contenturl"));
					sb1.setSection("photo");					
					alist.add(sb1);
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("photo content search -> "+ee.toString());
			ee.printStackTrace();
		} finally{
		}
	
		try {
if(request.getParameter("page")!=null && !request.getParameter("page").equals("")){
	currentPageNo=Integer.parseInt(request.getParameter("page"));
}		
 pageCount=1;
 displayCountOnPage=15;
 limitStart = 0;
 limitEnd = displayCountOnPage;		
searchStatement="";		
searchStatement = searchText;
if(!searchStatement.equals("")) {
	if(searchText.contains(" ") && searchPhrase.equals("exact") ) {
		searchTextCondition = '"'+searchText+'"';
	} else if(searchText.contains(" ") && searchPhrase.equals("all") ) {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " AND ";
		}
	} else {
		tempArray = searchText.split(" ");
		searchTextCondition = "";
		for(int i=0; i < tempArray.length;i++) {
			searchTextCondition += tempArray[i];
			if(i < tempArray.length-1)
				searchTextCondition += " OR ";
		}
	}

		if(byline==0) {
		 
				if(fulltextSearch==0) 
					searchStatement = "(title:("+searchTextCondition+") titlemagazine:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+") introtext:("+searchTextCondition+"))";
				else
					searchStatement = "(title:("+searchTextCondition+") titlemagazine:("+searchTextCondition+") metakeyword:("+searchTextCondition+") metadescription:("+searchTextCondition+") byline:("+searchTextCondition+") city:("+searchTextCondition+") fulltext:("+searchTextCondition+") introtext:("+searchTextCondition+"))";
			
		} else {
				searchStatement = " (byline:("+searchText+"))";
		}

		String[] tempArraySpecial = null;
		tempArraySpecial = searchText.split(" ");
		searchTextConditionSpecial = "";
		for(int i=0; i < tempArraySpecial.length;i++) {
			searchTextConditionSpecial += tempArraySpecial[i];
			if(i < tempArraySpecial.length-1)
				searchTextConditionSpecial += " OR ";
		}
		String[] tempArrayProfile = null;
		tempArrayProfile = searchText.split(" ");
		searchTextConditionProfile = "";
		for(int i=0; i < tempArrayProfile.length;i++) {
			searchTextConditionProfile += tempArrayProfile[i];
			if(i < tempArrayProfile.length-1)
				searchTextConditionProfile += " OR ";
		}

}

//if(!searchStatement.equals("") && byline!=0) {
//	searchStatement = searchStatement + " OR (byline:("+searchText+"))";
//}
if(!searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+endDate+"]";
} else if(!searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = searchStatement + " AND createddate:["+startDate+" TO "+currentDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && !endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+endDate+"]";
} else if(searchStatement.equals("") && !startDate.equals("") && endDate.equals("")) {
	searchStatement = " createddate:["+startDate+" TO "+currentDate+"]";
}

if(searchStatement.trim().length() ==0) {
	searchStatement = " createddate:("+currentDate+")";
}
			IndexSearcher is = new IndexSearcher(STORY_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("id", analyzer);
			Query query = parser.parse(searchStatement);
			SortField sortField = new SortField("id", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			
	//out.println(searchStatement+"\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);

			if(totalSearchResults%displayCountOnPage==0) {
				pageCount = totalSearchResults / displayCountOnPage;
			} else {
				pageCount = (totalSearchResults / displayCountOnPage)+1;
				//limitEnd = totalSearchResults%displayCountOnPage;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;



	//out.println("################"+displayCountOnPage+"limit " +limitStart+"@@@@@@@@@"+totalSearchResults);
//################15limit 0@@@@@@@@@43##############13
	//out.println(currentPageNo+"!!!!!!!!!!!"+pageCount );
			if(currentPageNo == pageCount && totalSearchResults%displayCountOnPage!=0) {
				limitEnd = totalSearchResults%displayCountOnPage;
				contentDisplayArray = new String[limitEnd][14];
				
			} else {
				if(totalSearchResults >=displayCountOnPage) {
					contentDisplayArray = new String[displayCountOnPage][14];
				} else {
					contentDisplayArray = new String[totalSearchResults][14];
				}
			}

//limitEnd=15;
			//System.out.println("totalSearchResults->"+totalSearchResults+"----limitStart-> "+limitStart+"----contentDisplayArray.length->"+contentDisplayArray.length+"----limitEnd->"+limitEnd);
			//System.out.println("remaining content->"+totalSearchResults/displayCountOnPage);

			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			//out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);
			
				//for (int i=0; i<totalSearchResults ; i++) {
					//out.println(" limitEnd " + i );
				
				//}
				
				
			for (int i=0, ctr=0; i<totalSearchResults && ctr < limitEnd; i++) {
			
				//Document doc = hits.doc(i);
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);
				//out.println("@@@"+doc.get("byline"));
			//out.println(i+" limitEnd " + limitEnd + " --- Total Size->" + totalSearchResults+"@@@@@@@@"+ctr+"<br>"+doc.get("title"));
				if(i>=limitStart) {
					contentDisplayArray[ctr][0] = doc.get("id");
					contentDisplayArray[ctr][1] = doc.get("title");
					contentDisplayArray[ctr][2] = doc.get("seftitle");
					contentDisplayArray[ctr][3] = doc.get("byline").trim().length()==0?"":doc.get("byline");
					contentDisplayArray[ctr][4] = doc.get("city").trim().length()==0?"":doc.get("city");
					contentDisplayArray[ctr][5] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					contentDisplayArray[ctr][6] = doc.get("largeimage").trim().length()==0?"":doc.get("largeimage");
					contentDisplayArray[ctr][7] = doc.get("imagealttext").trim().length()==0?"":doc.get("imagealttext");
					contentDisplayArray[ctr][8] = doc.get("introtext").trim().length()==0?"":doc.get("introtext");
					contentDisplayArray[ctr][9] = doc.get("metadescription").trim().length()==0?"":doc.get("metadescription");
					contentDisplayArray[ctr][10] = doc.get("contenturl").trim().length()==0?"":doc.get("contenturl");
					contentDisplayArray[ctr][11] = doc.get("issueid").trim().length()==0?"":doc.get("issueid");
					contentDisplayArray[ctr][12] = doc.get("issueyear").trim().length()==0?"":doc.get("issueyear");
					contentDisplayArray[ctr][13] = doc.get("issuetitle").trim().length()==0?"":doc.get("issuetitle");
					
					
					sb2= new SearchBean();
					sb2.setId(doc.get("id"));
					sb2.setPublishDate(doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay"));
					sb2.setTitle(doc.get("title"));
					sb2.setSefUrl(doc.get("seftitle"));
					sb2.setIntrotext(doc.get("introtext").trim().length()==0?"":doc.get("introtext"));
					sb2.setThumbImage(doc.get("largeimage").trim().length()==0?"":doc.get("largeimage"));
					sb2.setContentURL(doc.get("contenturl").trim().length()==0?"":doc.get("contenturl"));
					sb2.setSection("story");
					//issue releated
					sb2.setSectionId(Integer.parseInt(doc.get("issueid").trim().length()==0?"":doc.get("issueid")));
					sb2.setSectionName( doc.get("issuetitle").trim().length()==0?"":doc.get("issuetitle"));
					sb2.setSectionSefUrl(doc.get("issueyear").trim().length()==0?"":doc.get("issueyear"));
										
					alist.add(sb2);
					
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("story content search -> "+ee.toString());
		} finally{
		}
		
 mixedContentTotalResults=videoTotalResults+photoTotalResults+totalSearchResults;
totalSearchResults=mixedContentTotalResults;
if(request.getParameter("page")!=null && !request.getParameter("page").equals("")){
	currentPageNo=Integer.parseInt(request.getParameter("page"));
}
 pageCount=1;
 displayCountOnPage=45;
 limitStart = 0;
 limitEnd = displayCountOnPage;

if(totalSearchResults%displayCountOnPage==0) {
				pageCount = totalSearchResults / displayCountOnPage;
			} else {
				pageCount = (totalSearchResults / displayCountOnPage)+1;
				//limitEnd = totalSearchResults%displayCountOnPage;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && totalSearchResults%displayCountOnPage!=0) {
				limitEnd = totalSearchResults%displayCountOnPage;
				//contentDisplayArray = new String[limitEnd][10];
			}
	
	}else if(searchType.equals("video")) {
		try {
			IndexSearcher is = new IndexSearcher(VIDEO_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("title", analyzer);
			Query query = parser.parse(searchStatement);
			SortField sortField = new SortField("createddatetime", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);

			if(totalSearchResults%displayCountOnPage==0) {
				pageCount = totalSearchResults / displayCountOnPage;
			} else {
				pageCount = (totalSearchResults / displayCountOnPage)+1;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && totalSearchResults%displayCountOnPage!=0) {
				limitEnd = totalSearchResults%displayCountOnPage;
				contentDisplayArray = new String[limitEnd][14];
			} else {
				if(totalSearchResults >=displayCountOnPage) {
					contentDisplayArray = new String[displayCountOnPage][14];
				} else {
					contentDisplayArray = new String[totalSearchResults][14];
				}
			}

			//System.out.println("totalSearchResults->"+totalSearchResults+"----limitStart-> "+limitStart+"----contentDisplayArray.length->"+contentDisplayArray.length+"----limitEnd->"+limitEnd);
			//System.out.println("remaining content->"+totalSearchResults/displayCountOnPage);
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			//System.out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);
			for (int i=0, ctr=0; i<totalSearchResults && ctr < limitEnd; i++) {
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);
				if(i>=limitStart) {
					contentDisplayArray[ctr][0] = doc.get("id");
					contentDisplayArray[ctr][1] = doc.get("title");
					contentDisplayArray[ctr][2] = doc.get("seftitle");
					contentDisplayArray[ctr][3] = doc.get("byline").trim().length()==0?"":doc.get("byline");
					contentDisplayArray[ctr][4] = doc.get("city").trim().length()==0?"":doc.get("city");
					contentDisplayArray[ctr][5] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					contentDisplayArray[ctr][6] = doc.get("image").trim().length()==0?"":doc.get("image");
					contentDisplayArray[ctr][7] = doc.get("imagealttext").trim().length()==0?"":doc.get("imagealttext");
					contentDisplayArray[ctr][8] = doc.get("introtext").trim().length()==0?"":doc.get("introtext");
					contentDisplayArray[ctr][9] = doc.get("contenttype");
					contentDisplayArray[ctr][10] = doc.get("contenturl");
					//contentDisplayArray[ctr][11] = doc.get("issueid").trim().length()==0?"":doc.get("issueid");
					//contentDisplayArray[ctr][12] = doc.get("issueyear").trim().length()==0?"":doc.get("issueyear");
					//contentDisplayArray[ctr][13] = doc.get("issuetitle").trim().length()==0?"":doc.get("issuetitle");
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("photo_search.jsp -> "+ee.toString());
		} finally{
		}
	} else if(searchType.equals("photo")) {
		try {
			IndexSearcher is = new IndexSearcher(PHOTO_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("title", analyzer);
			Query query = parser.parse(searchStatement);			
			SortField sortField = new SortField("createddatetime", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);

			if(totalSearchResults%displayCountOnPage==0) {
				pageCount = totalSearchResults / displayCountOnPage;
			} else {
				pageCount = (totalSearchResults / displayCountOnPage)+1;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && totalSearchResults%displayCountOnPage!=0) {
				limitEnd = totalSearchResults%displayCountOnPage;
				contentDisplayArray = new String[limitEnd][6];
			} else {
				if(totalSearchResults >=displayCountOnPage) {
					contentDisplayArray = new String[displayCountOnPage][6];
				} else {
					contentDisplayArray = new String[totalSearchResults][6];
				}
			}

			//System.out.println("totalSearchResults->"+totalSearchResults+" ----limitStart->"+limitStart+"---- contentDisplayArray.length-> "+contentDisplayArray.length+"----limitEnd-> "+limitEnd+"-----remaining content->"+totalSearchResults/displayCountOnPage);
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			//System.out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);

			for (int i=0, ctr=0; i<totalSearchResults && ctr < limitEnd; i++) {
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);
				//Document doc = hits.doc(i);
				if(i>=limitStart) {
					contentDisplayArray[ctr][0] = doc.get("id");
					contentDisplayArray[ctr][1] = doc.get("title");
					contentDisplayArray[ctr][2] = doc.get("seftitle");
					contentDisplayArray[ctr][3] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					contentDisplayArray[ctr][4] = doc.get("image").trim().length()==0?"":doc.get("image");
					contentDisplayArray[ctr][5] = doc.get("contenturl").trim().length()==0?"":doc.get("contenturl");
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("photo_search.jsp -> "+ee.toString());
		} finally{
		}
	} else if(searchType.equals("archive")){
		try {
			IndexSearcher is = new IndexSearcher(STORY_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("title", analyzer);
			Query query = parser.parse(searchStatement);
			SortField sortField = new SortField("createddatetime", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);

			if(totalSearchResults%displayCountOnPage==0) {
				pageCount = totalSearchResults / displayCountOnPage;
			} else {
				pageCount = (totalSearchResults / displayCountOnPage)+1;
				//limitEnd = totalSearchResults%displayCountOnPage;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && totalSearchResults%displayCountOnPage!=0) {
				limitEnd = totalSearchResults%displayCountOnPage;
				contentDisplayArray = new String[limitEnd][13];
			} else {
				if(totalSearchResults >=displayCountOnPage) {
					contentDisplayArray = new String[displayCountOnPage][13];
				} else {
					contentDisplayArray = new String[totalSearchResults][13];
				}
			}

			//System.out.println("totalSearchResults->"+totalSearchResults+"----limitStart-> "+limitStart+"----contentDisplayArray.length->"+contentDisplayArray.length+"----limitEnd->"+limitEnd);
			//System.out.println("remaining content->"+totalSearchResults/displayCountOnPage);

			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			//System.out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);

			for (int i=0, ctr=0; i<totalSearchResults && ctr < limitEnd; i++) {
				//Document doc = hits.doc(i);
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);

				if(i>=limitStart) {
					contentDisplayArray[ctr][0] = doc.get("id");
					contentDisplayArray[ctr][1] = doc.get("title");
					contentDisplayArray[ctr][2] = doc.get("seftitle");
					contentDisplayArray[ctr][3] = doc.get("byline").trim().length()==0?"":doc.get("byline");
					contentDisplayArray[ctr][4] = doc.get("city").trim().length()==0?"":doc.get("city");
					contentDisplayArray[ctr][5] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					contentDisplayArray[ctr][6] = doc.get("largeimage").trim().length()==0?"":doc.get("largeimage");
					contentDisplayArray[ctr][7] = doc.get("imagealttext").trim().length()==0?"":doc.get("imagealttext");
					contentDisplayArray[ctr][8] = doc.get("introtext").trim().length()==0?"":doc.get("introtext");
					contentDisplayArray[ctr][9] = doc.get("contenturl").trim().length()==0?"":doc.get("contenturl");
					contentDisplayArray[ctr][10] = doc.get("issueid").trim().length()==0?"":doc.get("issueid");
					contentDisplayArray[ctr][11] = doc.get("issueyear").trim().length()==0?"":doc.get("issueyear");
					contentDisplayArray[ctr][12] = doc.get("issuetitle").trim().length()==0?"":doc.get("issuetitle");
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("story_search.jsp -> "+ee.toString());
		} finally{
		}

	}else {
		try {
			IndexSearcher is = new IndexSearcher(STORY_INDEXPATH);
			Analyzer analyzer = new StandardAnalyzer();
			QueryParser parser = new QueryParser("title", analyzer);
			Query query = parser.parse(searchStatement);
			SortField sortField = new SortField("createddatetime", true);	
			Sort sort = new Sort(sortField);
			TopDocs results = is.search(query, null, 500000, sort);
			totalSearchResults = results.totalHits;
			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + totalSearchResults);

			if(totalSearchResults%displayCountOnPage==0) {
				pageCount = totalSearchResults / displayCountOnPage;
			} else {
				pageCount = (totalSearchResults / displayCountOnPage)+1;
				//limitEnd = totalSearchResults%displayCountOnPage;
			}
			lastPageNo  = pageCount;
			//System.out.println("pageCount->"+pageCount);
			if(currentPageNo < 1 || currentPageNo > pageCount )
				currentPageNo=1;
			limitStart = (currentPageNo-1)*displayCountOnPage;

			if(currentPageNo == pageCount && totalSearchResults%displayCountOnPage!=0) {
				limitEnd = totalSearchResults%displayCountOnPage;
				contentDisplayArray = new String[limitEnd][13];
			} else {
				if(totalSearchResults >=displayCountOnPage) {
					contentDisplayArray = new String[displayCountOnPage][13];
				} else {
					contentDisplayArray = new String[totalSearchResults][13];
				}
			}

			//System.out.println("totalSearchResults->"+totalSearchResults+"----limitStart-> "+limitStart+"----contentDisplayArray.length->"+contentDisplayArray.length+"----limitEnd->"+limitEnd);
			//System.out.println("remaining content->"+totalSearchResults/displayCountOnPage);

			//System.out.println("\nResults for: " + query.toString() + " sorted by " + sort + " --- Total Size->" + results.totalHits);
			ScoreDoc[] hits = null;
			if(results.totalHits > 0) {
				hits = results.scoreDocs;
			}
			//System.out.println("\nResults for hits:  " + hits.length + " --- Total Size->" + results.totalHits);

			for (int i=0, ctr=0; i<totalSearchResults && ctr < limitEnd; i++) {
				//Document doc = hits.doc(i);
				int tempCtr = hits[i].doc;
				Document doc = is.doc(tempCtr);

				if(i>=limitStart) {
					contentDisplayArray[ctr][0] = doc.get("id");
					contentDisplayArray[ctr][1] = doc.get("title");
					contentDisplayArray[ctr][2] = doc.get("seftitle");
					contentDisplayArray[ctr][3] = doc.get("byline").trim().length()==0?"":doc.get("byline");
					contentDisplayArray[ctr][4] = doc.get("city").trim().length()==0?"":doc.get("city");
					contentDisplayArray[ctr][5] = doc.get("createddatedisplay").trim().length()==0?"":doc.get("createddatedisplay");
					contentDisplayArray[ctr][6] = doc.get("largeimage").trim().length()==0?"":doc.get("largeimage");
					contentDisplayArray[ctr][7] = doc.get("imagealttext").trim().length()==0?"":doc.get("imagealttext");
					contentDisplayArray[ctr][8] = doc.get("introtext").trim().length()==0?"":doc.get("introtext");
					contentDisplayArray[ctr][9] = doc.get("contenturl").trim().length()==0?"":doc.get("contenturl");
					contentDisplayArray[ctr][10] = doc.get("issueid").trim().length()==0?"":doc.get("issueid");
					contentDisplayArray[ctr][11] = doc.get("issueyear").trim().length()==0?"":doc.get("issueyear");
					contentDisplayArray[ctr][12] = doc.get("issuetitle").trim().length()==0?"":doc.get("issuetitle");
					ctr++;
				}
			}
			is.close();
			hits=null;
		} catch(Exception ee){
			System.out.println("story_search.jsp -> "+ee.toString());
		} finally{
		}

	}

}
%><!DOCTYPE html><html lang="en">
<head>
<%//@include file="ga.jsp"%>
<meta charset="utf-8">
<title>megacritic serch</title>
<link rel="stylesheet" type="text/css" href="/megacritic/css/it-common-15.css" />
<link href='http://fonts.googleapis.com/css?family=Roboto:100,200,300,700,500,400,900' rel='stylesheet' type='text/css'>
<%--<link href="http://indiatoday.intoday.in/css/calendar-mos.css" type="text/css" rel="stylesheet">--%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"/>
<script language="JavaScript" src="/megacritic/js/calc.js" type="text/javascript"></script>
<script language="JavaScript" src="/megacritic/js/calendar_mini.js" type="text/javascript"></script>
<script language="JavaScript" src="/megacritic/js/calendar-en.js" type="text/javascript"></script>
<meta name="robots" content="noindex, nofollow" />
<link href="/megacritic/css/search-new.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/megacritic/css/it-responsive-15.css" />
<link rel="stylesheet" type="text/css" href="/megacritic/css/calendar-mos.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ include file="/jsp/common/css-js.jsp" %>
</head>
<body>
<%@ include file="/jsp/common/header.jsp" %>
<div class="clearfix"></div>
<!--body section-->
 
<form style="margin:0;padding:0;" onSubmit="return validatesearch('mod_search_searchwordtr');" name="searchform1" method="get" action="<%=MegacriticCommonConstants.SITE_URL%>jsp/search/advanced_search.jsp">
<div class="searchtop">
<div class="wrapper">
<a href="http://megacritictemp.intoday.in/" class=""></a>
<input type="submit" value="search" class="submit-btn searchbtn" name="">
</div></div>
<input type="hidden" value="com_search" name="option">
<div class="searchbot">
<input type="text" value="" placeholder="Type to search" id="mod_search_searchwordtr" name="searchword" class="input-box" > 
</div></form> 
<div class="clear"></div>
<%if ( !searchText.equals("") && totalSearchResults ==0) {	
	out.print("<div class=\"searchtextbot\">Total 0 results found. Search for ["+searchText+"]</div>");

} %>
<%if(totalSearchResults>0){%>

<div class="wrapper">

<div class="leftnav">
<div id="searchbox">
<!--new-->
<div class="search-head">
		<%if(searchType.equals("mixed")){
		out.print("<div class='search-tab current-tab'><a href=\"#\">ALL</a><div class='found-result'>"+totalSearchResults+" results</div></div>");
			
		}else{
		out.print("<div class='search-tab'><a href=\""+searchURLTab+"&searchtype=mixed\">ALL</a></div>");
		}if(searchType.equals("story")){ 
					out.print("<div class='search-tab current-tab'><a href=\"#\">Articles</a><div class='found-result'>"+totalSearchResults+" results</div></div>");
			}else{
				out.print("<div class='search-tab'><a href=\""+searchURLTab+"&searchtype=story\">TRAILER</a></div>");
		}%>
		
		<%if(searchType.equals("video")){ 
					out.print("<div class='search-tab current-tab'><a href=\"#\">Videos</a><div class='found-result'>"+totalSearchResults+" results</div></div>");
			}else{
				out.print("<div class='search-tab'><a href=\""+searchURLTab+"&searchtype=video\">VIDEOS</a></div>");
		}%>
		<%if(searchType.equals("photo")){ 
					out.print("<div class='search-tab current-tab '><a href=\"#\">Photos</a><div class='found-result'>"+totalSearchResults+" results</div></div>");
			}else{
				out.print("<div class='search-tab '><a href=\""+searchURLTab+"&searchtype=photo\">PHOTOS</a></div>");
		}%>
		<%if(searchType.equals("archive")){ 
					out.print("<div class='search-tab current-tab last-tab'><a href=\"#\">SONGS</a><div class='found-result'>"+totalSearchResults+" results</div></div>");
			}else{
				out.print("<div class='search-tab last-tab'><a href=\""+searchURLTab+"&searchtype=archive\">MAGAZINE</a></div>");
		}%></div><%if ((contentDisplayArray!=null && contentDisplayArray.length > 0) || contentSpecialDisplayArray!=null || contentProfileDisplayArray!=null) {
	int dispFrom = (currentPageNo-1)*displayCountOnPage+1;
	int dispTill = currentPageNo*displayCountOnPage;
	if(totalSearchResults <= dispTill)
		dispTill = totalSearchResults;

	out.println("<div class=\"searchsectionbox\">");	

	out.print("<div class=\"searchead\">Showing ");
	if(searchType.equals("mixed")) { out.print("Content "); }else if(searchType.equals("photo")) { out.print("Photos "); } else if(searchType.equals("video")) { out.print("Videos  "); } else { out.print("Articles ");}
	out.print(dispFrom+" - "+dispTill+" of " + totalSearchResults+"</div>");
	
	if(currentPageNo == 1){
		if(!searchType.equals("archive")){
		if(contentProfileDisplayArray!=null) { 
			for(int i=0;i<contentProfileDisplayArray.length;i++) {
				out.print("<div class='search-row'><div class=\"serchheadlien\"><span><font color=\"#FF0000\" SIZE=\"2\">Profile</font></span>: <a href=\""+contentProfileDisplayArray[i][1]+"\" target=\"_blank\">"+contentProfileDisplayArray[i][0]+"</a></div></div>");
			}
		}
		if(contentSpecialDisplayArray!=null) { 
			for(int i=0;i<contentSpecialDisplayArray.length;i++) {
				out.print("<div class='search-row'><div class=\"serchheadlien\"><span><font color=\"#FF0000\" SIZE=\"2\">Special</font></span>: <a href=\""+contentSpecialDisplayArray[i][1]+"\" target=\"_blank\">"+contentSpecialDisplayArray[i][0]+"</a></div></div>");
			}
		}
		}
		if(contentSectionDisplayArray!=null) { 
		if(searchType.equals("story")){
			for(int i=0;i<contentSectionDisplayArray.length;i++)
			{
				out.print("<div class=\"search-row\"><div class=\"serchheadlien\"><span><font color=\"#FF0000\" SIZE=\"2\">Section</font></span>:");
				if(contentSectionDisplayArray[i][4].equals("section")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.sectionURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				} else if(contentSectionDisplayArray[i][4].equals("category")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.categoryURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				} else if(contentSectionDisplayArray[i][4].equals("subcategory")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.subCategoryURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				} else if(contentSectionDisplayArray[i][4].equals("subsubcategory")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.subSubCategoryURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				}
				out.print("</div></div>");
			}
		} 
		if(searchType.equals("archive")){
			for(int i=0;i<contentSectionDisplayArray.length;i++)
			{
				out.print("<div class=\"search-row\"><div class=\"serchheadlien\"><span><font color=\"#FF0000\" SIZE=\"2\">Section</font></span>:");
				if(contentSectionDisplayArray[i][4].equals("section")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.sectionURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				} else if(contentSectionDisplayArray[i][4].equals("category")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.categoryURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				} else if(contentSectionDisplayArray[i][4].equals("subcategory")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.subCategoryURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				} else if(contentSectionDisplayArray[i][4].equals("subsubcategory")) {
					out.print("<a href=\""+contentBaseURL+MegacriticCommonConstants.subSubCategoryURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a>");
				}
				out.print("</div></div>");
			}
		} 
		if(searchType.equals("photo")){
			for(int i=0;i<contentSectionDisplayArray.length;i++) {
				out.print("<div class='search-row'><div class=\"serchheadlien\"><a href=\""+contentBaseURL+MegacriticCommonConstants.galleryListURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a></div></div>");
			}
		} 
		if(searchType.equals("video")) {
			for(int i=0;i<contentSectionDisplayArray.length;i++) {
				out.print("<div class='search-row'><div class=\"serchheadlien\"><a href=\""+contentBaseURL+MegacriticCommonConstants.videoListURL(contentSectionDisplayArray[i][2],1,Integer.parseInt(contentSectionDisplayArray[i][0]))+"\">"+contentSectionDisplayArray[i][1]+"</a></div></div>");
			}
		}
				}

	} 
	out.println("</div><div class=\"searchcontbox\">");
	if(searchType.equals("mixed")) {
	//out.println(dispFrom+"@@@@@@@@@@@@@"+dispTill+"@@@@@@@@@@@@@@"+alist.size());
	if (alist!=null && alist.size() > 0) {
	Collections.sort(alist,new MyStringArrayComparator());
        
      //out.println(limitStart+"@@@@@@@@@@@@@"+limitEnd+"@@@@@@@@@@@@@@"+alist.size());
         
          for (int i = 0; i < alist.size(); i++) {
		SearchBean e = (SearchBean) alist.get(i);  
		
		//if(!e.getId().equals("")&& !e.getId().equals("null")&& e.getId()!=null){
         if (i % 3 ==0) { out.print("<div class='search-row'><div class='search-line'>");		}
		if (i % 3 < 2) { 	out.print("<div class=\"searchdotline\">");}
		if (i % 3 == 2) {out.print("<div class=\"searchdotline search-last-col\">");}
	
		//System.out.println("#############"+e.getThumbImage());
		if(e.getThumbImage()!=null && !e.getThumbImage().equals("")&& !e.getThumbImage().equals("null")) {
		
		if(e.getSection().equals("video")){
		if(e.getId()!=null&&!e.getId().equals("")&& !e.getId().equals("null") ){
		%>
			<a href="<%=e.getContentURL()%>"><div class="simgrepeat"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH+e.getThumbImage()%>" alt="<%=e.getTitle()%>" title="<%=e.getTitle()%>" border="0" width="179" height="133"> <span class="media-story-icon" ></span></div></a>
		<%
		}}else if(e.getSection().equals("photo")){
		if(e.getId()!=null&&!e.getId().equals("")&& !e.getId().equals("null") ){
		%>
			<a href="<%=e.getContentURL()%>"><div class="simgrepeat"><img src="<%=MegacriticCommonConstants.GALLERY_IMG_PATH+e.getThumbImage()%>" alt="<%=e.getTitle()%>" title="<%=e.getTitle()%>" border="0" width="179" height="133"> <span class="media-story-icon" ></span></div></a>
		<%
		}}else{
			
		if(e.getId()!=null&&!e.getId().equals("")&& !e.getId().equals("null") ){
		%>
			<a href="<%=e.getContentURL()%>"><div class="simgrepeat"><img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH+e.getThumbImage()%>" alt="<%=e.getTitle()%>" title="<%=e.getTitle()%>" border="0" width="179" height="133"> <span class="media-story-icon" ></span></div></a>
		<%}
	}   
		}else{%>		
		<div class="simgrepeat"><img src="http://media2.intoday.in/indiatoday/images/it-top-nav-logo.png" alt="" title="" border="0" width="179" height="133"> </div>
		<%}
		if(e.getSection().equals("video")){
		if(e.getId()!=null&&!e.getId().equals("")&& !e.getId().equals("null") ){
		%>
		<div class="serchheadlien"><a href="<%=e.getContentURL()%>" target="_blank"><%=e.getTitle()%></a></div>
<%		
		
		}}else if(e.getSection().equals("photo")){
		if(e.getId()!=null&&!e.getId().equals("")&& !e.getId().equals("null") ){
		%>
		<div class="serchheadlien"><a href="<%=e.getContentURL()%>" target="_blank"><%=e.getTitle()%></a></div>
<%		
		}}else{
	
	if(e.getId()!=null&&!e.getId().equals("")&& !e.getId().equals("null") ){
		
		%>
		<div class="serchheadlien"><a href="<%=e.getContentURL()%>" target="_blank"><%=e.getTitle()%></a></div>
<%		
		}}	out.print("<div class=\"searchtime\">"); 
			
			
			if(e.getSectionId()>0){
			
			//out.print("<span><font color=\"#FF0000\" SIZE=\"2\">Edition:</font></span><a href=\""+Constants.SITE_URL+"calendar/"+e.getSectionId()+"/"+e.getSectionSefUrl()+"/magazine.html\" target=\"_blank\">"+e.getSectionName()+"</a>");
			}else{
			
			//if(e.getPublishDate()!=null&&!e.getPublishDate().equals("null")&&!e.getPublishDate().equals(""))
					//out.print(e.getPublishDate());	 
				
				}	
					
				//out.print("</span><br/>");
		out.print("</div>"); 
		
		out.print("<div class=\"searchticker\">");
		
			if(e.getIntrotext()!=null&&!e.getIntrotext().equals("null")&&!e.getIntrotext().equals("")) {
			//out.print(e.getIntrotext());
			  } 
		
		out.print("</div><div class=\"clear\"></div>");
		out.print("</div>");
		if (i % 3 == 2) 
					out.print("</div></div>");
	
	}	if(contentDisplayArray.length%3 !=0) {
			for (int a1 = (contentDisplayArray.length % 3); a1 < 3; a1++) {
				if (a1 % 3 < 2) 
					out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
				if (a1 % 3 == 2) 
					out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
			}
				out.print("</div></div>");
		}
	
	
	}
	
}else if(searchType.equals("video")) {
	for(int i=0;i<contentDisplayArray.length;i++) {
	String videoTempURL = contentBaseURL+MegacriticCommonConstants.videoURL(contentDisplayArray[i][2],1,Integer.parseInt(contentDisplayArray[i][0]));
	if(contentDisplayArray[i][9].equals("programme")) {
		//videoTempURL = MegacriticCommonConstants.SITE_PATH_HLT+HeadlinesTodayHelper.programmeURL(contentDisplayArray[i][2],1,Integer.parseInt(contentDisplayArray[i][0]));
	}

	if (i % 3 ==0) { out.print("<div class='search-row'><div class='search-line'>");		}
	if (i % 3 < 2) { 	out.print("<div class=\"searchdotline\">");}
	if (i % 3 == 2) {out.print("<div class=\"searchdotline search-last-col\">");}
	if(!contentDisplayArray[i][6].equals("")) {%>
		<a href="<%=contentDisplayArray[i][10]%>"><div class="simgrepeat">
        <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH+contentDisplayArray[i][6]%>"  title="<%=contentDisplayArray[i][7]%>" alt="<%=contentDisplayArray[i][7]%>" width="179" height="133"/>
        <span class="media-play-icon" ></span></div></a>
	<%}else{%>		
		<div class="simgrepeat"><img src="http://media2.intoday.in/indiatoday/images/it-top-nav-logo.png" alt="" title="" border="0" width="179" height="133"> </div>
		<%}%>
	<div class="serchheadlien"><a href="<%=contentDisplayArray[i][10]%>"><%=contentDisplayArray[i][1]%></a></div>
	<%if((byline==1 && !contentDisplayArray[i][3].equals("")) || !contentDisplayArray[i][4].equals("") || !contentDisplayArray[i][5].equals("")){ 
			out.print("<div class=\"searchtime\">"); 
			if(byline==1 && !contentDisplayArray[i][3].equals("")){ 
				out.print("<span><font color=\"#FF0000\" SIZE=\"2\"> "+contentDisplayArray[i][3]+"</font></span><br/>"); 
			} 
			if(!contentDisplayArray[i][4].equals("") || !contentDisplayArray[i][5].equals("")){ 
				//out.print("<span>");	 
				//if(!contentDisplayArray[i][4].equals(""))
					//out.print(contentDisplayArray[i][4]);	 
				//if(!contentDisplayArray[i][4].equals("") && !contentDisplayArray[i][5].equals(""))
					//out.print(", ");	 
				//if(!contentDisplayArray[i][5].equals(""))
					//out.print(contentDisplayArray[i][5]);	 
				//out.print("</span><br/>");	 
			}
		out.print("</div>"); 
		}
		
		out.print("<div class=\"searchticker\">");
		if(searchType.equals("photo")) {
			if(!contentDisplayArray[i][1].equals("null")) { //out.print(contentDisplayArray[i][1]); 
			} 
		} else {
			if(!contentDisplayArray[i][8].equals("null")) { //out.print(contentDisplayArray[i][8]); 
			} 
		}
		out.print("</div><div class=\"clear\"></div>");
		out.print("</div>");
		
		if (i % 3 == 2) 
			out.print("</div></div>");
		}
		if(contentDisplayArray.length%3 !=0) {
			for (int a1 = (contentDisplayArray.length % 3); a1 < 3; a1++) {
				if (a1 % 3 < 2) 
					out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
				if (a1 % 3 == 2) 
					out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
			}
				out.print("</div></div>");
		}
		} else if(searchType.equals("photo")) { %>
<%for(int i=0;i<contentDisplayArray.length;i++) {%>
	<%	if (i % 3 ==0) { out.print("<div class='search-row'><div class='search-line'>");}
		if (i % 3 < 2) { 	out.print("<div class=\"searchdotline\">");}
		if (i % 3 == 2) {out.print("<div class=\"searchdotline search-last-col\">");}
	%>
    <%if(!contentDisplayArray[i][4].equals("")) {%>
		<a href="<%=contentBaseURL+MegacriticCommonConstants.galleryURL(contentDisplayArray[i][2],1,Integer.parseInt(contentDisplayArray[i][0]))%>"><div class="simgrepeat">
        <img src="<%=MegacriticCommonConstants.GALLERY_IMG_PATH+contentDisplayArray[i][4]%>"  title="<%=contentDisplayArray[i][1]%>" alt="<%=contentDisplayArray[i][1]%>" width="179" height="133"/>
        <span class="media-image-icon" ></span></div></a>
	<%}else{%>			
		<div class="simgrepeat"><img src="http://media2.intoday.in/indiatoday/images/it-top-nav-logo.png" alt="" title="" border="0" width="179" height="133"> </div>
		<%}%>
	<div class="serchheadlien"><a href="<%=contentDisplayArray[i][5]%>"><%=contentDisplayArray[i][1]%></a></div>
<%	
				out.print("<div class=\"searchticker\">");
		if(searchType.equals("photo")) {
			if(!contentDisplayArray[i][1].equals("null")) { //out.print(contentDisplayArray[i][1]); 
			} 
		} else {
			if(!contentDisplayArray[i][8].equals("null")) { //out.print(contentDisplayArray[i][8]); 
			} 
		}
		out.print("</div><div class=\"clear\"></div>");
		out.print("</div>");
		
			if (i % 3 == 2) 
					out.print("</div></div>");
		}if(contentDisplayArray.length%3 !=0) {
					for (int a1 = (contentDisplayArray.length % 3); a1 < 3; a1++) {
						if (a1 % 3 < 2) 
							out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
						if (a1 % 3 == 2) 
							out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
					}
						out.print("</div></div>");
				}
		
} else if(searchType.equals("archive")) {
out.print("<div style=\"clear:both;\"></div>");
for(int i=0;i<contentDisplayArray.length;i++) { 
			if (i % 3 ==0) { out.print("<div class='search-row'><div class='search-line'>");		}
		if (i % 3 < 2) { 	out.print("<div class=\"searchdotline\">");}
		if (i % 3 == 2) {out.print("<div class=\"searchdotline search-last-col\">");}
		if(!contentDisplayArray[i][6].equals("")) {%>
		<a href="<%=contentDisplayArray[i][9]%>"><div class="simgrepeat">
        <img src="<%=MegacriticCommonConstants.KICKER_IMG_PATH+contentDisplayArray[i][6]%>"  title="<%=contentDisplayArray[i][7]%>" alt="<%=contentDisplayArray[i][7]%>" width="179" height="133"/>
        <span class="media-story-icon" ></span></div></a>
	<%}else{%>		
		<div class="simgrepeat"><img src="http://media2.intoday.in/indiatoday/images/it-top-nav-logo.png" alt="" title="" border="0" width="179" height="133"> </div>
		<%}%>
		<div class="serchheadlien"><a href="<%=contentDisplayArray[i][9]%>" target="_blank"><%=contentDisplayArray[i][1]%></a></div>
<%		if((byline==1 && !contentDisplayArray[i][3].equals("")) || !contentDisplayArray[i][4].equals("") || !contentDisplayArray[i][5].equals("")){ 
			out.print("<div class=\"searchtime\">"); 
			if(byline==1 && !contentDisplayArray[i][3].equals("")){ 
				out.print("<span><font color=\"#FF0000\" SIZE=\"2\"> "+contentDisplayArray[i][3]+"</font></span><br/>"); 
			} 
			if(!contentDisplayArray[i][4].equals("") || !contentDisplayArray[i][5].equals("")){ 
				out.print("<span>");	 
				if(!contentDisplayArray[i][4].equals(""))
					//out.print(contentDisplayArray[i][4]);	 
				if(!contentDisplayArray[i][4].equals("") && !contentDisplayArray[i][5].equals(""))
					//out.print(", ");	 
				
				 if(!contentDisplayArray[i][10].equals("")&& !contentDisplayArray[i][10].equals("0")){
					//out.print("<span><font color=\"#FF0000\" SIZE=\"2\">Edition:</font></span><a href=\""+Constants.SITE_URL+"calendar/"+contentDisplayArray[i][10]+"/"+contentDisplayArray[i][11]+"/magazine.html\" target=\"_blank\">"+contentDisplayArray[i][12]+"</a>");
					}else{
					//if(!contentDisplayArray[i][5].equals(""))
					//out.print(contentDisplayArray[i][5]);
					}
				out.print("</span><br/>");	 
			}
		out.print("</div>"); 
		}
		out.print("<div class=\"searchticker\">");
		if(searchType.equals("photo")) {
			if(!contentDisplayArray[i][1].equals("null")) { //out.print(contentDisplayArray[i][1]);
			 } 
		} else {
			if(!contentDisplayArray[i][8].equals("null")) { //out.print(contentDisplayArray[i][8]); 
			} 
		}
		out.print("</div><div class=\"clear\"></div>");
		out.print("</div>");
		if (i % 3 == 2) 
					out.print("</div></div>");
	}if(contentDisplayArray.length%3 !=0) {
					for (int a1 = (contentDisplayArray.length % 3); a1 < 3; a1++) {
						if (a1 % 3 < 2) 
							out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
						if (a1 % 3 == 2) 
							out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
					}
						out.print("</div></div>");
				}
}else { out.print("<div style=\"clear:both;\"></div>");
	for(int i=0;i<contentDisplayArray.length;i++) { 
		if (i % 3 ==0) { out.print("<div class='search-row'><div class='search-line'>");		}
		if (i % 3 < 2) { 	out.print("<div class=\"searchdotline\">");}
		if (i % 3 == 2) {out.print("<div class=\"searchdotline search-last-col\">");}
		if(!contentDisplayArray[i][6].equals("")) {%>
		<a href="<%=contentDisplayArray[i][9]%>"><div class="simgrepeat">
        <img src="<%//=Constants.KICKER_IMG_PATH+contentDisplayArray[i][6]%>"  title="<%=contentDisplayArray[i][7]%>" alt="<%=contentDisplayArray[i][7]%>" width="179" height="133"/>
        <span class="media-story-icon" ></span></div></a>
	<%}else{%>		
		<div class="simgrepeat"><img src="http://media2.intoday.in/indiatoday/images/it-top-nav-logo.png" alt="" title="" border="0" width="179" height="133"> </div>
		<%}%>
		<div class="serchheadlien"><a href="<%=contentDisplayArray[i][9]%>" target="_blank"><%=contentDisplayArray[i][1]%></a></div>
<%		if((byline==1 && !contentDisplayArray[i][3].equals("")) || !contentDisplayArray[i][4].equals("") || !contentDisplayArray[i][5].equals("")){ 
			out.print("<div class=\"searchtime\">"); 
			if(byline==1 && !contentDisplayArray[i][3].equals("")){ 
				out.print("<span><font color=\"#FF0000\" SIZE=\"2\"> "+contentDisplayArray[i][3]+"</font></span><br/>"); 
			} 
			if(!contentDisplayArray[i][4].equals("") || !contentDisplayArray[i][5].equals("")){ 
				out.print("<span>");	 
				if(!contentDisplayArray[i][4].equals(""))
					//out.print(contentDisplayArray[i][4]);	 
				if(!contentDisplayArray[i][4].equals("") && !contentDisplayArray[i][5].equals(""))
					//out.print(", ");	 
				//out.println("@@@@@@@@@@@@@@--->"+contentDisplayArray[i][11]);
				 if(!contentDisplayArray[i][10].equals("")&& !contentDisplayArray[i][10].equals("0")){
					//out.print("<span><font color=\"#FF0000\" SIZE=\"2\">Edition:</font></span><a href=\""+Constants.SITE_URL+"calendar/"+contentDisplayArray[i][10]+"/"+contentDisplayArray[i][11]+"/magazine.html\" target=\"_blank\">"+contentDisplayArray[i][12]+"</a>");
					}else{
					//if(!contentDisplayArray[i][5].equals(""))
					//out.print(contentDisplayArray[i][5]);
					}
				out.print("</span><br/>");	 
			}
		out.print("</div>"); 
		}
		out.print("<div class=\"searchticker\">");
		if(searchType.equals("photo")) {
			if(!contentDisplayArray[i][1].equals("null")) { 
			//out.print(contentDisplayArray[i][1]); 
			} 
		} else {
			if(!contentDisplayArray[i][8].equals("null")) { 
			//out.print(contentDisplayArray[i][8]); 
			} 
		}
		out.print("</div><div class=\"clear\"></div>");
		out.print("</div>");
		if (i % 3 == 2) 
					out.print("</div></div>");
	}if(contentDisplayArray.length%3 !=0) {
					for (int a1 = (contentDisplayArray.length % 3); a1 < 3; a1++) {
						if (a1 % 3 < 2) 
							out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
						if (a1 % 3 == 2) 
							out.print("<div class=\"searchdotline search-last-col\"><div class='serchheadlien'></div><div class='searchtime'></div><div class='searchticker'></div><div class='clear'></div></div>");
					}
						out.print("</div></div>");
				}
	
	 }}
if ( totalSearchResults ==0) {
	//out.print("<div class=\"searchcontbox\"><div class=\"searchtextbot\">Total 0 results found. Search for ["+searchText+"]</div>");
		out.print("<div class=\"searchtextbot\">Total 0 results found. Search for ["+searchText+"]</div>");

}%></div><div class="pagination"><ul><%
	if(currentPageNo>1)
		out.println("<li><a href=\""+searchURL+"&page=1\"><<</a></li>"); 

	int nextPageNo = (((currentPageNo % displayPaginationCount) ==0 ? (currentPageNo / displayPaginationCount) : (currentPageNo / displayPaginationCount)+1) * displayPaginationCount) + 1;
	int previousPageNo = (((currentPageNo % displayPaginationCount) !=0 ? (currentPageNo / displayPaginationCount)-1 : (currentPageNo / displayPaginationCount)-2) * displayPaginationCount)+1;
	int dispPageCountFrom = (((currentPageNo % displayPaginationCount) !=0 ? (currentPageNo / displayPaginationCount) : (currentPageNo / displayPaginationCount)-1) * displayPaginationCount)+1;

	if(currentPageNo > displayPaginationCount)
		out.println("<li><a href=\""+searchURL+"&page="+previousPageNo+"\">< Previous</a></li>"); 

	if(lastPageNo>1) {			
		for(int pageNo=dispPageCountFrom; pageNo<dispPageCountFrom+displayPaginationCount; pageNo++) {
			if(pageNo==currentPageNo)
				out.println("<li><a href=\""+searchURL+"&page="+pageNo+"\" class='currentpage'>"+pageNo+"</a></li>"); 
			else if (pageNo<=lastPageNo && pageNo!=currentPageNo)
				out.println("<li><a href=\""+searchURL+"&page="+pageNo+"\" class='prevnext'>"+pageNo+"</a></li>"); 
		}
	}
	if(nextPageNo <= lastPageNo)
		out.println("<li><a href=\""+searchURL+"&page="+nextPageNo+"\">Next ></a></li>"); 

	if(currentPageNo<lastPageNo)
		out.println("<li><a href=\""+searchURL+"&page="+lastPageNo+"\">>></a></li>"); 
%></ul></div></div>

<div class="searchtextbot">Not happy with the above results? Try doing an <span>advanced search</span>.</div>
<div class="bottomsearchbox">
	<table cellpadding="0" cellspacing="0" class="search-table">
    	<tr><td width="640" height="40" align="center" valign="middle" bgcolor="#FFFFFF" class="topsearcborxx" style="font-size:20px">ADVANCE SEARCH PANEL</td>
        <td width="6" class="topsearcbordsxx">&nbsp;</td>
        <td width="5"  height="40" align="center" valign="middle" class="topsearcbordsxx"> <div class="searchboxgrey" style="display:none;"><a href="archivesearch.jsp?searchWord=<%=searchText%>" target="_blank"> SEARCH ARCHIVE </a><br /><span class="foreditions">For editions before August 2007</span></div></td>
        </tr></table>
	<div class="searchcontboxxx">
		<form action="<%=MegacriticCommonConstants.SITE_URL%>jsp/search/advanced_search.jsp" name="searchform" method="get" id="searchform" onSubmit="return serchpagevalidate();">
		<input name="advsearch" value="1" type="hidden">	

		<table border="0" align="center" cellpadding="0" cellspacing="0" >
			<tr><td width="112" class="searchcoltxt">Search Keyword</td><td width="10" class="searchcoltxt">:</td><td colspan="5">
			<%if(searchText==null || searchText.equals("") || searchText.equals("null")){ %>
				<input name="searchtext" id="mod_search_searchword" alt="search" size="20" value="Search..." onBlur="if(this.value=='') this.value='Search...';" onFocus="if(this.value=='Search...') this.value='';" maxlength="40" style="background-image: url('/megacritic/images/txtboxs.gif'); background-repeat: no-repeat; width:248px; padding-left: 6px; margin-top: 1px; height: 24px; border: 0px none; font: 12px Tahoma; color: rgb(149, 149, 149);" type="text"/>
			<%}else{ %>
				<input name="searchtext" id="mod_search_searchword" alt="search" size="20" value="<%=searchText %>" onBlur="if(this.value=='') this.value='Search...';" onFocus="if(this.value=='Search...') this.value='';" maxlength="40" style="background-image: url('images/txtboxs.gif'); background-repeat: no-repeat; width:248px; padding-left: 6px; margin-top: 1px; height: 24px; border: 0px none; font: 12px Tahoma; color: rgb(149, 149, 149);" type="text"/>
			<%} %>      
			</td><td width="13">&nbsp;</td>
			  <td width="23"><input name="byline" value="1" <%if(byline==1) { out.print("checked=\"checked\"");}%> type="radio" /></td>
			  <td width="83" class="formtxt">By Author</td>
			  <td width="14">&nbsp;</td>
			  <td width="20"><input name="byline" value="0" <%if(byline==0) { out.print("checked=\"checked\"");}%> type="radio" /></td>
			  <td width="99" class="formtxt">By Article</td>
		</tr>
		<tr><td height="20" colspan="13"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td width="34"><input  name="searchphrase" id="searchphraseany" value="any" type="radio" <%if(searchPhrase.equals("any")) { out.print("checked=\"checked\"");}%>/></td><td width="77" class="formtxt">Any Words</td><td width="25">&nbsp;</td>
      <td width="29"><input name="searchphrase" id="searchphraseall" value="all" <%if(searchPhrase.equals("all")) { out.print("checked=\"checked\"");}%> type="radio" /></td><td width="91" class="formtxt">All words</td><td>&nbsp;</td>
      <td><input name="searchphrase" id="searchphraseexact" value="exact" type="radio" <%if(searchPhrase.equals("exact")) { out.print("checked=\"checked\"");}%>/></td><td colspan="4" class="formtxt">Exact phrase</td>
    </tr>
    <tr>
      <td height="20" colspan="13"></td>
    </tr>
    <tr>
      <td>&nbsp;</td><td>&nbsp;</td>      
      <td><input name="searchtype" id="video" value="video" type="radio" <%if(searchType.equals("video")) { out.print("checked=\"checked\"");}%>/></td><td class="formtxt">Video search</td><td>&nbsp;</td>
      <td><input name="searchtype" id="text" value="story" type="radio" <%if(searchType.equals("story")) { out.print("checked=\"checked\"");}%>/></td><td class="formtxt">Article search</td><td>&nbsp;</td>
      <td><input name="searchtype" id="photo" value="photo" type="radio" <%if(searchType.equals("photo")) { out.print("checked=\"checked\"");}%>/></td><td colspan="4" class="formtxt">Photo search</td>     
    </tr>
    <tr>
      <td height="20" colspan="13"></td>
    </tr>
    <tr>
      <td class="searchcoltxt">Date</td>
      <td class="searchcoltxt">:</td>
      <td colspan="5"><div class="formtxt" style="float:left; margin-right:5px; margin-top:3px;">From</div>
          <div style="float: left; width:121px;">
            <%if(startDate==null||startDate.equals("")||startDate.equals("null")){ %>
            <input name="startdate" id="fromdate" alt="search" size="20" value=""  maxlength="40" style="background-image: url('/megacritic/images/calbox.gif'); background-repeat: no-repeat; width:121px; padding-left: 6px; margin-top: 1px; height: 24px; border: 0px none; font: 12px Tahoma; color: rgb(149, 149, 149);" type="text"/>
            <%}else{ %>
            <input name="startdate" id="fromdate" alt="search" size="20" value='<%=startDate %>' maxlength="40" style="background-image: url('/megacritic/images/calbox.gif'); background-repeat: no-repeat; width:121px; padding-left: 6px; margin-top: 1px; height: 24px; border: 0px none; font: 12px Tahoma; color: rgb(149, 149, 149);" type="text"/>
            <%} %>
          </div>
        <div style="float: left; margin-top: 0px; ">
			<img src="/megacritic/images/calimg.gif" onClick="return showCalendar('fromdate', 'y-mm-dd');"  class="sbutton" value="Go" type="image" border="0" style="margin:1px 0 0 0; _margin:2px 0 0 -1px" />
        </div></td>
      <td valign="top"><div class="formtxt" style="margin-top:3px;">To</div></td>
      <td colspan="5"><div style="float: left; width:121px; margin-left:5px;">
          <%if(endDate==null||endDate.equals("")||endDate.equals("null")){ %>
          <input name="enddate" id="todate" alt="search" size="20" value=""  maxlength="40" style="background-image: url('/megacritic/images/calbox.gif'); background-repeat: no-repeat; width:121px; padding-left: 6px; margin-top: 1px; height: 24px; border: 0px none; font: 12px Tahoma; color: rgb(149, 149, 149);" type="text"/>
          <%}else{ %>
          <input name="enddate" id="todate" alt="search" size="20" value='<%=endDate %>'  maxlength="40" style="background-image: url('/megacritic/images/calbox.gif'); background-repeat: no-repeat; width:121px; padding-left: 6px; margin-top: 1px; height: 24px; border: 0px none; font: 12px Tahoma; color: rgb(149, 149, 149);" type="text"/>
          <%} %>
        </div>
          <div style="float: left; margin-top: 0px;">
			<img src="/megacritic/images/calimg.gif" onClick="return showCalendar('todate', 'y-mm-dd');"  class="sbutton" value="Go" type="image" border="0" style="margin:1px 0 0 0; _margin:2px 0 0 -1px" />
          </div>
        <div style="float:left; margin-left:3px; margin-top:5px; font:normal 11px tahoma; color:#959595">(yyyy-mm-dd)</div></td>
    </tr>
    <tr>
      <td height="20" colspan="13"></td>
    </tr>
    <tr>
      <td height="20" colspan="13"></td>
    </tr>
    <tr>
      <td colspan="13" align="center" valign="middle"><input type="image" src="/megacritic/images/searcbutt.jpg" /></td>
    </tr>
  </table>
</FORM>
</div>
</div>
</div>

<div class="strwapper">
<div id="rightpanel">

<s:include value="/jsp/home/rightNavigationSearch.jsp"></s:include>  
      

<%//@include file="navigation_rightnav_2015.jsp"%>
</div>
</div>
</div>
<div class="clear"></div></div>
<div class="centerdiv">
<%//@include file="navigation_footernav_2015.jsp"%>


 </div>
 <s:include value="/jsp/common/footer.jsp"></s:include>
<%}%>


</body>
</html>
<%!
public class MyStringArrayComparator implements Comparator<SearchBean> {

    public int compare(SearchBean e1, SearchBean e2) {
    Date date1 = null;
    Date date2 = null;
    SimpleDateFormat sdf = new SimpleDateFormat("MMMM d, yyyy");
    try{
    //System.out.println("@@@@@@@@@@@@@"+e1.getPublishDate());
   // System.out.println("@@@@@@@@@@@@@"+e2.getPublishDate());
    if(e1.getPublishDate()!=null && !e1.getPublishDate().equals("")&& !e1.getPublishDate().equals("null")){
    date1 = sdf.parse(e1.getPublishDate());
    }else{
    date1=new Date();
    }
     if(e2.getPublishDate()!=null && !e2.getPublishDate().equals("")&& !e1.getPublishDate().equals("null")){
    date2 = sdf.parse(e2.getPublishDate());
    }else{
     date2=new Date();
    }
       }catch(Exception e){
        
        } 	
    if(date1.compareTo(date2)<0){
            return 1;
        } else {
            return -1;
        }
        
    }
}
%>

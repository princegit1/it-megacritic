<%@page language="java"  pageEncoding="ISO-8859-1" import="com.indiatoday.megacritic.utils.Dbconnection,com.indiatoday.megacritic.utils.MegacriticCommonConstants,java.sql.Connection,java.sql.PreparedStatement,com.indiatoday.megacritic.utils.Dbconnection"%>
<%
Connection connection = null;
PreparedStatement statementInsert = null;
Dbconnection connect = null;
String insertQuery=null;
int insert=0;
String datadisplay="";
int upcount=0;
int downcount=0;
int totalcount=0;
int content_id=Integer.parseInt(request.getParameter("content_id")!=null ? request.getParameter("content_id") :"0");
int action=Integer.parseInt(request.getParameter("action")!=null ? request.getParameter("action") :"0");
String content_type=request.getParameter("content_type");
String sessionId = "";
sessionId = content_type+content_id;
System.out.println("sessionId->"+sessionId);
String LikeDislikeStr = MegacriticCommonConstants.LikeDislike(content_id,content_type);
String[] temp;
String delimiter = "-";
temp = LikeDislikeStr.split(delimiter);
upcount=Integer.parseInt(temp[0]);
downcount=Integer.parseInt(temp[1]);
totalcount=Integer.parseInt(temp[2]);
String sessionContentId = "";
if(session.getAttribute("ArticleId")!=null)
sessionContentId = (String)session.getAttribute("ArticleId");
if( sessionContentId.indexOf(sessionId) < 0)
{
	try {
		connect = Dbconnection.getInstance();
		connection = connect.getConnection();
		if (totalcount==0 && action==1 )
		{
			upcount= upcount+1;
			insertQuery="insert into jos_content_rating(content_id, rating_sum,content_type,website) values(?,1,?,?)";
			statementInsert = connection.prepareStatement(insertQuery);
			statementInsert.setInt(1,content_id);
			statementInsert.setString(2,content_type);
			statementInsert.setString(3,"megacritic");
			insert=statementInsert.executeUpdate();
		} else if (totalcount==0 && action==2 ) {
			downcount= downcount+1;
			insertQuery="insert into jos_content_rating(content_id, rating_count,content_type,website) values(?,1,?,?)";
			statementInsert = connection.prepareStatement(insertQuery);
			statementInsert.setInt(1,content_id);
			statementInsert.setString(2,content_type);
			statementInsert.setString(3,"megacritic");
			insert=statementInsert.executeUpdate();
		} else if(totalcount>0 && action==1) {
			upcount= upcount+1;
			insertQuery="UPDATE jos_content_rating SET rating_sum=? WHERE content_id=? and content_type=?";
			//System.out.println("dinesh-----"+insertQuery);
			statementInsert = connection.prepareStatement(insertQuery);
			statementInsert.setInt(1,upcount);
			statementInsert.setInt(2,content_id);
			statementInsert.setString(3,content_type);
			insert=statementInsert.executeUpdate();
		} else if(totalcount>0 && action==2) {
			downcount= downcount+1;
			insertQuery="UPDATE jos_content_rating SET rating_count=? WHERE content_id=? and content_type=?";
			//System.out.println("dinesh-----"+insertQuery);
			statementInsert = connection.prepareStatement(insertQuery);
			statementInsert.setInt(1,downcount);
			statementInsert.setInt(2,content_id);
			statementInsert.setString(3,content_type);
			insert=statementInsert.executeUpdate();
		}
	} catch(Exception e) {
		System.out.println("Story Like-dislike Exception is :" + e);
	} finally {
		if(statementInsert!=null)
			statementInsert.close();
		if(connection!=null)
			connection.close();
	}
	if (insert==1)
	{
		datadisplay=upcount+"|"+downcount+"|"+"Thanks for voting!|"+content_id+"|"+content_type;
		if(session.getAttribute("ArticleId")==null) {
			session.setAttribute("ArticleId",sessionId);
		} else {
			String tempArticleId = session.getAttribute("ArticleId") + ", " + sessionId;
			session.setAttribute("ArticleId",tempArticleId);
		}
	    response.setContentType("text/html");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().write(""+datadisplay.trim()+"");
	}
} else {
	datadisplay=upcount+"|"+downcount+"|"+"You have already voted!|"+content_id+"|"+content_type;
	    response.setContentType("text/html");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().write(""+datadisplay.trim()+"");
}
%> 

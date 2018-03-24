<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%@page import="com.indiatoday.megacritic.utils.MegacriticCommonConstants"%>
<head> 
 <%--<script src='http://ittemp.intoday.in/megacritic/js/jquery.js' type="text/javascript"></script> --%>
	<script src='<%=MegacriticCommonConstants.SITE_URL%>megacritic/js/jquery.MetaData.js' type="text/javascript" language="javascript"></script>
   <script src='<%=MegacriticCommonConstants.SITE_URL%>megacritic/js/jquery.rating.js' type="text/javascript" language="javascript"></script>
   <link href='<%=MegacriticCommonConstants.SITE_URL%>megacritic/css/jquery.rating.css' type="text/css" rel="stylesheet"/>
</head>

<body>
<div class="Clear" id="wrap">
 <div class="Clear" id="body">
  <div class="Clear" id="documentation">
   <div class="tabs">
  <div id="tab-Testing">
 <script>
$(function(){
$( ".rating-cancel" ).remove();
 $('a').click(function(){
	 var ab= $(this).attr("title"); 
	 $('#userrating').val(ab);
	
 });
});
</script>
<script>
$(function(){
 $('.hover-star').rating({
  focus: function(value, link){
    var tip = $('#hover-test');
    tip[0].data = tip[0].data || tip.html();
    tip.html(link.title || 'value: '+value);
  },
  blur: function(value, link){
    var tip = $('#hover-test');
    $('#hover-test').html(tip[0].data || '');
   
  }
 });
});
</script>
 Your Rating : 
<form id="form4">
    <div class="Clear">
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="0.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="1.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="1.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="2.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="2.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="3.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="3.5" checked="checked" />
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="4.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="4.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="5.0"/>
    </div>
     <div class="test Smaller">
   </div>
  
</form>
<!-- <input  type="text" name="userrating" id="userrating" /> -->
   </div> 
   </div>
  </div>
 </div>
</div>
</body>
</html>

<script src="http://media2.intoday.in/indiatoday/js/jquery.min.1.8.2.js" type="text/javascript"></script>
<style>
.fb_like_b {
	background: none repeat scroll 0 0 #fff;
	border: 1px solid #ccc;
	float: left;
	width: 298px;
	position: relative;
	top:110px;
	height:135px;
}
.fb_like_b .fb_like_hd {
	float: left;
	margin-top: -12px;
	width: 100%;
}
.fb_like_b .fb_like_btn {
	float: left;
	margin: 13px 0;
	width: 100%;
}
.fb_like_b .fb_like_hd_left {
	color: #5c5c5c;
	float: left;
	width: 96px;
	position: absolute;
	top: 87px;
	left: 49px;
	height: 40px;
	overflow:hidden;
}
.fb_like_b .fb_like_hd_right {
  float: right;
  margin-top: 22px;
  width: 235px;
  font-family: Roboto;
  font-size: 19px;
}

.fb_like_b .fb_like_hd_left {
	color: #5c5c5c;
}
.fb_like_b .fb_like_hd_right p {
	font-size: 17px;
}
.fb_like_b .fb_like_hd_right p.fb_h {
	color: #2a40a6;
	font-size: 16px;
	margin-top: 10px;
	font-family:Roboto;
}
.fb_like_b .fb_like_hd_right p.fb_h span {
	font-weight: bold;
}
.fb_like_b .fb_like_btn {
	float: left;
	margin: 13px 0;
	width: 100%;
	height:60px!Important;

}
.fb_like_b .fb_like_btn_left {
	float: left;
	margin-left: 8px;
	margin-right: 11px;
	width: 98px;
}
.fb_like_b .fb_like_btn_right {
 	float: right;
    height: 114px;
    margin-top: 2px;
    overflow: hidden;
    width: 178px;
}
a {
	text-decoration: none;
}
ul {
	list-style: outside none none;
}
.fb_like_b .fb_like_btn_right li {
	float: left;
	margin-right: 5px;
	width: 35px;
}

.like-us {position: absolute;left: 3px;top: -10px;}

</style>
 
 
 
 
 
<div class="fb_like_b">
  <div class="fb_like_hd">
  
        <div class="like-us"><img src="http://media2.intoday.in/microsites/movies/images/like-us.jpg"  width="62" height="72" /></div>
    <div class="fb_like_hd_left"> 
    
    
      <iframe src="http://www.facebook.com/plugins/like.php?
app_id=287880144665857&amp;href=https://www.facebook.com/pages/India-Today-Showbiz/1456461291311660&amp;send=false
&amp;layout=button&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=40" scrolling="no" frameborder="0"  allowTransparency=
"true" data-width="100"></iframe>
    </div>
    <div class="fb_like_hd_right"> <span id="fb-likes-count"></span>Likes
      <p class="fb_h">Like us on <span>FACEBOOK</span></p>
    </div>
  </div>
  <div class="fb_like_btn">
    <div class="fb_like_btn_left"><a href="#"><img alt="fb" src="http://media2.intoday.in/indiatoday/megacritic/images/fb_like.png"></a></div>
    <div class="fb_like_btn_right">
      <iframe width="180" height="176" style="margin-top: -124px;" frameborder="0" src="https://www.facebook.com/plugins/fan.php?connections=4&height=0&id=1456461291311660&locale=en_US&stream=false&width=300&show_faces=false&colorscheme=light&stream=false&border_color=false&header=false" id="inneriframe"></iframe>
    </div>
  </div>
</div>
<script>
 jQuery(document).ready(function() {
    // Fetch Facebook Likes once and every 30 seconds thereafter
    // Adjust setInterval to either fetch content in different frequency or remove to only fetch once.
    realtime_fb_likes();
    setInterval("realtime_fb_likes()", 30000);
  });
 
  // Fetch FB Likes
  // Replace "Starbucks" with your Facebook Profile/Page ID, or full external website address.
  // Get FB ID here:  http://graph.facebook.com/your_page_name
  function realtime_fb_likes() {
    $.getJSON('http://graph.facebook.com/1456461291311660', function(data) {
      var fb_likes = addCommas(data.likes);
      $('#fb-likes-count').text(fb_likes);
    });
  }
 
  // Pretty number format to add commas between numbers
  // Source: http://www.mredkj.com/javascript/nfbasic.html
  function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
      x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
  }
</script>    

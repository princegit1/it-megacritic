<!--
<div class="fb_like_hd">
        <div class="fb_like_hd_left">
        
<img src="http://media2.intoday.in/microsites/movies/images/like-us.jpg"  width="62" height="72" />

    
    
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
</div>-->


<div class="fb_like_b">
        <div class="fb_like_hd">
        <div class="fb_like_hd_left">
        <img alt="img" src="http://media2.intoday.in/indiatoday/megacritic/images/like_fb.png">
        </div>
        <div class="fb_like_hd_right"><span id="fb-likes-count"></span>
        <p> likes MegaCritic</p>
        <p class="fb_h">Follow us at <span>FACEBOOK</span></p>
        </div>
        
        
        </div>
        
        <div class="fb_like_btn">
       <!-- <div class="fb_like_btn_left"><a href="#"><img alt="fb" src="http://media2.intoday.in/indiatoday/megacritic/images/fb_like.png"></a></div>-->
        <div class="fb_like_btn_right">
       <iframe class="fb_like_btn_r" frameborder="0" src="https://www.facebook.com/plugins/fan.php?connections=4&height=0&id=1456461291311660&locale=en_US&stream=false&width=300&show_faces=false&colorscheme=light&stream=false&border_color=false&header=false" id="inneriframe"></iframe>
        </div>
        </div>
        </div>
        
        
        <div class="tw_follow_box">
         
         <div class="follow_btn_tw"><span>Follow on twitter</span> @megacritic</div>
         <div class="tw_des_cont"><span>1</span> Followers</div>
         <div class="list_ul_tw">
         <ul>
        <li><a href="#"><img src="http://media2.intoday.in/indiatoday/megacritic/images/fb_box_img.jpg" alt="img" /></a></li>
        
        </ul>
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

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function nights() {
var ONE_DAY = 1000 * 60 * 60 * 24;
from=new Date($("booking_houses_bookings__start_at").value.gsub("-","/"));
to=new Date($("booking_houses_bookings__end_at").value.gsub("-","/"));
nights=parseInt(to-from)/ONE_DAY;
if (isNaN(nights) || nights<1) {
$("booking_nights").value='';
}else{ $("booking_nights").value=nights;
$("booking_price").value='';
}}
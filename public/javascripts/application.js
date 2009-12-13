// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function nights() {
var ONE_DAY = 1000 * 60 * 60 * 24;
var from=new Date($("booking_houses_bookings__start_at").value.gsub("-","/"));
var to=new Date($("booking_houses_bookings__end_at").value.gsub("-","/"));
var nights=parseInt(to-from)/ONE_DAY;
if (isNaN(nights)) {
$("booking_nights").value='0';
}else{
$("booking_nights").value=nights;
$("booking_price").value='';
}}
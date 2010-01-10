// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function nights() {
var ONE_DAY = 1000 * 60 * 60 * 24;
var from=new Date($F("booking_houses_booking_start_at").gsub("-","/"));
var to=new Date($F("booking_houses_booking_end_at").gsub("-","/"));
var nights=parseInt(to-from)/ONE_DAY;
if (isNaN(nights)) {
$("booking_nights").value='0';
}else{
$("booking_nights").value=nights;
$$("#houses_bookings .price").invoke('update','');
}}

function root_init() {
var h = new Carousel('carousel',$$('#carousel .slide'), false, {auto: true, visibleSlides: 5, circular: true });
}
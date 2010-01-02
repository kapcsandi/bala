// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function nights() {
var ONE_DAY = 1000 * 60 * 60 * 24;
var from=new Date($F("booking_houses_bookings__start_at").gsub("-","/"));
var to=new Date($F("booking_houses_bookings__end_at").gsub("-","/"));
var nights=parseInt(to-from)/ONE_DAY;
if (isNaN(nights)) {
$("booking_nights").value='0';
}else{
$("booking_nights").value=nights;
$("booking_price").value='';
}}

function root_init() {
var h = new UI.Carousel("horizontal_carousel");
var items = 5;
var direction = 1;
var hMax = $("horizontal_carousel").getElementsByTagName('li').length-items;

function startScroll() {
    var i;
    new PeriodicalExecuter(function(pe) {
        i = h.currentIndex();
        if (direction == 1) {
            if ((i+items) >= hMax) {
                h.scrollTo(hMax);
                direction = 2;
            } else {
                h.scrollTo(i+items);
            }
        } else {
            if ((i-items) <= 0) {
                h.scrollTo(0);
                direction = 1;
            } else {
                h.scrollTo(i-items);
            }
        }
    }, 5);
}

startScroll();
}
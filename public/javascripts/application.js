// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function nights(field) {
  var ONE_DAY = 1000 * 60 * 60 * 24;
  var format = Date.short_date_format;
  var to, from, nights;
  var picked_date = new Date.parseExact(field.value,format);
  if (field.id == 'booking_houses_booking_start_at') {
    from=picked_date;
    to=new Date.parseExact($F("booking_houses_booking_end_at"),format);
    if ( ($F("booking_houses_booking_end_at") == '') || (from.isAfter(to))) {
      to=picked_date.addWeeks(1);
      nights=7;
      $("booking_houses_booking_end_at").value=to.toString(format);
    }
  } else {
    to=picked_date;
    from=new Date.parseExact($F("booking_houses_booking_start_at"),format);
    if ( ($F("booking_houses_booking_start_at") == '') || (from.isAfter(to))) {
      from=picked_date.addWeeks(-1);
      nights=7;
      $("booking_houses_booking_start_at").value=from.toString(format);
    }
  }
  if (isNaN(nights)) {
    nights=parseInt((to-from)/ONE_DAY);
  }
  $("booking_nights").value=nights;
  $$("#houses_bookings .price").invoke('update','');
}

function root_init() {
new Carousel('carousel',$$('#carousel .slide'), false, {auto: true, visibleSlides: 5, circular: true });
}
$(document).on('turbolinks:load', function() {
  var $startYear = $("#event_start_time_1i");
  var $startMonth = $("#event_start_time_2i");
  var $startDay = $("#event_start_time_3i");
  var $startHour = $("#event_start_time_4i");
  var $startMinute = $("#event_start_time_5i");
  var $endYear = $("#event_end_time_1i");
  var $endMonth = $("#event_end_time_2i");
  var $endDay = $("#event_end_time_3i");
  var $endHour = $("#event_end_time_4i");
  var $endMinute = $("#event_end_time_5i");

  $("body").on("change", ".event_form select", function(e) {
    if ($startYear.val() > $endYear.val()) {
      $endYear.val($startYear.val());
    }

    if ($startYear.val() === $endYear.val()) {
      if ($startMonth.val() > $endMonth.val()) {
        $endMonth.val($startMonth.val());
      } else if ($startMonth.val() === $endMonth.val()) {
        if ($startDay.val() > $endDay.val()) {
          $endDay.val($startDay.val());
        } else if ($startDay.val() === $endDay.val()) {
          if ($startHour.val() > $endHour.val()) {
            $endHour.val($startHour.val());
          } else if ($startHour.val() === $endHour.val()) {
            if ($startMinute.val() > $endMinute.val()) {
              $endMinute.val($startMinute.val());
            }
          }
        }
      }
    }
  });

  if ($(".trigger_contacts").length > 0) {
    var $navItemElement =$(".navbar_contacts");
    highlightNavItem($navItemElement);
  } else if ($(".trigger_notes").length > 0) {
    var $navItemElement =$(".navbar_notes");
    highlightNavItem($navItemElement);
  } else if ($(".trigger_events").length > 0) {
    var $navItemElement =$(".navbar_events");
    highlightNavItem($navItemElement);
  } else if ($(".trigger_todos").length > 0) {
    var $navItemElement =$(".navbar_todos");
    highlightNavItem($navItemElement);
  }
});

function highlightNavItem($navItemElement) {
  $(".navbar-nav li").removeClass("navbar_item_active");
  $navItemElement.addClass("navbar_item_active");
}

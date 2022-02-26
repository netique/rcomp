var bumpIt = function () {
    $("body").css("margin-bottom", $(".footer").height() + 30);
  },
  didResize = true;

bumpIt();

$(window).resize(function () {
  didResize = true;
});
setInterval(function () {
  if (didResize) {
    didResize = false;
    bumpIt();
  }
}, 250);

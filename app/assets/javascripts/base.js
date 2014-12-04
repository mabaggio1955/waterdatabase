$(document).ready(function() {
  $(".content-list > li").each(function( index ) {
    shortenContentList($(this), 140);
  });
});

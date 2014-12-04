function shortenContentList(obj) {
  var $text = $(obj).find("p").html();
  var $ret = shortenText($text,140);
  $(obj).find("p").html($ret);
}

function shortenText(text,maxLength) {
  if (text.length > maxLength) {
    text = text.substr(0,maxLength-3) + "...";

    return text;
  }
}
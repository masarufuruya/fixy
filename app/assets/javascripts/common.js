var commonJs = (function() {
  function br(str) {
    return str.replace(/\r?\n/g, '<br>');
  }

  return {
    br: br
  }
})();

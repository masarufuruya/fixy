$(document).ready(function() {
  $('memo__count').on('click', function() {
    $.ajax({
      url: '/habits/'+habitId+'/memos',
      type: 'GET',
      dataType: 'json',
    }).done(function(data, status, xhr) {
      console.log(data);
    }).fail(function(xhr, status, error) {
      console.log(error);
    });
  });
});

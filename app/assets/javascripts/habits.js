$(document).ready(function() {
  $('.memo__count').on('click', function() {
    var habitId = $(this).data('habit-id');
    $.ajax({
      url: '/habits/'+habitId+'/memos',
      type: 'GET',
      dataType: 'json',
    }).done(function(data, status, xhr) {
      var $memoList = $('.memo__list');
      $memoList.empty();
      $.each(data.memos, function(i, memo) {
        var createdAt = moment(memo.created_at).format("MM月DD日 H:m:s");
        $memoList.append('<p style="font-size:12px;color:#888;margin-bottom:0;">'+createdAt+'</p>');
        $memoList.append('<li style="list-style:none;font-size:14px;padding: 10px 0;">'+commonJs.br(memo.body)+'</li>');
      });
      $('#memoListModal').modal('show');
    }).fail(function(xhr, status, error) {
      console.log(error);
    });
    return false;
  });
  $('input[type="text"]').keypress(function(e) {
    if ((e.which == 13) || (e.keyCode == 13)) { return false; }
  });
});

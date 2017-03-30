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
        var createdAt = moment(memo.created_at).format("YYYY-MM-DD")
        $memoList.append('<li>'+createdAt+': '+memo.body+'</li>');
      });
      $('#memoListModal').modal('show');
    }).fail(function(xhr, status, error) {
      console.log(error);
    });
    return false;
  });
});

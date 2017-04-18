$(document).ready(function() {
  function updateAchivement(habitId, achivementId, checked) {
    $.ajax({
        url: '/habits/'+habitId+'/achivements/'+achivementId,
        type: 'PATCH',
        dataType: 'json',
        data: {
          achivement: {
            checked: checked,
          }
        }
    }).done(function(data, status, xhr) {
      console.log(data);
    }).fail(function(xhr, status, error) {
      console.log(error);
    });
  }
  function fetchMemo(habitId, achivementId, callback) {
    $.ajax({
        url: '/habits/'+habitId+'/achivements/'+achivementId+'/memo',
        type: 'GET',
        dataType: 'json',
    }).done(function(data, status, xhr) {
      return callback(data);
    }).fail(function(xhr, status, error) {
      return callback(error);
    });
  }
  function saveMemo(habitId, achivementId, memoId, entryBody) {
    var requestUrl = '/habits/'+habitId+'/achivements/'+achivementId+'/memos',
      requestType = 'POST';
    if (memoId) {
      requestUrl += '/'+memoId;
      requestType = 'PATCH';
    }
    $.ajax({
        url: requestUrl,
        type: requestType,
        dataType: 'json',
        data: {
          memo: {
            body: entryBody
          }
        }
    }).done(function(data, status, xhr) {
      var $targetCheckbox = $('.habit').find('input[data-id='+data.achivement_id+']')
      $targetCheckbox.attr('data-memo-id', data.id);
    }).fail(function(xhr, status, error) {
      console.log(error);
    }).always(function() {
      $('.modal').modal('hide')
    });
  }
  $('.habit-check').on('change', function() {
    var achivementId = $(this).data('id'),
      habitId = $(this).data('habit-id'),
      checked = false;
    if ($(this).is(':checked')) {
      checked = true;
      $(this).parents('.habit').find('span:eq(1)').addClass('habit__checked');
    } else {
      checked = false;
      $(this).parents('.habit').find('span:eq(1)').removeClass('habit__checked');
    }
    updateAchivement(habitId, achivementId, checked)
  });
  $('#memoListModal').on('show.bs.modal', function (e) {
    var $modalBody = $('.modal-body').find('textarea'),
      habitId = $modalBody.attr('data-habit-id'),
      achivementId = $modalBody.attr('data-achivement-id');
    fetchMemo(habitId, achivementId, function(memo) {
      $modalBody.val(memo.body);
      $modalBody.focus();
    });
  })
  $('.memo__count').on('click', function() {
    var $thisHabitCheck = $(this).closest('.habit').find('.habit-check'),
      habitId = $thisHabitCheck.data('habit-id'),
      achivementId = $thisHabitCheck.data('id');
      memoId = $thisHabitCheck.data('memo-id');
    //表示するIDをモーダルのDOMにセット
    var $modalBody = $('.modal-body').find('textarea');
    $modalBody.attr('data-habit-id', habitId);
    $modalBody.attr('data-achivement-id', achivementId);
    $modalBody.attr('data-memo-id', memoId);
    $('#memoListModal').modal();
    //aタグを無効にしないとモーダルがおかしくなる
    return false;
  });
  $('.memo__submitBtn').on('click', function() {
    var $modalBody = $('.modal-body').find('textarea'),
      habitId = $modalBody.attr('data-habit-id'),
      achivementId = $modalBody.attr('data-achivement-id');
      memoId = $modalBody.attr('data-memo-id');
    saveMemo(habitId, achivementId, memoId, $modalBody.val())
  });
});

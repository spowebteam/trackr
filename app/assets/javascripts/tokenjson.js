$(function () {  
  $('#team_user_tokens').tokenInput('/users.json', { crossDomain: false , prePopulate: $('#team_user_tokens').data('pre') });  
}); 
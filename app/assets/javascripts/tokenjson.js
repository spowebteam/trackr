$(function () {  
  $('#team_user_tokens').tokenInput('/users.json', { crossDomain: false , prePopulate: $('#team_user_tokens').data('pre') }); 
  $('#company_team_tokens').tokenInput('/teams.json',{ crossDomain: false , prePopulate: $('#company_team_tokens').data('pre')
    });
}); 
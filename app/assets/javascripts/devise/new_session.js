$(document).ready(function() {
  $('#loginWithUsername').on('click',function(event) {
    event.preventDefault();
    $('#oauthLogin').addClass('d-none');
    $('#usernameLogin').removeClass('d-none');
  });

  $('#loginWithOauth').on('click',function(event) {
    event.preventDefault();
    $('#oauthLogin').removeClass('d-none');
    $('#usernameLogin').addClass('d-none');
  });
})

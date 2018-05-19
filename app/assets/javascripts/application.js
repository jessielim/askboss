// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .


// $(document).on('turbolinks:load', function() {
// 	console.log("formclock")

//   $('form').on('click', '.remove_record', function(event) {
//     $(this).prev('input[type=hidden]').val('1');
//     $(this).closest('tr').hide();
//     return event.preventDefault();
//   });

//   $('form').on('click', '.add_fields', function(event) {
//     var regexp, time;
//     time = new Date().getTime();
//     regexp = new RegExp($(this).data('id'), 'g');
//     $('.fields').append($(this).data('fields').replace(regexp, time));
//     return event.preventDefault();
//   });
  
// });


function add_fields(link, association, content) {
  var new_id = new Date().getTime();

  // find the new_ + "association" that was defined in Rails helper
  var regexp = new RegExp("new_" + association, "g");

  // find the container and append in the sub field content
  $(link).prev().append(content.replace(regexp, new_id));
  return false;
}


function removeField(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").fadeOut();
}
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$( "#payment_received_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#payment_start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#payment_end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});
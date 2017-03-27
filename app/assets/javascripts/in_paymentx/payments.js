// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$( "#payment_received_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#payment_start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#payment_end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});

$(function() {
    return $('#payment_payer_name').autocomplete({
        minLength: 1,
        source: $('#payment_payer_name').data('autocomplete-source'),  //'#..' can NOT be replaced with this
        select: function(event, ui) {
            //alert('autocomplete fired!');
            $(this).val(ui.item.value);
        },
    });
});

$(function() {
  $(document).on('change', '#payment_payer_name', function (){  //only document/'body' works with every change. 
  	$.get(window.location, {payer_name: $('#payment_payer_name').val(), field_changed: 'payer_name'}, null, "script");
    return false;
  });
});
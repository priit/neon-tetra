// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaul

function moreInfo(dsa) {
  $('h1').html('I am Fish');
  $('.dialog .info').html('TERE kala!!');
  $("#dialog").dialog({
			height: 380,
			width: 890
  });
}

function nextStep(elem) {
  $("#"+elem).prev().hide('slide', { direction: 'left' }, 1000);
  $('#'+elem).show('slide', { direction: 'right' }, 1000);
  return false;
}

function prevStep(elem) {
  $("#"+elem).next().hide('slide', { direction: 'right' }, 1000);
  $('#'+elem).show('slide', { direction: 'left' }, 1000);
  return false;
}

function createAquarium() {
//TODO: empty and letters field check
  
  $.post('/aquariums', {
    aquarium: { 'volume' : $('input[name=volume]').val() }
  }, function(data) {
    
    }
  );
  nextStep('step2');
}

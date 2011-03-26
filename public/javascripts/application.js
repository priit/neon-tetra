// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaul

function moreInfo(dsa) {
  
}

function nextStep(elem) {
  $("#"+elem).prev().hide('slide', { direction: 'left' }, 1000);
  $('#'+elem).show('slide', { direction: 'right' }, 1000);
}

function prevStep(elem) {
  console.log(elem);
  $("#"+elem).next().hide('slide', { direction: 'right' }, 1000);
  $('#'+elem).show('slide', { direction: 'left' }, 1000);
}
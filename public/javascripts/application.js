// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaul

function moreInfo(fish) {
  name           = $(fish + " .name").html();
  description    = $(fish + " .description").html();
  image          = $(fish + " .image").html();
  min_group_size = $(fish + " .min_group_size").html();
  $('input[name=fish_counter]').val(min_group_size);
  $('#dialog h1').html(name);
  $('#dialog .info').html(description);
  $('#dialog .image').html(image);
  
  $("#dialog").dialog({
			height: 415,
			width: 726
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

function doSearch(string) {
  $.get('/species', {
    search: string
  }, function(data) {
  });
}

function doFamilySearch(id) {
  $.get('/species', {
    'family_id' : id
  }, function(data) {
  })
}

$(document).ready(function() {
  $('#search').keyup(function(e) {
    if (e.keyCode == 13) {
      doSearch($(e.target).val());
    }
  });
});

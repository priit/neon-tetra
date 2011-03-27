// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaul

function moreInfo(fish) {

  name           = $(fish + " .name").html();
    console.log(name);
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
  $('#search_result').html('');
  $.get('/species', {
    search: string
  }, function(data) { 
    populateFishList(data)
  });
}

function populateFishList(data) {
  $.each(data, function(key, val) {
    $('#search_result').append('<li id="fish_'+val.species.id+'"><img height="113px" width="150px" title="dsa" src="'+val.species.photo_thumb+'" onclick="moreInfo(\'#fish_'+val.species.id+'\')" class="vtip" alt="'+val.species.common_name+'"><div style="display:none"><div class="name">'+val.species.common_name+'</div><div class="description">'+val.species.description+'</div><div class="image"><img src="'+val.species.photo_medium+'" alt="'+val.species.common_name+'"></div><div class="min_group_size">'+val.species.min_group_size+'</div></div></li>');
  });
}

function doFamilySearch(id) {
  $('#search_result').html('');
  $.get('/species', {
    'family_id' : id
  }, function(data) {
    populateFishList(data);
  });
}

function addFish() {
  $.getJSON('/aquariums/add', {
    id: 1,
    count: 10
  }, function(data) { 
    
  });
}

$(document).ready(function() {
  $('#search').keyup(function(e) {
    if (e.keyCode == 13) {
      doSearch($(e.target).val());
    }
  });
});



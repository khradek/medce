
var map;

window.addMarkers = function addMarkers() {
  var element = document.querySelector("#med_profs-list");
  var med_profs = window.med_profs = JSON.parse(element.dataset.medProfs);

  map.removeMarkers();

  var i = 1;

  med_profs.forEach(function(med_prof){
    var number = i++
    var med_prof_label_num = number.toString(); 
    if (top.location.pathname === '/med_profs'){
      var med_prof_label = med_prof_label_num;
    }else {
      var med_prof_label = "";
    }
    if (med_prof.latitude && med_prof.longitude){
      var marker = map.addMarker({
        lat: med_prof.latitude,
        lng: med_prof.longitude,
        title: med_prof.address,
        label: med_prof_label,
        infoWindow: {
          content: `<p>
                      <span class="bold-text"><a href='/med_profs/${med_prof.id}'>${med_prof.title}</a></span><br>
                      <a href='tel:${med_prof.phone}'>${med_prof.phone}</a><br>
                      ${med_prof.street}<br>
                      ${med_prof.city}, ${med_prof.state} ${med_prof.zip}
                    </p>`
        }
      });
    }
  });

  setSafeBounds(element);
}


function setSafeBounds(element) {

  if ($("#med_profs-list").attr('data-l')) {
    var l = element.dataset.l;
    var latlngs   = l.split(',');
    var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
    var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
    var bounds    = new google.maps.LatLngBounds(southWest, northEast);
    map.fitBounds(bounds, 0);
  }else {
    map.fitZoom();
  };
    
}


document.addEventListener("turbolinks:load", function() {

  //Disables search button unless text is in field
  $('#search-button').prop('disabled', true);
  $('#search-form').keyup(function(){ 
    if($('#search-form').val().length == 0){
      $('#search-button').prop('disabled', true);      
    }else{ 
      $('#search-button').prop('disabled', false);
    };
  });
  
  map = window.map = new GMaps({
    div: '#map',
    lat: 35.021050,
    lng: -80.845996,
    maxZoom: 17,
    mapTypeControl: false,
    zoomControlOptions: {
      position: google.maps.ControlPosition.LEFT_BOTTOM
    }
  });

  addMarkers();

  //if statement to prohibit page reload on drag on show page
  if (top.location.pathname === '/med_profs'){

    map.addListener("dragend", function(){
      var bounds = map.getBounds();
      var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

      //if statement to check if med_prof_type present and then add to URL if true
      if ($.trim($('#med_prof_type').text()) != ""){
        var med_prof_type = $('#med_prof_type').text();
        Turbolinks.visit(`/med_profs?l=${location}&med_prof_type=${med_prof_type}`);
      }else {
        Turbolinks.visit(`/med_profs?l=${location}`);
      };
    });


    //Sets number next to med_prof
    var n = 1
    $('.list-number').each(function () {
      var list_number = n++
      $(this).text(list_number);
    });

  }

  //Fixes map to top of screen
  var height = $('#map-div').offset().top - 10;
  $(window).scroll(function () { 
    if ($(window).scrollTop() > height) {
      $('#map-div').addClass('map-fixed');
    }
    if ($(window).scrollTop() < height) {
      $('#map-div').removeClass('map-fixed');
    }
  }); 

  //Opens marker info window when link is hovered
  var i = 0
  $('.med-prof-link').each(function () {
    var id_number = i++
    $(this).attr('id', id_number);
  });
  var markers = map.markers;
  $(".med-prof-link").mouseover(function () {
    var id = $(this).attr('id');
    google.maps.event.trigger(markers[id], 'click');
  });
  $(".med-prof-link").mouseout(function () {
    var id = $(this).attr('id');
    markers[id].infoWindow.close();
  });


});

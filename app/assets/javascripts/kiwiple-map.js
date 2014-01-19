/**
 * map class
 * @dependency : underscore.js, google map
 * @author : watermelon
 *
 */
(function(root, factory) {

  /* CommonJS */
  if (typeof exports == 'object')  module.exports = factory()

  /* AMD module */
  else if (typeof define == 'function' && define.amd) define(factory)

  /* Browser global */
  else root.jarvisMap = factory()
}(this, function () {
    "use strict";

  function jarvisMap() {

    // google style map
    this.styles_modern = [
    {
        "featureType": "administrative",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [{ "color": "#dbdbdb" }]
    },
    {
        "featureType": "road.highway",
        "stylers": [{ "visibility": "simplified" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.stroke",
        "stylers": [{ "color": "#dbdbdb" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.text",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.text.fill",
        "stylers": [{ "color": "#555555" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "road.local",
        "elementType": "labels",
        "stylers": [{ "visibility": "on" }]
    },{
        "featureType": "road.local",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#f0f0f0" }]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry.stroke",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#b3cde6" }]
    }, 
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "poi.business",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#d0ddb8" }]
    },
    {
        "featureType": "poi.school",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "poi.medical",
        "elementType": "geometry",
        "stylers": [
            { "visibility": "on" },
            { "color": "#dfdfde" }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "geometry",
        "stylers": [
            { "visibility": "on" },
            { "color": "#dfdfde" }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "labels.text",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "transit.station.rail",
        "elementType": "labels",
        "stylers": [
            { "color": "#63523a" },
            { "visibility": "on" }
        ]
    },
    {
        "featureType": "transit.line",
        "stylers": [{ "visibility": "on" }]
    }];
   
    this.styles_modern_zoomed = [
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [{ "color": "#dbdbdb" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels.text",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [{ "color": "#555555" }]
    },
    {
        "featureType": "road.highway",
        "stylers": [{ "visibility": "simplified" }]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.stroke",
        "stylers": [{ "color": "#dbdbdb" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.text",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.text.fill",
        "stylers": [{ "color": "#555555" }]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "road.local",
        "elementType": "labels",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#f0f0f0" }]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry.stroke",
        "stylers": [{ "color": "#ffffff" }]
    },
    {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#b3cde6" }]
    },
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "poi.business",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [{ "color": "#d0ddb8" }]
    },
    {
        "featureType": "poi.school",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "poi.medical",
        "elementType": "geometry",
        "stylers": [
            { "visibility": "on" },
            { "color": "#dfdfde" }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "geometry",
        "stylers": [
            { "visibility": "on" },
            { "color": "#dfdfde" }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "labels.text",
        "stylers": [{ "visibility": "on" }]
    },
    {
        "featureType": "transit.station.rail",
        "elementType": "labels.text.fill",
        "stylers": [
            { "visibility": "on" },
            { "color": "#000000" }
        ]
    },
    {
        "featureType": "transit.line",
        "stylers": [{ "visibility": "on" }]
    }];
    
    this.festivalMap;
    this.markList;

  };

  jarvisMap.prototype = {

      // initialize for map style and init
    	init: function(target) {
    		var that = this;
    		var styled_festival = new google.maps.StyledMapType(this.styles_modern, {name: "Festival style"});
          var styled_festival_zoomed = new google.maps.StyledMapType(this.styles_modern_zoomed, {name: "Festival style zoomed"});
          var festivalMapOptions = { 
          	center: new google.maps.LatLng(32,127),
              zoom: 6,
              maxZoom:18,
              minZoom:6,
              panControl: false,
              mapTypeControl: false,
              mapTypeControlOptions: {
                  mapTypeIds: [ 'map_styles_festival', 'map_styles_festival_zoomed']
              }
          };
          
          that.festivalMap = new google.maps.Map(target, festivalMapOptions); // document.getElementById("map_canvas")
          that.festivalMap.mapTypes.set('map_styles_festival', styled_festival);
          that.festivalMap.mapTypes.set('map_styles_festival_zoomed', styled_festival_zoomed);
          that.festivalMap.setMapTypeId('map_styles_festival');
    	},
    	
    	// only one marker view
    	getMark: function(item) {
    		
    		var that = this;
    		that.clearInfoBoxAll();
    		
    		_.each(that.markList, function(mark) {
    			if(mark._id === item._id) {
    				mark.infoBox.open(that.festivalMap, mark.marker);
  	  	        var currentZoom =that.festivalMap.getZoom();
  	  	        if (currentZoom <= 8){
  	  	        	that.festivalMap.setZoom(8);
  	  	        }
  	  	        that.festivalMap.setCenter(mark.marker.getPosition());  
  	  	        return;
    			}
    		});

    	},
    	
    	// clear InfoBox
    	clearInfoBoxAll: function() {
    		
    		var that = this;
    		_.each(that.markList, function(mark) {
    			mark.infoBox.close();
    		});
    	},
    	
      // clear Marker and InfoBox	
    	clearMarkers: function() {
    		
    		var that = this;
    		_.each(that.markList, function(mark) {
    			mark.infoBox.close();
    			mark.marker.setMap(null);
    		});
    		
    	},
    	
    	// add marker list
    	addMark: function(items) {
    		
    		var that = this;
    		
    		that.clearMarkers();
    		that.markList = new Array(items.length + 1);
    		_.each(items, function(item, index) {
  			google.maps.event.addListener( that.festivalMap, "zoom_changed", function() {
  	  			var newZoom =  that.festivalMap.getZoom();
  	  			if (newZoom > 6){
  	  				 that.festivalMap.setMapTypeId('map_styles_festival_zoomed');
  	  			} else {
  	  				 that.festivalMap.setMapTypeId('map_styles_festival');
  	  			}
  			});
  				
  			var markData = {};
  	        markData.marker = new google.maps.Marker({
  	            position: new google.maps.LatLng(item.loc.lat, item.loc.long),
  	            map:  that.festivalMap,
  	            title: 'jarvis',
  	            zIndex:index
  	        });
  	       
  	        var pop_up_info = "border: 0px solid black; background-color: #ffffff; padding:15px; margin-top: 8px; border-radius:10px; -moz-border-radius: 10px; -webkit-border-radius: 10px;";
  	        var boxTextGlastonbury = document.createElement("div");
  	        boxTextGlastonbury.style.cssText = pop_up_info;
  	        boxTextGlastonbury.innerHTML = '<span class="pop_up_box_text">' + item.article + '</span>';
  	                   
  	        var infoboxOptionsGlastonbury = {
  	            content: boxTextGlastonbury,
  	            disableAutoPan: false,
  	            maxWidth: 0,
  	            pixelOffset: new google.maps.Size(-241, 0),
  	            zIndex: null,
  	            boxStyle: { 
  	                opacity: 1,
  	                width: "430px"
  	            },
  	            closeBoxMargin: "10px 2px 2px 2px",
  	            closeBoxURL: "icons/button_close.png",
  	            infoBoxClearance: new google.maps.Size(1, 1),
  	            isHidden: false,
  	            pane: "floatPane",
  	            enableEventPropagation: false
  	        };
  	        
  	        markData.infoBox = new InfoBox(infoboxOptionsGlastonbury);
  	        google.maps.event.addListener(markData.marker, "click", function (e) {
  	        	that.clearInfoBoxAll();
  	        	markData.infoBox.open(that.festivalMap, this);
  	            var currentZoom =that.festivalMap.getZoom();
  	            if (currentZoom <= 8){
  	            	that.festivalMap.setZoom(8);
  	            }
  	            that.festivalMap.setCenter(markData.marker.getPosition());
  	        });
  	        that.festivalMap.setCenter(markData.marker.getPosition());
  	        markData._id = item._id;
  	        that.markList.push(markData);
  		
    		});
    	}
  };

  return jarvisMap;
}));
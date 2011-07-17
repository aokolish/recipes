jQuery.ajaxSetup({ 
	beforeSend: function(xhr) { xhr.setRequestHeader("Accept", "text/javascript")}
});

$(function() {
	$('body').doubletap(function(event) {
		//if they are viewing the recipe-show page
		if (/recipes\/\d+/.test($.mobile.activePage.attr('data-url'))) {

			var ingredients = $.mobile.activePage.find('ul.ingredients'),
					ingredientsTop = ingredients.offset().top,
					ingredientsBottom = ingredientsTop + ingredients.outerHeight(),
					directionsTop = $.mobile.activePage.find('ul.directions').offset().top,
					viewportMiddle = $(window).scrollTop() + ($(window).height() / 2);
					
			// if they are mostly viewing the directions or they haven't even made it to the ingredients
			if (viewportMiddle > ingredientsBottom || viewportMiddle < ingredientsTop) {
				// scroll to ingredients
				$.mobile.silentScroll(ingredientsTop - 10)
			} else {
				$.mobile.silentScroll(directionsTop - 10)
			}
		}
	});
});


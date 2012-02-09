$ ->
  # this is for debugging purposes
  $(window).bind "resize", ->
    console.log $(window).outerWidth()

   $('a[title], span[title], input[title]').tooltip({
     position: 'center right',
     offset: [0, 10],
     effect: 'fade',
     predelay: 250
   })
  $('.best_in_place').best_in_place()

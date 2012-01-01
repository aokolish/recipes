$ ->
  # this is for debugging purposes
  $(window).bind "resize", ->
    console.log $(window).outerWidth()

   $('a[title]').tooltip({
     position: 'center right',
     opacity: .9,
     offset: [0, 10],
     effect: 'fade',
     predelay: 250
   })

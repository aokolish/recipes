$ ->
  # this is for debugging purposes
  $(window).bind "resize", ->
    console.log $(window).outerWidth()

  # setup tooltips and filter out links that are a part of recipe page
  # flexslider slideshow
  $('a[title], span[title], input[title]').not('[rel="galler"]').tooltip({
    position: 'center right',
    offset: [0, 10],
    effect: 'fade',
    predelay: 250
  })

  $('.flexslider').flexslider
    animation: 'slide',
    slideshow: false,
    keyboardNav: false,
    manualControls: '.custom-controls li',

  # flexslider will not change slides unless you click the nav
  $('#recipe_info .custom-controls li').hoverIntent(->
    $(this).trigger('click')
  , ->
      null
  )

  $('#recipe_info .slides li:not(.clone) a').colorbox()

  # inline editing js plugin
  $('.best_in_place').best_in_place()

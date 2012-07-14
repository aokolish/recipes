$ ->
  # this is for debugging purposes
  $(window).bind "resize", ->
    console.log $(window).outerWidth()

  # setup tooltips and filter out links that are a part of recipe page
  # flexslider slideshow
  $('.tooltipped').tooltip({
    placement: 'right'
  })

  $('.flexslider').flexslider
    animation: 'slide',
    slideshow: false,
    keyboardNav: false,
    prevText: '‹',
    nextText: '›',
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

  # make boostrap 'disabled' links and such actually disabled
  $('a.disabled').click ->
    false

# Load GitHub Gists asynchronously
# and optionally specify which file to show.
#
# Requires yepnope and jQuery.
#
# Based on Mark Selby's async-gists.js:
# https://gist.github.com/markselby/7209751
#
# This version by Evan Sosenko.
#
# Source and usage instructions:
# https://gist.github.com/razor-x/8288761
#

'use strict'

$ ->
  GIST_HOST = 'https://gist.github.com'
  elements = $('div[data-gist]')
  gists = {}
  code = []
  stylesheets = []

  elements.addClass('loading')

  $('div.loading[data-gist] span.loader').fadeOut 'fast', ->
    loader = $(spinnerHTML)
    $(this).replaceWith(loader)
    loader.fadeIn

  # Get elements referencing a gist
  # and build a gists hash referencing
  # the elements that use it.
  elements.each (index, element) ->
    element = $(element)
    gist = element.data 'gist'
    gists[gist] ?= targets: []
    gists[gist].targets.push element

  # Load the gists.
  $.each gists, (id, data) ->
    $.getJSON "#{GIST_HOST}/#{id}.json?callback=?", (data) ->
      gist = gists[id]
      gist.data = data

      # Only insert the stylesheets once.
      stylesheet = gist.data.stylesheet
      if stylesheets.indexOf(stylesheet) < 0
        stylesheets.push stylesheet
        yepnope(GIST_HOST + stylesheet)

      div = gist.data.div
      gist.files = $(div).find('.gist-file')
      gist.outer = $(div).first().html('')

      # Iterate elements refering to this gist.
      $(gist.targets).each (index, target) ->
        file = target.data 'gist-file'
        if file
          outer = gist.outer.clone()
          inner = "<div class=\"gist-file\">" \
            + $(gist.files.get(gist.data.files.indexOf(file))).html() \
            + "</div>"
          outer.html inner
        else
          outer = $(div)

        outer.hide()
        target.fadeOut 'fast', ->
          $(this).replaceWith(outer)
          outer.fadeIn()

# Ouroboros Sass/CSS Spinner
spinnerHTML =
  """
  <div class="ui-spinner">
    <span class="side side-left">
        <span class="fill"></span>
    </span>

    <span class="side side-right">
        <span class="fill"></span>
    </span>
  </div>
  """

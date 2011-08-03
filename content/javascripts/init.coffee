$ () ->
  $('.navigation').each () ->
    links = $(this).find 'a'
    panelIds = links.map () ->
      return this.hash
    .get().join ','
    
    panels = $(panelIds)
    panelWrapper = panels.filter(':first').parent()

    delay = 500
    heightOffset = 40

    panels.hide()
    links.click () ->
      link = $ this
      baseLink = this

      if link.is('.selected')
        return false

      links.removeClass 'selected'
      link.addClass 'selected'

      document.title = 'Dan Poggi - ' + link.text()
      if $.support.opacity
        panels.stop().animate {opacity: 0}, delay

      panelWrapper.stop().animate {height: 0}, delay, () ->
        height = panels.hide().filter(baseLink.hash).css('opacity', 1).show().height() + heightOffset
        panelWrapper.animate {height: height}, delay

    filter = ':first'
    if window.location.hash
      filter = '[hash=' + window.location.hash + ']'
    links.filter(filter).click()

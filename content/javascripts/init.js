(function() {
  $(function() {
    $('.navigation').each(function() {
      var links, panelIds, panels, panelWrapper, delay, heightOffset;
      links = $(this).find('a');
      panelIds = links.map(function() { return this.hash; }).get().join(',');
      panels = $(panelIds);
      panelWrapper = panels.filter(':first').parent();
      delay = 500;
      heightOffset = 40;

      panels.hide();
      links.click(function() {
        var link, baseLink;
        link = $(this);
        baseLink = this;

        if (link.is('.selected')) {
          return false;
        }

        links.removeClass('selected');
        link.addClass('selected');

        document.title = 'Dan Poggi - ' + link.text();
        if ($.support.opacity) {
          panels.stop().animate({opacity: 0}, delay);
        }
        panelWrapper.stop().animate({height: 0}, delay, function() {
          var height;
          height = panels.hide().filter(baseLink.hash).css('opacity', 1).show().height() + heightOffset;
          panelWrapper.animate({height: height}, delay);
        });
      });
      
      links.filter(window.location.hash ? '[hash=' + window.location.hash + ']' : ':first').click();
    });
  });
}());

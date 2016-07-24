//jQuery tabs

$('ul.tabs').each(function(){
	//for each of the tabs, we want to keep track of
	//which tab is active and it's assosiated content
	var $active, $content, $links = $(this).find('a');

	//if the location.hash matches one of the links, use that as the active tab.
	//if not match is found, use the first link as the initial active tab.
	$active = $($links.filter('[href="'+location.hash+'"]')[0] || $links[0]);
	$active.addClass('active');

	$content = $($active[0].hash);

	//hide the remaining content
	$links.not($active).each(function() {
		$(this.hash).hide();
	});

	//bind the click event handler
	$(this).on('click','a',function(e){
		//make the old tab inactive.
		$active.removeClass('active');
		$content.hide();

		//update the variables with the new link and content
		$active = $(this);
		$content = $(this.hash);

		//make the tab active
		$active.addClass('active');
		$content.show();

		//prevent the anchor's default click action
		e.preventDefault();

	});

});
jQuery(function($) {

	
	$('#heroShots #controls a').bind('click', function() {
		$('#heroShots img').hide();
		$('#heroShots #controls a').removeClass('current');
		$(this).addClass('current');
		
		var id = $(this).attr('id').replace('feature-thumb-','feature-full-');
		$('#'+id).fadeIn('slow');
	});
	
	$(function() {
		setInterval(heroShotAutoForward, 5000);

		function heroShotAutoForward() {
			$current = $('#heroShots #controls a.current');
			$currentParent = $current.parent();
			$('#heroShots img').hide();
			$('#heroShots #controls a').removeClass('current');
			if ($currentParent.prev().length != 0) {
				$a = $currentParent.prev().find('a');
				$a.addClass('current');
				var id = $a.attr('id').replace('feature-thumb-','feature-full-');
				$('#'+id).fadeIn('slow');
			} else {
				$a = $('#heroShots #controls li:last').find('a');
				$a.addClass('current');
				var id = $a.attr('id').replace('feature-thumb-','feature-full-');
				$('#'+id).fadeIn('slow');
			}
		}
	});
	
	
});


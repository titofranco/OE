jQuery(document).ready( function() {

	jQuery("#iframeCntnr").imBookFlip({
		page_class: 'imBookPage',
		iframe: {src: 'book.html', book: 'myBook'}
	});

	jQuery("#myBook").imBookFlip({
		page_class: 'imBookPage'
	});
	
	
  jQuery('#myPageFlip').jPageFlip({
    width: 300,
    height: 225,
    top: 30,
    left: 70
  });
	
	
});


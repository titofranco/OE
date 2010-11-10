$(document).ready( function() {
/*
	$("#iframeCntnr").imBookFlip({
		page_class: 'imBookPage',
		iframe: {src: 'book.html', book: 'myBook'}
	});*/

	$("#myBook").imBookFlip({
		page_class: 'imBookPage'
	});
	
	
   $('#myPageFlip').jPageFlip({
      width: 300,
      height: 225,
      top: 30,
      left: 70
    });
	
	
});



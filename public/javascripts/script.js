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
    
  // jQuery("#new_page").submitWithAjax();
});


jQuery.fn.submitWithAjax = function() {
  this.submit(function(){
    //$.post(url, data, callback, dataType);  
    $.post(this.action, $(this).serialize(),null,"script"); 
    return false;
  })
  return this;
};

jQuery.ajaxSetup({
  'beforeSend': function(xhr){
    xhr.setRequestHeader("Accept", "text/javascript")
  }
})

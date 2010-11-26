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
    04465-35290
  // jQuery("#new_page").submitWithAjax();
  
  $('a.delete_page').live('click', function(){
    console.debug("action" + this.href);
    $.post(this.href, {_method: 'delete'},null, "script" );
    //Implement what to hide
    return false;
  });
  
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
});

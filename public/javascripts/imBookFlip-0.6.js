 /*
 * 	 imBookFlip - a JQuery Plugin
 * 	 @author Les Green
 * 	 Copyright (C) 2009 Intriguing Minds, Inc.
 *   Version 0.6
 * 
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *   
 *   original Javascript BookFlip concept - http://www.coastworx.com/bookflip.php
 *   soundManager - Scott Schiller http://www.schillmania.com/projects/soundmanager2/
 *
 *   Demo and Documentation can be found at:   
 *   http://www.grasshopperpebbles.com
 *   
 */

;(function($) {
	$.fn.extend({
        imBookFlip: function(options) { 
        	opts = $.extend({}, $.bookFlip.defaults, options);
			return this.each(function() {
				new $.bookFlip(this, opts);
			});
        }
    });	

$.bookFlip = function(obj, opts) {
	var $this = $(obj);
	var numPages = 0;
	var leftStart=0,rightStart=1;
	var autoPage = 0;
	var page, book, bW, pageW, pageH, bookOpenW = '';
	
	if (opts.sound_manager) {
		loadAudio();
	}

	if (opts.iframe.src) {
		loadIFrame();
	} else {
		page = $('.'+opts.page_class)[0];
		init();
	}
	
	function loadIFrame() {
		var iframe = $this.append($('<iframe src="'+opts.iframe.src+'" id="bookFlipIframe" name="bookFlipIframe"></iframe>').css({"width":$this.width(), "height": $this.height(), "border": "0px", "overflow":"hidden"}));
		$('#bookFlipIframe').load(function() {
			book = $('#bookFlipIframe').contents().find('#'+opts.iframe.book);
			page = $('#bookFlipIframe').contents().find('.'+opts.page_class)[0];
			init();	
		});		
	};
	
	function init() {
		bW = parseInt($(page).css('borderLeftWidth')) + parseInt($(page).css('borderRightWidth'));
		pageW = parseInt($(page).css('width')) + bW;
		pageH = parseInt($(page).css('height')) + bW;
		bookOpenW = pageW*2;
		
		//var showBinder=false; //change to false for no binder
		//var binderImage = "parchmentring2.gif"; //location of center binder
		//var binderWidth = 20; //width of center binder image		
		
		if(opts.numPixels>100){opts.numPixels=100;};
		createPages();	
	};
	
	function loadAudio() {
		var ld = (opts.autoFlip != 'click');
		var dbg = false;
		if (opts.sound_manager.debug) {
			dbg = opts.sound_manager.debug;
		}
		soundManager.url = opts.sound_manager.swf_loc;
		soundManager.debugMode = dbg;
		soundManager.onload = function() {
			// soundManager is initialised, ready to use. Create a sound for this demo page.
			soundManager.createSound({
				id: 'bookAudio',
				url: opts.sound_manager.audio_loc,
				autoLoad: true,
				autoPlay: ld
			});
		}
	};
	
	function createPages() {
		var pages;
		if (opts.iframe.src) {
			$this = $(book);
			pages = $this.find(' > div');
		} else {
			var bk = $this.attr('id');
			pages = $('#'+bk + ' > div');	
		}
		$this.css({'width': (bookOpenW + 'px'), 'height': pageH+'px', 'zIndex':0});
		$(pages).each(function(i) {
			numPages++;
			var orig = $(this).clone();
			var div = $('<div></div>').attr({'id': 'pageNum'+i, 'class': opts.page_class}).css({'zIndex':20-i, 'border': 'none', 'left': pageW+'px', 'width': pageW+'px', 'height': pageH+'px'});
			$(this).replaceWith(div);
			$(orig).attr('id', 'pageFlip'+i);
			/*if(!number_check(i)){
				if(document.all){
					$(orig).css('filter', 'progid:DXImageTransform.Microsoft.Alpha(Opacity=100, FinishOpacity=30, Style=1, StartX=80, FinishX=100, StartY=0, FinishY=0)');
				}else{
					var pngDiv = $('<div></div>').css({'position': 'absolute', 'left':pWidth-80+'px', 'top':'0px', 'width':80+'px', 'height': pHeight+'px', 'background': 'transparent url(bookflip/black_gradient.png) top right repeat-y'}).appendTo($(orig));
				}			
			}*/
			$(div).append($(orig));
			if(opts.allowPageClick){
				$(orig).click(function() {
					if(number_check(i)){
						soundCheck();
						nextPage();
					} else {
						prevPage();
					}
				});
			}
		});
		$this.css('display', 'block');
		if (opts.autoFlip == 'auto') {
			doAutoFlip();
		}
	};
	
	function doAutoFlip() {
		if (rightStart < numPages) {
			autoPage = setTimeout(nextPage, opts.autoFlipSpeed);
		} else {
			clearTimeout(autoPage);
		}
	};
	
	function soundCheck() {
		if ((opts.sound_manager) && (rightStart == 1)) {
			if (opts.autoFlip == 'click') {
				soundManager.play('bookAudio');
			}
		}
	};
	
	function number_check(value) {
		//  returns true if value is even, false if value is odd
		return ( 1 - (value%2) ); 
	};
	
	function nextPage(){
		var page = (opts.iframe.src) ? $this.find("#pageNum"+rightStart) : $("#pageNum"+rightStart);
		var lpage = (opts.iframe.src) ? $this.find("#pageNum"+leftStart) : $("#pageNum"+leftStart);
		$(page).css({'width': '0px', 'left': bookOpenW +'px', 'zIndex': 99});
		$(page).animate({'left': 2+'px', 'width': pageW+'px'}, 'slow', function() {
			$(lpage).css({'width': '0px'});
			var z = $(this).css('zIndex');
			$(this).css({'left': '0px', 'width': pageW+'px', 'zIndex': z-99});
			$(lpage).css({'left': '', 'right': '0px'});
			$(this).css({'left': '', 'right': '0px'});
			leftStart=leftStart+2;
			rightStart=rightStart+2;
			if (opts.autoFlip != 'off') {
				doAutoFlip();
			}
		});
	};
	
	function prevPage(){
		leftStart=leftStart-2;
		rightStart=rightStart-2;
		var page = (opts.iframe.src) ? $this.find("#pageNum"+leftStart) : $("#pageNum"+leftStart);
		var rpage = (opts.iframe.src) ? $this.find("#pageNum"+rightStart) : $("#pageNum"+rightStart);
		var pFlipL = (opts.iframe.src) ? $this.find("#pageFlip"+leftStart) : $("#pageFlip"+leftStart);
		var pFlipR = (opts.iframe.src) ? $this.find("#pageFlip"+rightStart) : $("#pageFlip"+rightStart);
		$(page).css({'width': '0px', 'left': '0px'});
		$(pFlipR).css({'left': '', 'right': '0px'});
		$(page).animate({'left': pageW+'px', 'width': pageW+'px'}, 'slow', function() { 
			$(rpage).css({'width': '0px'});
			$(pFlipR).css({'left': '0px'});
			$(pFlipL).css({'left': '0px'});
		});
	};
	
};

$.bookFlip.defaults = {
	allowPageClick: true,
	autoFlip: 'off', //auto, click
	autoFlipSpeed: 7000,
	numPixels: 20, //number of pixels to move per frame, more is faster but less smooth
	pSpeed: '20', //page speed, 20 is best for Opera browser. Less is faster
	page_class: '',
	sound_manager: '', // {swf_loc: 'soundmanager/soundmanager2.swf', audio_loc: '', debug: false}
	iframe: '' //{src: 'test_bookflip3_iframe.html', book: 'myBook'}
};
})(jQuery);	

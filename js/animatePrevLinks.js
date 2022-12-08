$(function(){

$('<div id="prevPanel"></div>').insertAfter('#docCont');

$('a.PITLink').click(function (e) {
	e.preventDefault();
	var panel = $('#prevPanel');
	$('#docCont').css({	'opacity': '0.1'});
	$('#wb-foot').css({	'opacity': '0.1'});
	$('#gcwu-date-mod').css({	'opacity': '0.1'});
	
	panel.css({
	'width':panel.width(),
	'background-color':'#eeeeee',
	'position': 'absolute',
	'top': $(window).scrollTop()
	})
	.hide()
	.load(this.href + ' #docCont section', 
		function(){ 
		$('<a href="#">Close X</a>').click(function (e){
			e.preventDefault();
			var closeLink = $(this);
			panel.fadeOut(function(){
				closeLink.remove();
				$('#docCont').animate({'opacity':'1'}, 'fast');
				$('#wb-foot').animate({'opacity':'1'}, 'fast');
				$('#gcwu-date-mod').animate({'opacity':'1'}, 'fast');
			});
		}).prependTo(panel).css({'float':'right','padding-right':'3em'});
		panel.fadeIn('slow')});
});

});
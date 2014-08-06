/*jshint jquery:true */
/*global $:true */

var $ = jQuery.noConflict();

$(document).ready(function($) {
	"use strict";


	/*-------------------------------------------------*/
	/* =  portfolio isotope
	/*-------------------------------------------------*/

	var winDow = $(window);
	// Needed variables
	var $container=$('.portfolio-box, .blog-box');
	var $lazyImgs = $('img.lazy');
	var $filter=$('.filter');
	var $widthFilter = $('.width-filter');
	var $heightFilter = $('.height-filter');
	var $widescreenFilter = $('.widescreenFilter');
	var minimumWidth = 0;
	var minimumHeight = 0;
	var widescreenFilter = false;

	try{

		$container.imagesLoaded( function(){
			$container.show();

			$lazyImgs.lazyload({
				failure_limit: Math.max($lazyImgs.length - 1, 0),
				threshold: 200,
				skip_invisible: false
			});

			$container.isotope({
				filter:'*',
				layoutMode:'masonry',
				animationOptions:{
					duration:750,
					easing:'linear'
				}
			});

			winDow.trigger('scroll');
		});
	} catch(err) {
		console.log(err);
	}



	var filterImages = function() {
		$container.isotope({
			filter	: function(){
				var width = parseInt($(this).attr('data-width'));
				var height = parseInt($(this).attr('data-height'));
				var ratio = width / height;
				return width >= minimumWidth && height >= minimumHeight && (!widescreenFilter || (widescreenFilter && ratio > (16.0 / 10)));
			},
			animationOptions: {
				duration: 750,
				easing	: 'linear',
				queue	: false,
			}
		});
	}

	// Isotope Filter
	$filter.find('a').click(function(){
		filterClass = $(this).attr('data-filter');

		try {
			filterImages();
		} catch(err) {
			console.log(err)
		}
		return false;
	});

	$widescreenFilter.click(function() {
		widescreenFilter = !widescreenFilter;
		var $this = $(this);
		if ( !$this.hasClass('active')) {
			$this.addClass('active');
		} else {
			$this.removeClass('active');
		}
		try {
			filterImages();
		} catch(err) {
			console.log(err)
		}
		return false;
	});

	$widthFilter.find('a').click(function(){
		minimumWidth = parseInt($(this).attr('data-width'));

		try {
			filterImages()
		} catch(err) {
			console.log(err)
		}
		return false;
	});

	$heightFilter.find('a').click(function(){
		minimumHeight = parseInt($(this).attr('data-height'));

		try {
			filterImages()
		} catch(err) {
			console.log(err)
		}
		return false;
	});


	var filterItemA	= $('.filter li a');
	var widthFilterItemA = $('.width-filter li a');
	var heightFilterItemA = $('.height-filter li a');

	filterItemA.on('click', function(){
		var $this = $(this);
		if ( !$this.hasClass('active')) {
			filterItemA.removeClass('active');
			$this.addClass('active');
		}
	});

	widthFilterItemA.on('click', function(){
		var $this = $(this);
		if ( !$this.hasClass('active')) {
			widthFilterItemA.removeClass('active');
			$this.addClass('active');
		}
	});

	heightFilterItemA.on('click', function(){
		var $this = $(this);
		if ( !$this.hasClass('active')) {
			heightFilterItemA.removeClass('active');
			$this.addClass('active');
		}
	});

	$('.backgroundPopup').magnificPopup({
		type: 'image',
		mainClass: 'mfp-fade',
		overflowY: 'hidden'
	});


	/*-------------------------------------------------*/
	/* =  preloader function
	/*-------------------------------------------------*/
	var body = $('body');
	body.addClass('active');

	winDow.load( function(){
		var mainDiv = $('#container'),
			preloader = $('.preloader');

			preloader.fadeOut(200, function(){
				mainDiv.delay(200).addClass('active');
				body.delay(200).css('background', '#b4b7b8');
			});
	});

	/*-------------------------------------------------*/
	/* =  flexslider
	/*-------------------------------------------------*/
	try {

		var SliderPost = $('.flexslider');

		SliderPost.flexslider({
			animation: "fade",
			slideshowSpeed: 4000,
		});
	} catch(err) {

	}

	/* ---------------------------------------------------------------------- */
	/*	nice scroll
	/* ---------------------------------------------------------------------- */

	try {
		var HTMLcontainer = $("html");
		HTMLcontainer.niceScroll({
			cursorcolor:"#2fbab9"
		});
	} catch(err) {

	}

	/* ---------------------------------------------------------------------- */
	/*	info box toggle
	/* ---------------------------------------------------------------------- */

	var toggleInfo = $('.info-toggle'),
		toggleContent = $('.info-content');

		toggleInfo.on('click', function(e){
			e.preventDefault();

			if ( !$(this).hasClass('active') ) {
				$(this).addClass('active');
				toggleContent.addClass('active');
			} else {
				$(this).removeClass('active');
				toggleContent.removeClass('active');
			}
		});

	/* ---------------------------------------------------------------------- */
	/*	Contact Map
	/* ---------------------------------------------------------------------- */
	var contact = {"lat":"51.51152", "lon":"-0.104198"}; //Change a map coordinate here!

	try {
		var mapContainer = $('#map');
		mapContainer.gmap3({
			action: 'addMarker',
			latLng: [contact.lat, contact.lon],
			map:{
				center: [contact.lat, contact.lon],
				zoom: 14
				},
			},
			{action: 'setOptions', args:[{scrollwheel:true}]}
		);
	} catch(err) {

	}

	/* ---------------------------------------------------------------------- */
	/*	magnific-popup
	/* ---------------------------------------------------------------------- */

	try {
		// Example with multiple objects
		var ZoomImage = $('.zoom, .zoom-image');
		ZoomImage.magnificPopup({
			type: 'image'
		});
	} catch(err) {

	}

	/*-------------------------------------------------*/
	/* =  Testimonial
	/*-------------------------------------------------*/
	try{
		var testimUl = $('.testimonial ul');

		testimUl.quovolver({
			transitionSpeed:300,
			autoPlay:true
		});
	}catch(err){
	}

	/*-------------------------------------------------*/
	/* = skills animate
	/*-------------------------------------------------*/

	try {
		var animateElement = $(".meter > span");
		animateElement.each(function() {
			$(this)
				.data("origWidth", $(this).width())
				.width(0)
				.animate({
					width: $(this).data("origWidth")
				}, 1200);
		});
	} catch(err) {

	}

	/* ---------------------------------------------------------------------- */
	/*	menu responsive
	/* ---------------------------------------------------------------------- */
	var menuClick = $('a.elemadded'),
		navbarVertical = $('.menu-box');

	menuClick.on('click', function(e){
		e.preventDefault();

		if( navbarVertical.hasClass('active') ){
			navbarVertical.slideUp(300).removeClass('active');
		} else {
			navbarVertical.slideDown(300).addClass('active');
		}
	});

	winDow.bind('resize', function(){
		if ( winDow.width() > 768 ) {
			navbarVertical.slideDown(300).removeClass('active');
		} else {
			navbarVertical.slideUp(300).removeClass('active');
		}
	});

	/* ---------------------------------------------------------------------- */
	/*	Contact Form
	/* ---------------------------------------------------------------------- */

	var submitContact = $('#submit_contact'),
		message = $('#msg');

	submitContact.on('click', function(e){
		e.preventDefault();

		var $this = $(this);

		$.ajax({
			type: "POST",
			url: 'contact.php',
			dataType: 'json',
			cache: false,
			data: $('#contact-form').serialize(),
			success: function(data) {

				if(data.info !== 'error'){
					$this.parents('form').find('input[type=text],textarea,select').filter(':visible').val('');
					message.hide().removeClass('success').removeClass('error').addClass('success').html(data.msg).fadeIn('slow').delay(5000).fadeOut('slow');
				} else {
					message.hide().removeClass('success').removeClass('error').addClass('error').html(data.msg).fadeIn('slow').delay(5000).fadeOut('slow');
				}
			}
		});
	});

});

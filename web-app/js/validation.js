
// Character restriction
!function ($) {
	
	$(function () {
		$('.numbersOnly').keyup(function () { 
		    //this.value = this.value.replace(/[^0-9\.]/g,'');
		    var val = $j(this).val();
		    if(isNaN(val)){
		         val = val.replace(/[^0-9\.]/g,'');
		         if(val.split('.').length>2) val =val.replace(/\.+$/,"");
		    }
		    $j(this).val(val); 
		});
		
		$('.alphaOnly').keyup(function () { 
		    this.value = this.value.replace(/[0-9!"#$%&'()*+,-.\/:;<=>?@[\]^_`{|}~]/ig,''); 
		});
	})
	
}(window.jQuery);


// Limit character count
!function ($) {
	
	$(function () {
		$('.input-mini').keyup(function() {
			var $this = $(this);
			if($this.val().length > 8)
				$this.val($this.val().substr(0, 8));			
		});
		
		$('.input-small').keyup(function() {
			var $this = $(this);
			if($this.val().length > 12)
				$this.val($this.val().substr(0, 12));			
		});
		
		$('.input-medium').keyup(function() {
			var $this = $(this);
			if($this.val().length > 20)
				$this.val($this.val().substr(0, 20));			
		});
		
		$('.input-large').keyup(function() {
			var $this = $(this);
			if($this.val().length > 30)
				$this.val($this.val().substr(0, 30));			
		});
		
		$('.input-xlarge').keyup(function() {
			var $this = $(this);
			if($this.val().length > 40)
				$this.val($this.val().substr(0, 40));			
		});
		
		$('.input-xxlarge').keyup(function() {
			var $this = $(this);
			if($this.val().length > 255)
				$this.val($this.val().substr(0, 255));			
		});
	})

}(window.jQuery);

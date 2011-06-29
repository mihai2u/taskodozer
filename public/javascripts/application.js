var Site = {
  Common: {
    init: function(e) {
      $('body').removeClass('nojs').addClass('js');
    },
    prettyPhotoInit: function(e) {
      $.expr[':'].linkingToImage = function(elem, index, match){
        return $(elem).is('a') && elem.href && (/\.(gif|jpe?g|png|bmp)$/).test(elem.href);
      };
      if (typeof $.fn.prettyPhoto != 'undefined') {
        $("a:linkingToImage").prettyPhoto({
	        animation_speed:'normal', 
	        theme: 'pp_default', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
	        show_title:true,
	        social_tools: false
	    });
      };
    },
    prettyTextareaInit: function(e) {
      if (typeof $.fn.autoGrow != 'undefined') {
        $('textarea').autoGrow();
	   }
    },
    filterTasksInit: function(e) {
      $('#filter-tasks-late').click(function() {
        $('.task').hide();
        $('.task-late').show();
        return false;
      });
      $('#filter-tasks-today').click(function() {
        $('.task').hide();
        $('.task-today').show();
        return false;
      });
      $('#filter-tasks-tomorrow').click(function() {
        $('.task').hide();
        $('.task-tomorrow').show();
        return false;
      });
      $('#filter-tasks-imp').click(function() {
        $('.task').hide();
        $('.imp').parent().parent().show();
        return false;
      });
      $('#filter-tasks-all').click(function() {
        $('.task').show();
        return false;
      });
    }
  },
  Forms: {
  	fileInput: function(e) {
  	  $('div.file input[type=file]').each(function(){
	    $(this).addClass('file').addClass('hidden');
	    $(this).parent().append($('<div class="fakefile" />').append($('<input type="text" value="" />').attr('id',$(this).attr('id')+'__fake')).append($('<a class="upload">Upload</a>')));
	    $('#'+$(this).attr('id')+'__fake').val($(this).val());;
	    
	    $(this).bind('change', function() {
	      $('#'+$(this).attr('id')+'__fake').val($(this).val());;
	    });
	    $(this).bind('mouseout', function() {
	      if ( $(this).val() != '' ) {
	        $('#'+$(this).attr('id')+'__fake').val($(this).val());;
	      }
	    });
	   });
  	},
    dateInput: function(e) {
      if (typeof $.fn.datepicker != 'undefined') {
        $('input.ui-datepicker').datepicker({dateFormat: 'yy-mm-dd'});
        $('.task .date').click(function() {
          $(this).find('.ui-datepicker').first().focus();
        });
        $('.task .date input').change(function(){
          $(this).parent().submit();
        });
      }
    }
  }
};

$(document).ready(function() {
  Site.Common.init();
  Site.Common.prettyPhotoInit();
  Site.Common.prettyTextareaInit();
  Site.Common.filterTasksInit(); 
  Site.Forms.dateInput();
});
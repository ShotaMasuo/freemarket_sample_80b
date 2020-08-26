$(function(){
  $(".item__category").hover(
    function(){
      $(".menuWrapper__itemMenuWrapper__item__category").addClass("display_block");
    },
    function(){
      $(".menuWrapper__itemMenuWrapper__item__category").removeClass("display_block");
    }
  );
  $(".item__brand").hover(
    function(){
      $(".menuWrapper__itemMenuWrapper__item__brand").addClass("display_block");
    },
    function(){
      $(".menuWrapper__itemMenuWrapper__item__brand").removeClass("display_block");
    }
  );

  $(".parent").hover(
    function(){
      $(this).children('ul').addClass("display_block");
    },
    function(){
      $(this).children('ul').removeClass("display_block");
    }
  )
  $(".child").hover(
    function(){
      $(this).children('ul').addClass("display_block");
    },
    function(){
      $(this).children('ul').removeClass("display_block");
    }
  )

  $("#input-text").on("keyup", function() {
    let countNum = String($(this).val().length);
    $("#counter").text(countNum + "文字");
  });

  $(document).on('click', '.favorite-item', function(e){
    e.preventDefault();
    let itemId = $(this).attr("id")
    let userId = $(this).attr("data-user-id")
    let url = "/items/" + itemId + "/favorite"
    $.ajax({
      type: "POST",
      url: url,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      $('.favoritesNumber').text(data.favorite_num);
      if(data.flug == 1){
        $('.favorite-item').addClass("addFavorite");
      } else {
        $('.favorite-item').removeClass("addFavorite");
      }
    })
  })
});
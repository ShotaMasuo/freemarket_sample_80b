$(document).on('turbolinks:load', function(){
  $(function(){
    function appendOption(category){
      var html =`<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    
    // 子カテゴリーの作成
    function appendChildrenBox(insertHTML){
      var childSelectHTML = '';
      childSelectHTML =`<div class=' category_added' id= 'children_wrapper'>
                          <div class=' category_1' >
                            <select class= "category_select" id="child_category" name="item[category_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                             </select>
                          </div>
                        </div>`;
      $('.category').append(childSelectHTML);
    }

    //孫カテゴリーの作成
    function appendGrandchildrenBox(insertHTML){
      var grandchildSelectHTML = '';
      grandchildSelectHTML =` <div class=' category_added' id= 'grandchildren_wrapper'>
                                <div class=' category_2' >
                                  <select class= "category_select_box" id="grandchild_category" name="item[category_id]">
                                    <option value="---" data-category="---">---</option>
                                    ${insertHTML}
                                  </select>
                                </div>
                              </div>`;
      $('.category').append(grandchildSelectHTML);
    }

    // 親カテゴリー選択後のイベント
    $('#category').on('change', function(){
      var category_id = document.getElementById
      ('category').value; //選択された親カテゴリーの名前を取得
      if (category_id != "---"){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/category/get_category_children',
          type: 'GET',
          data: { category_id: category_id},
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
          $('#grandchildren_wrapper').remove();
          $('#child_category').remove(); //編集時親が変更された時、子以下を削除する
          $('#grandchild_category').remove();
          var insertHTML ='';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリーの取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
        $('#grandchildren_wrapper').remove();
      }
    });

    // 子カテゴリー選択後のイベント
    $('.category').on('change', '#child_category', function(){
      var child_category_id = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      if (child_category_id != "---"){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url:'/items/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id},
          dataType: 'json'
        })
        .done(function(grandchildren){
            if (grandchildren.length != 0){
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
            var insertHTML ='';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
              appendGrandchildrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリの取得に失敗しました')
        })
      }else{
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });
  });
});
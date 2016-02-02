$(function(){

  var searchForm = $(".search-form");
  ajax.searchListener(searchForm, callbacks.results)

})

var ajax = {
  searchListener: function(el, callback){
    el.on("submit", function(e){
      e.preventDefault();
      var searchField = $("[name='keyword']");
      var listsCheckbox = $("[name='include[list]']");
      var tasksCheckbox = $("[name='include[task]']");
      if ((searchField.val() == "") || ((!listsCheckbox.is(':checked')) && (!tasksCheckbox.is(':checked')))){
        $("#flash").html("<div class='alert alert-danger'>Enter search term with at least one box checked.");
      } else {
        var url = this.getAttribute('action');
        var method = this.getAttribute('method');
        var $form = $(this);
        $.ajax({
          url: url,
          method: method,
          data: $form.serialize(),
          success: callback
        })
      }
    })
  }
}

var callbacks = {
  results: function(dataBack){
    $(".list-results").html("");
    $(".task-results").html("");
    $(".list-results").html(dataBack.list_results);
    $(".task-results").html(dataBack.task_results);
  }
}

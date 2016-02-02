"use strict"

$(function(){

  function Ajax() { }
  Ajax.prototype = {
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
    },
    priorityFilterListener: function(parent, el){
      parent.on("change", el, function(e){
        var priority = $("select#task-filter").val();
        var deleteCheckbox = $(".task[type='checkbox']");
        if ((deleteCheckbox.is(':checked'))){
          if (priority != "all"){
            $(".task-table tr:contains("+priority+")").show();
            $(".task-table tr:not(:contains("+priority+"))").hide();
          } else {
            $(".task-table tr:contains("+priority+")").show();
          }
        } else {
          if (priority != "all"){
            $(".task-table tr:contains("+priority+"):not(:contains('☓'))").show();
            $(".task-table tr:not(:contains("+priority+")):not(:contains('☓'))").hide();
          } else {
            $(".task-table tr:contains("+priority+"):not(:contains('☓'))").show();
          }
        }
      })
    },
    usernameFilterListener: function(parent, el){
      parent.on("change", el, function(e){
        var username = $("select#list-filter").val()
        var deleteCheckbox = $(".list[type='checkbox']");
        if ((deleteCheckbox.is(':checked'))){
          if (username != "all"){
            $(".list-table tr").show();
            $(".list-table tr:not(:contains("+username+"))").hide();
          } else {
            $(".task-table tr").show();
          }
        } else {
          if (username != "all"){
            $(".list-table tr:not(:contains('☓'))").show();
            $(".list-table tr:not(:contains("+username+")):not(:contains('☓'))").hide();
          } else {
            $(".task-table tr:not(:contains('☓'))").show();
          }
        }
      })
    },
    deletedFilterListener: function(parent, el){
      parent.on("change", el, function(e){
        var resultsType = this.className.split(" ")[1];
        var selectFilter = $("#"+resultsType+"-filter").val();
        if (selectFilter != "all"){
          if ($(this).is(":checked")){
            $("."+resultsType+"-table tr:contains('☓'):contains("+selectFilter+")").show();
          } else {
            $("."+resultsType+"-table tr:contains('☓'):contains("+selectFilter+")").hide();
          }
        } else {
          if ($(this).is(":checked")){
            $("."+resultsType+"-table tr:contains('☓')").show();
          } else {
            $("."+resultsType+"-table tr:contains('☓')").hide();
          }
        }
      })
    }
  }

  function Callbacks() { }
  Callbacks.prototype = {
    results: function(dataBack){
      $(".list-results").html("");
      $(".task-results").html("");
      $(".list-results").html(dataBack.list_results);
      $(".task-results").html(dataBack.task_results);
      $(".deleted[type='checkbox']").prop('checked', false);
      $("tr:contains('☓')").hide();
    }
  }

  function OptionChecker(){ }
  OptionChecker.prototype.check = function(){
    $(".search-option").prop('checked', true);
  }

  var ajax = new Ajax();
  var callbacks = new Callbacks();
  var optionChecker = new OptionChecker();
  var searchForm = $(".search-form");
  var selectTaskParent = $(".task-results");
  var selectListParent = $(".list-results");
  var selectTaskEl = "select#task-filter";
  var selectListEl = "select#list-filter";
  var deleteParent = $(".results");
  var deleteEl = ".deleted[type='checkbox']";
  optionChecker.check();
  ajax.searchListener(searchForm, callbacks.results);
  ajax.priorityFilterListener(selectTaskParent, selectTaskEl);
  ajax.usernameFilterListener(selectListParent, selectListEl);
  ajax.deletedFilterListener(deleteParent, deleteEl);

});

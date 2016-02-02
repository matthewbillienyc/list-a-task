"use strict"

$(function(){

  var listsDiv = $(".lists-div");
  var deleteListEl = ".delete-list";
  var deleteTaskEl = ".delete-task";
  var priorityEl = ".priority";
  var descriptionEl = ".description";
  var prioritySelect = "select#task_priority";
  var descriptionField = ".description-field";
  var addListBtn = $("#add-list");
  var addTaskBtn = $(".add-task");
  var starForms = "#star-form";
  var unstarForms = "#unstar-form";
  listChecker.check();
  ajax.addListener(addTaskBtn, taskAppender.addListeners);
  ajax.addListener(addListBtn, listAppender.addListeners);
  ajax.delegateDblclick(listsDiv, priorityEl, ajax.updateTaskListener);
  ajax.delegateDblclick(listsDiv, descriptionEl, ajax.updateTaskListener);
  ajax.addDelegate(listsDiv, starForms, starCallbacks.star);
  ajax.addDelegate(listsDiv, unstarForms, starCallbacks.unstar);
  ajax.addDelegate(listsDiv, deleteTaskEl, deleteCallbacks.deleteTask);
  ajax.addDelegate(listsDiv, deleteListEl, deleteCallbacks.deleteList);
  ajax.delegateDblclick(listsDiv, priorityEl, editCallbacks.priorityEdit);
  ajax.delegateDblclick(listsDiv, descriptionEl, editCallbacks.descriptionEdit);
  ajax.updateTaskListener(listsDiv, prioritySelect, editCallbacks.priorityUpdate);
  ajax.updateTaskListener(listsDiv, descriptionField, editCallbacks.descriptionUpdate);

});

function ListChecker(){ }
ListChecker.prototype = {
  check: function(){
    var lists = $(".list");
    if (lists.length == 0){
      $(".add-task").hide();
    } else {
      $(".add-task").show();
    }
  }
}

function Ajax() { }
Ajax.prototype = {
  addListener: function(el, callback){
    el.on("submit", function(e){
      e.preventDefault();
      var url = this.getAttribute('action');
      var method = this.getAttribute('method');
      var $form = $(this);
      $.ajax({
        url: url,
        method: method,
        data: $form.serialize(),
        success: callback
      })
    })
  },
  addDelegate: function(parent, el, callback){
    parent.on("submit", el, function(e){
      e.preventDefault();
      var url = this.getAttribute('action');
      var method = this.getAttribute('method');
      var $form = $(this);
      $.ajax({
        url: url,
        method: method,
        data: $form.serialize(),
        success: callback
      })
    })
  },
  delegateDblclick: function(parent, el, callback){
    parent.on("dblclick", el, function(e){
      var className = this.className;
      var taskId = this.getAttribute('data-id');
      var url = '/tasks/'+taskId+'/'+className;
      $.ajax({
        url: url,
        method: 'get',
        success: callback
      })
    })
  },
  updateTaskListener: function(parent, el, callback){
    parent.on("blur", el, function(e){
      var $form = $(this).parent();
      $.ajax({
        url: $form.attr('action'),
        method: 'patch',
        data: $form.serialize(),
        success: callback
      })
    })
  }
}

function StarCallbacks() { }
StarCallbacks.prototype = {
  star: function(dataBack){
    var stype = dataBack.star.starable_type.toLowerCase();
    $("#"+stype+"-"+dataBack.star.starable_id+" .star-span").html(dataBack.unstar_partial);
  },
  unstar: function(dataBack){
    var stype = dataBack.starable_type.toLowerCase();
    $("#"+stype+"-"+dataBack.starable_id+" .star-span").html(dataBack.star_partial);
  }
}

function DeleteCallbacks() { }
DeleteCallbacks.prototype = {
  deleteList: function(dataBack){
    $("#whole-list-"+dataBack.list_id).remove();
    $("option[value='"+dataBack.list_id+"']").remove();
    new ListChecker().check();
  },
  deleteTask: function(dataBack){
    $("#task-"+dataBack.task_id).remove();
  }
}

function EditCallbacks() { }
EditCallbacks.prototype = {
  priorityEdit: function(dataBack){
    var prioritySelect = $(".priority[data-id="+dataBack.task.id+"]");
    prioritySelect.html(dataBack.priority_partial);
  },
  descriptionEdit: function(dataBack){
    var description = $(".description[data-id="+dataBack.task.id+"]");
    description.html(dataBack.description_partial);
  },
  priorityUpdate: function(dataBack){
    var priority = $(".priority[data-id="+dataBack.task.id+"]");
    priority.html(dataBack.task.priority);
  },
  descriptionUpdate: function(dataBack){
    var description = $(".description[data-id="+dataBack.task.id+"]");
    description.html(dataBack.task.description);
  }
}

function ListAppender() { }
ListAppender.prototype = {
  addListeners: function(dataBack){
    if (dataBack.list_partial) {
      $(".lists-div").append(dataBack.list_partial);
      $("#task_list_id").append(dataBack.options_partial);
      $("#add-list input[type='text']").val("");
      $("#flash").html("");
      new ListChecker().check();
    } else {
      $("#flash").html(dataBack.flash_partial);
    }
  }
}

function TaskAppender() { }
TaskAppender.prototype = {
  addListeners: function(dataBack){
    if (dataBack.task){
      $("#whole-list-"+dataBack.task.list_id+" ul").append(dataBack.task_partial);
      $(".add-task textarea").val("");
      $("#flash").html("")
    } else {
      $("#flash").html(dataBack.flash_partial);
    }
  }
}

var listChecker = new ListChecker();
var taskAppender = new TaskAppender();
var listAppender = new ListAppender();
var ajax = new Ajax();
var starCallbacks = new StarCallbacks();
var deleteCallbacks = new DeleteCallbacks();
var editCallbacks = new EditCallbacks();

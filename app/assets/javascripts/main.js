"use strict"

$(function(){

  listChecker();
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
  ajax.addListener(addTaskBtn, taskAppender.addListeners);
  ajax.addListener(addListBtn, listAppender.addListeners);
  ajax.delegateDblclick(listsDiv, priorityEl, listChecker)
  ajax.delegateDblclick(listsDiv, descriptionEl, listChecker)
  ajax.addDelegate(listsDiv, starForms, starCallbacks.star);
  ajax.addDelegate(listsDiv, unstarForms, starCallbacks.unstar);
  ajax.addDelegate(listsDiv, deleteTaskEl, deleteCallbacks.deleteTask);
  ajax.addDelegate(listsDiv, deleteListEl, deleteCallbacks.deleteList);
  ajax.delegateDblclick(listsDiv, priorityEl, editCallbacks.priorityEdit);
  ajax.delegateDblclick(listsDiv, descriptionEl, editCallbacks.descriptionEdit);
  ajax.updateTaskListener(listsDiv, prioritySelect, editCallbacks.priorityUpdate);
  ajax.updateTaskListener(listsDiv, descriptionField, editCallbacks.descriptionUpdate);

})

var listChecker = function(){
  var lists = $(".list");
  if (lists.length == 0){
    $(".add-task").hide();
  } else {
    $(".add-task").show()
  }
}

var ajax = {
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

var starCallbacks = {
  star: function(dataBack){
    var stype = dataBack.star.starable_type.toLowerCase();
    $("#"+stype+"-"+dataBack.star.starable_id+" .star-span").html(dataBack.unstar_partial);
  },
  unstar: function(dataBack){
    var stype = dataBack.starable_type.toLowerCase();
    $("#"+stype+"-"+dataBack.starable_id+" .star-span").html(dataBack.star_partial);
  }
}

var deleteCallbacks = {
  deleteList: function(dataBack){
    $("#whole-list-"+dataBack.list_id).remove();
    $("option[value='"+dataBack.list_id+"']").remove();
  },
  deleteTask: function(dataBack){
    $("#task-"+dataBack.task_id).remove();
  }
}

var editCallbacks = {
  priorityEdit: function(dataBack){
    var prioritySelect = $(".priority[data-id="+dataBack.task.id+"]");
    prioritySelect.html(dataBack.priority_partial);
    var dropdown = $("#edit_task_"+dataBack.task.id+" select");
  },
  descriptionEdit: function(dataBack){
    var description = $(".description[data-id="+dataBack.task.id+"]");
    description.html(dataBack.description_partial);
    var descriptionField = $("#edit_task_"+dataBack.task.id+" input");
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

var listAppender = {
  addListeners: function(dataBack){
    if (dataBack.list_partial) {
      $(".lists-div").append(dataBack.list_partial);
      $("#task_list_id").append(dataBack.options_partial);
      $("#add-list input[type='text']").val("");
      $("#flash").html("");
      listChecker();
    } else {
      $("#flash").html(dataBack.flash_partial);
    }
  }
}

var taskAppender = {
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

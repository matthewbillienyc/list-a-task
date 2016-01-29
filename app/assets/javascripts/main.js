$(function(){

  checkForLists();
  var deleteListBtns = $(".delete-list");
  var deleteTaskBtns = $(".delete-task");
  var newTaskBtn = $(".add-task");
  var taskBtns = $(".delete-task");
  var starListBtns = $(".list-star #star-btn");
  var starTaskBtns = $(".task-star #star-btn");
  var unstarListBtns = $(".list-star #unstar-btn");
  var unstarTaskBtns = $(".task-star #unstar-btn");
  var priorities = $(".priority");
  var descriptions = $(".description");
  addListListener();
  addDeleteTaskListener.call(taskBtns);
  addDeleteListener.call(deleteListBtns);
  addDeleteTaskListener.call(deleteTaskBtns);
  addNewTaskListener.call(newTaskBtn);
  addStarListener.call(starListBtns);
  addStarListener.call(starTaskBtns);
  addUnstarListener.call(unstarListBtns);
  addUnstarListener.call(unstarTaskBtns);
  addPriorityListener.call(priorities);
  addDescriptionListener.call(descriptions);

  function addListListener(){
    $("#add-list").on("ajax:success", function(e, data){
      if (data.list_partial) {
        $(".lists-div").append(data.list_partial);
        checkForLists();
        var deleteBtns = $(".delete-list");
        var starBtn = $("#list-"+data.list.id+" .star-span #star-btn");
        addDeleteListener.call(deleteBtns);
        addStarListener.call(starBtn);
        $("#task_list_id").append(data.options_partial);
        $("#add-list input[type='text']").val("");
        $("#flash").html("")
      } else {
        $("#flash").html(data.flash_partial);
      }
    })
  }

  function addUnstarListener(){
    this.on("ajax:success", function(e, data){
      var stype = data.starable_type.toLowerCase();
      $("#"+stype+"-"+data.starable_id+" .star-span").html(data.star_partial);
      var starBtn = $("#"+stype+"-"+data.starable_id+" .star-span #star-btn");
      addStarListener.call(starBtn);
    })
  }

  function addStarListener(){
    this.on("ajax:success", function(e, data){
      var stype = data.star.starable_type.toLowerCase();
      $("#"+stype+"-"+data.star.starable_id+" .star-span").html(data.unstar_partial);
      var unstarBtn = $("#"+stype+"-"+data.star.starable_id+" .star-span #unstar-btn");
      addUnstarListener.call(unstarBtn);
    })
  }

  function addPriorityListener(){
    this.dblclick(function(){
      var taskId = this.getAttribute("data-id");
      $.ajax({
        url: '/tasks/' + taskId + '/priority',
        method: 'get',
        data: null,
        success: function(dataBack){
          var prioritySelect = $("span.priority[data-id="+dataBack.task.id+"]");
          prioritySelect.html(dataBack.priority_partial);
          var dropdown = $("#edit_task_"+dataBack.task.id+" select");
          addUpdatePriorityListener.call(dropdown);
        }
      })
    })
  }

  function addUpdatePriorityListener(){
    this.blur(function(){
      var $form = $(this).parent()
      $.ajax({
        url: $form.attr('action'),
        method: 'patch',
        data: $form.serialize(),
        success: function(dataBack){
          var priority = $(".priority[data-id="+dataBack.task.id+"]");
          priority.html(dataBack.task.priority);
          addPriorityListener.call(priority);
        }
      })
    })
  }

  function addDescriptionListener(){
    this.dblclick(function(){
      var taskId = this.getAttribute("data-id");
      $.ajax({
        url: '/tasks/'+taskId+'/description',
        method: 'get',
        data: null,
        success: function(dataBack){
          var description = $(".description[data-id="+dataBack.task.id+"]");
          description.html(dataBack.description_partial);
          var descriptionField = $("#edit_task_"+dataBack.task.id+" input");
          addUpdateDescriptionListener.call(descriptionField);
        }
      })
    })
  }

  function addUpdateDescriptionListener(){
    this.blur(function(){
      var $form = $(this).parent()
      $.ajax({
        url: $form.attr('action'),
        method: 'patch',
        data: $form.serialize(),
        success: function(dataBack){
          var description = $(".description[data-id="+dataBack.task.id+"]");
          description.html(dataBack.task.description);
          addDescriptionListener.call(description);
        }
      })
    })
  }

  function addDeleteListener(){
    this.on("ajax:success", function(e, data){
      $("#whole-list-"+data.list_id).remove();
      $("option[value='"+data.list_id+"']").remove()
      checkForLists();
    })
  }

  function addNewTaskListener(){
    this.on("ajax:success", function(e, data){
      if (data.task) {
        $("#whole-list-"+data.task.list_id+" ul").append(data.task_partial)
        var taskDeletes = $(".delete-task");
        var starBtn = $("#task-"+data.task.id+" .star-span #star-btn");
        var priority = $(".priority[data-id="+data.task.id+"]");
        var description = $(".description[data-id="+data.task.id+"]");
        addPriorityListener.call(priority);
        addDescriptionListener.call(description);
        addStarListener.call(starBtn);
        addDeleteTaskListener.call(taskDeletes);
        $(".add-task textarea").val("")
        $("#flash").html("")
      } else {
        $("#flash").html(data.flash_partial)
      }
    })
  }

  function addDeleteTaskListener(){
    this.on("ajax:success", function(e, data){
      $("#task-"+data.task_id).remove()
    })
  }

  function checkForLists(){
    var lists = $(".list");
    if (lists.length == 0){
      $(".add-task").hide();
    } else {
      $(".add-task").show()
    }
  }

})

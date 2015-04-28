# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@setStatus = () ->
   selector = document.getElementById("status_selector")
   selectedValue = selector.options[selector.selectedIndex].value;

   task_id = $("#task_id").val()

   console.log "Task ID: " + task_id
   console.log "Selected: " + selectedValue

   $.post(
      "/edit_task",
     {
       id: task_id,
       status: selectedValue
     },
     onAjaxSuccess
   );
 
onAjaxSuccess = (data) ->
	console.log "Task status change succeed"



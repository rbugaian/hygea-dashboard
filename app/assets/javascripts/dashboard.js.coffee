# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

# #counter = 0

# #@playSound = (audioPath) -> 
# 	#audio = new Audio(audioPath)
# 	#audio.play()
# 	#console.log 'Play pressed'
# 	#'hello'

# @stopRefresher = () ->
# 	clearInterval(@intervalId)
root = exports ? this

root.intervalId = -> 0

@setRefresher = () ->
	root.intervalId = setInterval(refresh, 30000)
	

refresh = () ->
	$.ajax
		url: '/tasks_section'
		type: 'POST'
		success: (data, status, response) ->
			console.log('Reload success')
			page = window.location.href.split('/').pop()

			if page == 'tasks_section' || page == ''
				console.log('Current URL: ' + page)
				document.getElementById('section_container').innerHTML = data
			else 
				console.log('Interval cleared id: ' + root.intervalId) 
				clearInterval(root.intervalId)
			

		error: ->
			console.log('Reload error')

	# divs = document.querySelectorAll('[executeat]');
	# checkTasks(divs)

# @setActivator = () ->
# 	divs = document.querySelectorAll('[executeat]');
# 	console.log "DIVS: " + divs.length 

# 	setInterval(checkTasks(divs), 5000)

	


# checkTasks = (divs) ->

# 	console.log "Checking task time."

# 	for div in divs
# 		do (div) -> 
# 			divValue = div.getAttribute("executeat")
			
# 			now = new Date;
# 			utc_timestamp = Date.UTC(now.getUTCFullYear(),now.getUTCMonth(), now.getUTCDate() , now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds(), now.getUTCMilliseconds());
# 			#currentTime = new Date().getTime()

# 			intValue = parseInt(divValue)
# 			intCurrent = parseInt(utc_timestamp)

# 			if (intValue > intCurrent - 30000 && intValue < intCurrent + 30000) 
# 				console.log "We have right div!"

# printText = (text) ->
# 	#counter += 1
# 	#text = "Printed counter: " + counter

# 	fetchTaskList()

# 	console.log(text)

# @setTimer = () ->
# 	setInterval(printText, 5000)

# fetchTaskList = () ->
# 	$.ajax
# 		url: '/list/tasks'
# 		type: 'GET'
# 		success: (data, status, response) -> 
			
# 			#console.log('Success: ' + JSON.stringify(data))

# 			taskArray = data.tasks

# 			#console.log('Tasks Array: ' + JSON.stringify(taskArray))

# 			for task in taskArray
# 				do (task) ->
# 					#console.log("Date: " + Date.parse(task.date_to_execute))
# 					#console.log("Current Date: " + (new Date).getTime())

# 					tasksDate = Date.parse(task.date_to_execute)
# 					currentDate = (new Date).getTime()

# 					if task.was_shown == false && tasksDate > tasksDate - 30000 && currentDate + 30000 > currentDate
# 						task.was_shown = true
# 						alert(task.title)
						
					

# 		error: ->
# 			console.log('Error')



# 	
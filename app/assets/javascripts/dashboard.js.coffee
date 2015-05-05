# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

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
 	
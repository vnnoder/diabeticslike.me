# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

current_id = 100
renderTask = (task_name) ->
  task_template =[
    '<li class="process">',
    "<input type='checkbox' id='#{current_id}'>",
    "<label for='2'>  #{task_name} </label>",
    '</li>'
  ]
  current_id = current_id + 1
  task_template.join('')

jQuery.fn.addTask = () ->
  this.each(->
    $(this).click(() ->
      taskName = $('#add-new-task').val()
      taskHTML = renderTask(taskName)
      $('#todolist').append(taskHTML)
    )
  )

jQuery.fn.imagePulicProfile = () ->
  this.each( ->
    $(this).click((event) ->
      profileID = $(event.currentTarget).attr('image-id')
      window.location.href = "/profile/public/#{profileID}"
    )
  )
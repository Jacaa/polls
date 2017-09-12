# Create new input after 'keyup' action
$(document).on 'keyup', 'input[name="poll[answers][]"]:last', ->
  number_of_next_inputs = $('input[name="poll[answers][]"]').length + 1
  id = 'poll_answers_' + number_of_next_inputs
  new_answer_input = "<input class='form-control' type='string'
                       placeholder='enter new answer...'
                       value='' name='poll[answers][]' id='" + id + "'>" 
  $(".poll_answers").append(new_answer_input)

$(document).on 'turbolinks:load', ->
  
  $('.filled').each ->
    width = $(@).attr('id')
    $(@).css("width", width + '%')
    opacity = width/100
    $(@).css("opacity", opacity)
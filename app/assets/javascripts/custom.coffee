# Create new input after 'keyup' action
$(document).on 'keyup', 'input[name="poll[answers][]"]:last', ->

  number_of_next_inputs = $('input[name="poll[answers][]"]').length + 1
  id = 'poll_answers_' + number_of_next_inputs
  new_answer_input = "<input class='form-control' type='string'
                       placeholder='enter new answer...'
                       value='' name='poll[answers][]' id='" + id + "'>" 
  $(".poll_answers").append(new_answer_input)

$(document).on 'turbolinks:load', ->
  
  # Change cookies info
  $('.cookies-eu-content-holder').text('This website uses cookies. By continuing to use this site you agree to the use of cookies.')

  # Focus poll_question input
  $(@).find('#poll_question').focus()

  if window.location.pathname.match('results')
    colors = ['#359e2c', # green
              '#2c7f9e', # cyan
              '#9e2c2c', # red
              '#af6401', # orange
              '#6b6b6b', # dark grey
              '#888888', # medium grey
              '#b5b5b5'] # light grey

    # If there are more answers than 7 set their color to very light grey
    filled_divs = $('.filled')
    if filled_divs.length > 6
      for i in [1...(filled_divs.length-6)]
        colors.push('#d2d2d2')

    # Set width and color of every .filled div
    percentages = $('#poll-chart').data().percentages
    for div, index in filled_divs
      $(div).css("background-color", colors[index])
      $(div).css("width", percentages[index])
  
    # Draw a chart
    ctx = $('#resultChart')
    chart = new Chart(ctx,
      type: 'doughnut'
      data:
        labels: percentages
        datasets: [ {
          data: $('#poll-chart').data().votes
          
          backgroundColor: colors
          borderColor: '#3E3E3E'
          borderWidth: 2
        } ]
      options:
        legend:
          display: false
        tooltips:
          backgroundColor: '#3E3E3E'
          displayColors: false
          bodyFontSize: 16
          bodyFontColor: '#DDD'
          caretSize: 0
          callbacks:
            label: (tooltipItem, data) ->
              tooltipLabel = data.labels[tooltipItem.index]
              return tooltipLabel
    )
class ArrayInput < SimpleForm::Inputs::StringInput

  # Source: https://railsguides.net/simple-form-array-text-input/
  
  def input(wrapper_options)
    input_html_options[:type] ||= input_type
    
    number_of_input = 0
    Array(object.public_send(attribute_name)).map do |array_el|
      number_of_input += 1
      @builder.text_field(nil, input_html_options.merge(
                                 value: array_el, 
                                 name: "#{object_name}[#{attribute_name}][]", 
                                 class: "form-control", 
                                 id: "poll_answers_#{number_of_input}",
                                 placeholder: "enter new answer..."
                               )
                         )
    end.join.html_safe
  end

  def input_type
    :string
  end
end
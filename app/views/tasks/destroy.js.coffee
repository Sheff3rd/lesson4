$("#task_<%= params[:id] %>").slideUp()
$("#count").hide().html("(<%= current_list.tasks_count %>)").show()

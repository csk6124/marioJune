# Put your handlebars.js helpers here.
Handlebars.registerHelper 'pick', (val, options) ->
	console.log 'help'
	return options.hash[val]


Handlebars.registerHelper 'checked', (currentValue) ->
	console.log 'currentValue', currentValue
	value = if currentValue is true then ' checked="checked"' else ''


Handlebars.registerHelper 'selected', (select, options) ->
	console.log 'selected', select, options
	#value = if select is value then ' selected ' else ''


###
module table templete helper
###
Handlebars.registerHelper 'table_row', (context, options) ->
	
	ret = ""
	_.each this.dataFields, (data) =>
		if data.name is 'modify'
			if this.editor is true
				ret += "<td><button id='modify' class='btn-flat default' >OK</button></td>"
			else 
				ret += "<td><button id='modify' class='btn-flat default' >Modify</button></td>"

		else if data.name is 'delete'
			ret += "<td><button id='delete' class='btn-flat gray' >Del</button></td>"
		else if data.name is 'view'
			ret += "<td><button id='view' class='btn-flat default' >통계</button></td>"
		else if data.name is 'allow'
			ret += "<td><button id='allow' class='btn-flat default' >ALLOW</button></td>"
		else if data.hasOwnProperty("class")
			if this.editor is true and data.editor_field is true
				ret += "<td class='" + data.class + "''><input type='text' id='" + data.name + "' class='form-control' value='" + this[data.name] + "'></td>"
			else 
				if this[data.name] is true
					ret += "<td class='" + data.class + "''><span class='label label-success'>Allowed</span></td>"
				else if this[data.name] is false
					ret += "<td class='" + data.class + "''><span class='label label-warning'>Waiting</span></td>"
				else
					ret += "<td class='" + data.class + "''>" + this[data.name] + "</td>"
		else
			if this.editor is true
				ret += "<td><input type='text' id='" + data.name + "' class='form-control' value='" + this[data.name] + "'></td>"
			else 
				ret += "<td>" + this[data.name] + "</td>"

	return ret


###
handlerbars template compare 
###
Handlebars.registerHelper "compare", (lvalue, rvalue, options) ->
  throw new Error("Handlerbars Helper 'compare' needs 2 parameters")  if arguments.length < 3
  operator = options.hash.operator or "=="
  operators =
    "==": (l, r) ->
      l is r

    "===": (l, r) ->
      l is r

    "!=": (l, r) ->
      l isnt r

    "<": (l, r) ->
      l < r

    ">": (l, r) ->
      l > r

    "<=": (l, r) ->
      l <= r

    ">=": (l, r) ->
      l >= r

    typeof: (l, r) ->
      typeof l is r

  throw new Error("Handlerbars Helper 'compare' doesn't know the operator " + operator)  unless operators[operator]
  result = operators[operator](lvalue, rvalue)
  if result
    options.fn this
  else
    options.inverse this
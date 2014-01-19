MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # FormView
#
# * Form 모듈 뷰
#
###           
class FormView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/form
	###
	template: 'templates/partials/form'


	###
	# ## events
	#
	# 	"click button#register": "eventRequest"
		"keydown": "eventKey"
	###
	events:
		"click button#register": "eventRequest"
		"keydown": "eventKey"


	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super
		
		MyApp.log 'FormView', options
		@formFields = options.params.formFields
		@ajaxPath = options.params.ajaxPath
		@title = options.params.title
		

	###
	# ## serializeData
	#
	# 	Data serialize sync with template
	###	
	serializeData: ->
		MyApp.log 'searialize', @headFields
		title: @title
		formFields: @formFields


	###
	# ## eventKey
	#
	# 	To get a keyboard event
	# 	@param: event
	# 	@return call @eventRequest
	# 	@event_on
	###	
	eventKey: (event) ->
		if event.keyCode is 13
			@eventRequest(event)


	###
	# ## eventRequest
	# 
	# 	Form등록 버튼 클릭 이벤트 발생시 서버에 요청처리 한다. 
	# 	@param: event
	# 	@return null
	# 	@event_on
	###
	eventRequest: (event) ->
		event.preventDefault()
		isFormCheckError = false
		serial_data = {}
		_.each @formFields, (data) =>
			if data.type is 'hidden'
				serial_data[data.name] = false
			else if data.type is 'private_key'
				MyApp.log 'aaaa', data.id, serial_data, serial_data[data.id]
				serial_data[data.name] = CryptoJS.SHA1(serial_data[data.id]).toString()
			else 
				val = @$el.find('#' + data.name).val()
				if @util.isNullOrEmpty(val) 
					isFormCheckError = true
				serial_data[data.name] = val

		# * Form체크가 제대로 이루어 졌는지 여부 
		if isFormCheckError is true
			MyApp.noti.show
				messages: [
					message: "Invalid, Should insert value in the input box"
					type: "warning"
				]
		else 
			MyApp.log 'dataSet', serial_data
			dataSet =
				serial_data

			datas = 
				data: dataSet
				url: MyApp.rootPath + @ajaxPath
				type: "POST"
			@util.callAjax datas, (status, data) =>
				MyApp.log 'callAjax', status, data

				if status is 'success'
					MyApp.noti.show
						messages: [
							message: "Complete send to Server"
							type: "success"
						]
					_.each @formFields, (data) =>
						MyApp.log 'aaaaaa data', data
						if data.type isnt 'hidden' and data.type isnt 'private_key'
							@$el.find('#' + data.name).val("")
				else 
					MyApp.noti.show
						messages: [
							message: "Error send to Server"
							type: "error"
						]

			MyApp.log 'eventRequest', event, datas
	

module.exports = FormView
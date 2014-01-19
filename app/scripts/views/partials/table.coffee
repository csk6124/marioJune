MyApp = require 'application'
Model = require 'scripts/models/model'
BaseView = require 'scripts/views/base'
DialogView = require 'scripts/views/partials/dialog'
Util = require 'scripts/utils/util'

###
# # ItemView
#
# * table item 모듈
#
###
class ItemView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/table_row	
	###
	template: 'templates/partials/table_row'


	###
	# ## tagName
	#
	# 	tab name setting
	###
	tagName: "tr"


	###
	# ## model
	#
	# 	model
	###
	model: Model


	###
	# ## events
	#
	# 	"click button#modify" : "eventModify"
		"click button#allow" : "eventModify"
		"click button#delete" : "eventDelete"
		"keydown": "onKey"
	###
	events:
		"click button#modify" : "eventModify"
		"click button#allow" : "eventModify"
		"click button#delete" : "eventDelete"
		"keydown": "onKey"
	

	###
	# ## initialize
	#
	# 	초기화 
	# 	@param options
	###
	initialize: (options) ->
		super

		@dataFields = options.dataFields
		@ajaxPath = options.ajaxPath
		MyApp.log 'table view init', options
		@model.set('dataFields', options.dataFields)


	###
	# ## onKey
	#
	# 	Enter key 
	# 	@param event
	###
	onKey: (event) ->
		if event.keyCode is 13
			@eventModify(event)


	###
	# ## onRender
	#
	###
	onRender: ->
		_.each @dataFields, (field) =>
			MyApp.log 'field', field
			if field.editor_field is true
				MyApp.log 'onRender dataField', field.name
				@$el.find("#" + field.name).focus() 
				return 

		MyApp.log 'onRender view'
		

	###
	# ## eventModify
	#
	# 	Click modify
	# 	@param event
	# 	@event_on
	###
	eventModify: (event) ->
		event.preventDefault()
		if @model.get('editor') is true

			serial_data = {}
			_.each @dataFields, (data) =>
				if data.editor_field is true
					val = @$el.find('#' + data.name).val()
					if val is "true"
						val = true
					else if val is "false"
						val = false

					serial_data[data.name] = val
					@model.set(data.name, serial_data[data.name])

			id = @model.get('id')
			@model.set('editor', false)

			datas = 
				data: serial_data
				url: MyApp.rootPath + @ajaxPath + id
				type: "PATCH"
			@util.callAjax datas, (status, data) =>
				MyApp.log 'callAjax', status, data

				if status is 'success'
					MyApp.noti.show
						messages: [
							message: "Completely modify"
							type: "success"
						]
				else 
					MyApp.noti.show
						messages: [
							message: "Error " + data
							type: "error"
						]

		else 
			@model.set('editor', true)
		
		@render()	


	###
	# ## eventDelete
	# 
	# 	Click delete
	# 	@param event
	# 	@event_on
	###
	eventDelete: (event) ->
		event.preventDefault()
		id = @model.get('id')
		dialog = new DialogView
			template: "templates/modals/del"
			message: "정말 삭제하시겠습니까?"
			data: 
				id: id
				model: @model
				url: MyApp.rootPath + @ajaxPath + id

		MyApp.dialogRegion.show(dialog)
		MyApp.log 'eventDelete', event



###
# # <strong>TableView</strong>
#
#   table View 모듈
#
###
class TableView extends MyApp.CompositeView
	###
	# ## template
	#
	# 	path templates/partials/table_lists
	###
	template: 'templates/partials/table_lists'


	###
	# ## itemViewContainer
	#
	# 	item container 설정
	###
	itemViewContainer: 'tbody'


	###
	# ## itemView
	#
	# 	itemView 설정
	###
	itemView: ItemView


	###
	# ## events 
	#
	# 	이벤트 설정
	# 	"click button#search": "eventSearch"
	###
	events: 
		"click button#search": "eventSearch"


	###
	# ## initialize
	# 
	# 	초기화 
	# 	@param options
	###
	initialize: (options) ->
		@headFields = options.params.headFields
		@dataFields = options.params.dataFields
		@ajaxPath = options.params.ajaxPath
		@title = options.params.title

		MyApp.log 'TableView init', options
		
		@itemViewOptions =
			dataFields: @dataFields
			ajaxPath: @ajaxPath

	###
	# ## serializeData
	#
	# 	sync
	# 	@param null
	###
	serializeData: ->
		MyApp.log 'searialize', @headFields
		title: @title
		headFields: @headFields


	###
	# ## eventSearch
	#
	# 	search button event
	# 	@param event
	# 	@event_on
	###
	eventSearch: (event) ->
		event.preventDefault()

		MyApp.log 'eventSearch'
		val = @$el.find("#search").val()

		util = new Util
		if util.isNullOrEmpty(val)
			MyApp.noti.show
				messages: [
					message: "You should insert a word in the box"
					type: "warning"
				]
			return


module.exports = TableView
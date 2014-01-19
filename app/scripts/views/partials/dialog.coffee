###
# # DialogView
#
# * 다이얼로그 모듈 뷰
#
###
MyApp = require 'application'
BaseView = require 'scripts/views/base'

class DialogView extends BaseView
	###
	# ## events
	#
	# 	"click button#delete":"eventDelete"
		"click button#cancel":"eventCancel"
	# 	@event
	###
	events:
		"click button#delete":"eventDelete"
		"click button#cancel":"eventCancel"


	###
	# ## initialize
	#
	# 	* @param options
	###
	initialize: (options) ->
		super

		@title = options.title
		@message = options.message
		@template = options.template
		@data = options.data


	###
	# ## serializeData
	#
	# 	템플릿 뷰와 데이타 동기화
	###
	serializeData: ->
		message: @message
		title: @title


	###
	# ## eventCancel
	#
	# 	cancel 버튼 이벤트 
	# 	@param event
	# 	@event_on
	###
	eventCancel: (event) ->
		event.preventDefault()
		MyApp.dialogRegion.closeDialog()


	###
	# ## eventDelete
	#
	# 	delete 버튼 이벤트 
	# 	@param event
	# 	@event_on
	###
	eventDelete: (event) ->
		event.preventDefault()
		@data.model.destroy
			url: @data.url

		MyApp.dialogRegion.closeDialog()


module.exports = DialogView
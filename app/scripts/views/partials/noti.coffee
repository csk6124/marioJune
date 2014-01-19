MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # NotiView
#
# * Noti View 모듈
#
###
class NotiView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/noti
	###
	template: 'templates/partials/noti'


	###
	# ## initialize
	#
	# 	초기화 
	# 	@param options
	###
	initialize: (options) ->
	  	super
	  	@messages = []


	###
	# ## serializeData
	#
	# 	데이타 싱크
	###
	serializeData: ->
        messages: @messages


    ###
    # ## show
    #
    # 	@param options
    ###
	show: (options) ->	
		@messages = options.messages
		MyApp.notificationRegion.show(@)

		height = @$el.hide().outerHeight(true)
		MyApp.log 'height', height
		@$el.animate
		  height: height
		, 100, ->
		  $(this).css(height: "auto").fadeIn 100

		self = @
		setTimeout ->
		  self.$el.hide()
		  MyApp.log 'hide'
		, 3000


	###
	# ## onShow
	#
	# 	@param null
	###
	onShow: ->
		MyApp.log 'onShow'
		
		
module.exports = NotiView
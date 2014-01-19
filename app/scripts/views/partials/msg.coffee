MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # MsgView
#
# * Msg View 모듈
#
###
class MsgView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/msg
	###
	template: 'templates/partials/msg'


 	###
 	# ## initialize
 	#
 	# 	초기화
 	# 	@param options
 	###
	initialize: (options) ->
		super
	

	###
	# ## serializeData
	#
	# 	데이타 싱크 with template
	###
	serializeData: ->
		msg: @msg


	###
	# ## show
	#
	# 	@param msg
	# 	@return msg
	###
	show: (msg) ->
		@msg = msg


module.exports = MsgView
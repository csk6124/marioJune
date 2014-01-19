MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # DebugView
#
# * 디버그 뷰
#
###
class DebugView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/debug
	###
	template: 'templates/partials/debug'


	###
	# ## initialize
	#
	# 	@param options
	###
	initialize: (options) ->
		super
		

module.exports = DebugView
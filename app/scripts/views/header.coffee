MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # HeaderView
#
# * Header View
#
###
class HeaderView extends BaseView
	###
	# ## template
	#
	# 	templates/header
	###
	template: 'templates/header'


	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super
		

module.exports = HeaderView
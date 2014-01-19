MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # FooterView
#
# * Footer View
#
###
class FooterView extends BaseView
	###
	# ## template
	#
	# 	templates/footer
	###
	template: 'templates/footer'


	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super
		

module.exports = FooterView
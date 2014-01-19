MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # SidebarView
#
# * Sidebar View
#
###
class SidebarView extends BaseView
	###
	# ## template
	#
	# 	templates/sidebar
	# 	@attribute
	###
	template: 'templates/sidebar'
	

	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super	


module.exports = SidebarView
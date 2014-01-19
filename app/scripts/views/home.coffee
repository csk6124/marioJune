MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # HomeView
#
# * Home View
#
###
class HomeView extends BaseView
	###
	# ## template
	#
	# 	templates/home
	###
	template: 'templates/home'


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
	# 	데이타 동기화 
	###
	serializeData: ->
		# * 테스트용도임...
		visits: "10"
		users: "1"
		crawler_resource: "10,220,123"
		     
		
module.exports = HomeView
MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # MapView
#
# * Google Map 모듈
#
###
class MapView extends BaseView
	###
	# ## template
	#
	# 	templates/partials/map
	###
	template: 'templates/partials/map'


	###
	# ## initialize
	#
	# 	@param options
	###
	initialize: (options) ->
	  	super


	###
	# ## onShow
	#
	###
	onShow: ->	
		#canvas = @$el.find("#map_canvas").html
		canvas = document.getElementById("map_canvas")
		map = new jarvisMap
		map.init(canvas)
		
		
module.exports = MapView
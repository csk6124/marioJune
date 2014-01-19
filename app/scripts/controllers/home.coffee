MyApp = require 'application'
Model = require 'scripts/models/model'
BaseController = require 'scripts/controllers/base'
HomeView = require 'scripts/views/home'
HistogramView = require 'scripts/views/partials/histogram'

###
# # HomeController
# 
# * 메인 홈
###
class HomeController extends BaseController
	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: ->
		super('home', 'home')


		###
		# ## On event Trigger 
		#
		# 	이벤트 "api_chart_request" 메세지 
		###
		MyApp.vent.on("api_chart_request", @ventChartRequest, @)


	###
	# ## ventChartRequest
	#
	# 	elastic request for chart
	# 	@param: layout
	# 	@return: spin view
	###
	ventChartRequest: ->
		MyApp.log 'ventChartRequest'
		@searchElasticLog()


	###
	# ## show
	# 
	# 	메인 뷰
	# 	@param null
	# 	@return: view
	###
	show: ->
		@view = new HomeView
		@layout.content.show(@view)
		@searchElasticLog()


	###
	# ## 
	#
	#
	###
	searchElasticLog: ->
		@layout.api_chart.show(@spin)
		@util.callAjaxForElastic (status, datas) =>
			MyApp.log 'callAjaxForElastic finish'
			@histogram = new HistogramView
				status: status
				datas: datas

			@layout.api_chart.show(@histogram)


###
# # HomeController.Collection
# 
# 	메인 홈 Collection
###
class HomeController.Collection extends MyApp.Collection
	###
	# ## model
	#
	# 	Model
	###
	model: Model


module.exports = HomeController
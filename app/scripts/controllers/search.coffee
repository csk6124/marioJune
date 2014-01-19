MyApp = require 'application'
Model = require 'scripts/models/model'
BaseController = require 'scripts/controllers/base'
SearchView = require 'scripts/views/search'
GalleryView = require 'scripts/views/partials/gallery'
MapView = require 'scripts/views/partials/map'
Msg = require 'scripts/views/partials/msg'

###
# # SearchController
# 
# * poi, 날짜, 거리, 등의 조건을 통해서 관련된 데이타를 보여준다. 
###
class SearchController extends BaseController
	###
	# ## initialize
	#
	# 	초기화 
	# 	@param options
	###
	initialize: (options) ->
		###
		# ## 이벤트 등록
		#
		# 	search_request 이벤트 등록
		###
		MyApp.vent.on('search_request', @ventSearchRequest, @)
		super('search', 'search/newSearch')


	###
	# ## show
	# 
	# 	first get category list
	# 	@param null
	###
	show: ->
		@layout.content.show(@spin)

		datas = 
			url: MyApp.rootPath + 'api/category_field?results_per_page=100'
			type: "GET"

		@util.callAjax datas, (msg, datas) =>
			object = null
			if @util.isNullOrEmpty(datas)
				object = null
			else
				object = datas.objects

			@category_datas = object
			MyApp.log 'callAjax', msg, datas
			view = new SearchView
				category: @category_datas
				layout: @layout

			@layout.content.show(view)


	###
	# ## ventSearchRequest
	#
	# 	@param message
	# 	@return null
	###
	ventSearchRequest: (message) ->
		MyApp.log 'ventSearchRequest message', message
		@layout = message.layout
		@layout.gallery.show(@spin)

		serial_data = 
			message.form
			
		datas = 
			url:  MyApp.rootPath + 'api/search/newSearch'
			data: serial_data
			type: "GET"

		MyApp.log 'ventSearchRequest', @category_datas, datas
		@util.callAjax datas, (msg, datas) =>
			MyApp.log 'callAjax', msg, datas

			object = []
			if @util.isNullOrEmpty(datas)
				object = []
			else
				object = datas

			if object.length > 0
				@makePagination(datas)
				coll = new SearchController.Collection(object)
				galleryView = new GalleryView
					collection: coll
					
				@layout.gallery.show(galleryView)
				@layout.pagination.show(@pagination)
			else 
				msgView = new Msg
				msgView.show('검색결과가 없습니다.')
				@layout.gallery.show(msgView)

	
###
# # SearchController.Collection
# 
# 	Search Collection
###		
class SearchController.Collection extends MyApp.Collection
	###
	# ## model
	#
	# 	Model
	###
	model: Model


module.exports = SearchController
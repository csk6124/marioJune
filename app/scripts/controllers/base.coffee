MyApp = require 'application'
Util = require 'scripts/utils/util'
Spin = require 'scripts/views/partials/spinner'
Pagination = require 'scripts/views/partials/pagination'
Layout = require 'scripts/layout/layout'

###
# # BaseController
# * 공통으로 사용하는 컨트롤 클래스로써 다른 모든 컨트롤클래스에서 상속처리한다.
	스핀, 페이지네이션, 레이아웃, 유틸리티처리를 함
#
###
class BaseController extends Backbone.Marionette.Controller
	###
	# ## initialize
	#
	# 	초기화
	# 	@param location : hash route value
	# 	@param apiLocation : ajax api url path
	# 	@return null
	###
	initialize: (location, apiLocation) ->
		###
		# ## 초기화 변수 세팅
		#
		###
		@url = null
		@paginationObj = null
		@entryLimit = 10
		@maxSize = 10
		@num_results = 0


		###
		# ## Sidebar Menu UI 처리
		#
		###

		# 	unset sidebar menu pointer with active class 
		$("ul#dashboard-menu li#home .pointer").remove()
		$("ul#dashboard-menu li#auth .pointer").remove()
		$("ul#dashboard-menu li#category .pointer").remove()
		$("ul#dashboard-menu li#autoscraping .pointer").remove()
		$("ul#dashboard-menu li#search .pointer").remove()
		$("ul#dashboard-menu li#notification .pointer").remove()
		$("ul#dashboard-menu li#message .pointer").remove()
		$("ul#dashboard-menu li#chart .pointer").remove()
		$("ul#dashboard-menu li#log .pointer").remove()

		# 	active class remove
		$("ul#dashboard-menu li#home").removeClass("active")
		$("ul#dashboard-menu li#auth").removeClass("active")
		$("ul#dashboard-menu li#category").removeClass("active")
		$("ul#dashboard-menu li#autoscraping").removeClass("active")
		$("ul#dashboard-menu li#search").removeClass("active")
		$("ul#dashboard-menu li#notification").removeClass("active")
		$("ul#dashboard-menu li#message").removeClass("active")
		$("ul#dashboard-menu li#chart").removeClass("active")
		$("ul#dashboard-menu li#log").removeClass("active")

		# 	hide all submenu
		$("ul#dashboard-menu li#auth ul.submenu").hide()
		$("ul#dashboard-menu li#category ul.submenu").hide()
		$("ul#dashboard-menu li#autoscraping ul.submenu").hide()
		
		# 	set sidebar menu pointer with active class 
		$("ul#dashboard-menu li#" + location + " ul.submenu").show()
		$("ul#dashboard-menu li#" + location).addClass('active')
		$("ul#dashboard-menu li#" + location).append("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>")


		###
		# ## Pagenation정보 등록처리
		###
		urlHash = @parseLocationHash(window.location.href, location)
		rootPageUrl = urlHash.url
		pageNumber = urlHash.pageNumber
		if _.isUndefined(pageNumber) is true or _.isNull(pageNumber) is true or pageNumber is ''
			pageNumber = 1
		
		@url = MyApp.rootPath + 'api/' + apiLocation + '?results_per_page=' + @entryLimit + '&page=' + pageNumber
		@paginationObj = 
			prevUrl: rootPageUrl
			nextUrl: rootPageUrl
			page: pageNumber
			entryLimit: @entryLimit
			maxSize: @maxSize
			num_results: @num_results


		###
		# ## layout 인스턴스를 생성한다. 
		###
		if @layout
	        @layout.close()

		@util = new Util
		@layout = new Layout
		@spin = new Spin
		@pagination = new Pagination(@paginationObj)
		MyApp.log 'super init', @paginationObj
		
		MyApp.mainRegion.show(@layout)	
		@layout.content.show(@spin)

	###
	# ## makePagination
	# 
	# 	@param datas : ajax return data object(pagination info, data value)
	# 	@return data object
	###
	makePagination: (datas) ->
		MyApp.log 'typeof', datas
		if _.isNull(datas)
			return 

		if datas.hasOwnProperty('num_results')
			@paginationObj.num_results = datas.num_results
		else 
			@paginationObj.num_results = 1

		if datas.hasOwnProperty('total_pages')
			@paginationObj.pages = datas.total_pages
		else 
			@paginationObj.pages = 1

		nextPage = prevPage = parseInt(datas.page)
		
		if @paginationObj.page > 1
			@paginationObj.prev = true
			prevPage -= 1
		else 
			@paginationObj.prev = false

		if @paginationObj.page < @paginationObj.pages
			@paginationObj.next = true
			nextPage += 1
		else 
			@paginationObj.next = false

		@paginationObj.prevUrl = @paginationObj.prevUrl + "/" + prevPage
		@paginationObj.nextUrl = @paginationObj.nextUrl + "/" + nextPage
		@pagination.insertOption(@paginationObj)
		MyApp.log 'paginationObj', @paginationObj, datas


	###
	#	## parseLocationHash
	# 
	# 	@param aURL is window.location href
	# 	@param skipParameter is hash parameter value
	# 	@return pagination number 
	###
	parseLocationHash: (aURL, skipParameter) ->
	  	url = aURL.slice(0, aURL.indexOf(skipParameter) + skipParameter.length)
	  	pageNumber = aURL.slice(aURL.indexOf(skipParameter) + (skipParameter.length + 1))
	  	returnData = 
	  		'url': url
	  		'pageNumber': pageNumber

	  	return returnData


module.exports = BaseController
MyApp = require 'application'
Model = require 'scripts/models/model'
BaseController = require 'scripts/controllers/base'
TableView = require 'scripts/views/partials/table'
FormView = require 'scripts/views/partials/form'

###
# # ScrapyController
# 
# * 서버에서 scrapy에 등록된 url을 가지고 처리한다. 
###
class ScrapyController extends BaseController	
	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###	
	initialize: (options) ->
		super('autoscraping', 'scrapy_urls')

		# ## 초기화 변수 세팅
		
		###
		# Form 컨트롤의 옵션 설정

		 - title : 폼컨트롤의 제목상단에 노출된다. 
		 - ajaxPath : 폼전송시 서버에 요청할 주소 
		 - formField : 폼 필드항목을 정의한다.  
		   - title : 폼필드 표시이름 
		   - name : 서버에 전송할 필드이름
		   - type : input type
		   - values : 추가 값을 넣는다. array
		   - class :  boostrap 3 UI클래스
		 	@variable
		###
		@formInfo = 
			title: "RSS Register"
			ajaxPath: "api/scrapy_urls"
			formFields: [
				{
					title: "Category Id"
					name: "category_id"
					type: "text"
					class: "col-md-1"
				},
				{
					title: "Enable"
					name: "enable"
					type: "selectbox"
					values: ["true","false"]
					class: "col-md-1"
				},
				{
					title: "Provider"
					name: "provider_name"
					type: "text"
					class: "col-md-2"
				},
				{
					title: "Urls"
					name: "start_url"
					type: "text"
					class: "col-md-3"
				},
				{
					title: "Rules"
					name: "rules"
					type: "text"
					class: "col-md-3"
				},
				{
					title: "Interval"
					name: "interval"
					type: "text"
					class: "col-md-1"
				}
			]


		###
		# Table 컨트롤의 옵션 설정

		 - title : 폼컨트롤의 제목상단에 노출된다. 
		 - ajaxPath : 폼전송시 서버에 요청할 주소 
		 - headFields : table header를 array로 등록
		 - dataFields : table 데이타 필드항목을 정의한다.  
		   - editor_field : 수정시 에디트로 할지 여부
		   - class : boostrap 3 UI클래스
		   - name : 서버전송시 필드이름
		# 	@variable
		###
		@tableInfo = 
			title: "AUTOSCRAPING"
			ajaxPath: "api/scrapy_urls/"
			headFields: ["ID", "Category_ID", "enable","provider_name", "start_url", "rules", "interval", "Modify", "Del"]
			dataFields: [
				{ 
					editor_field: true
					class: "col-sm-1"
					name: "category_id"
				},
				{
					editor_field: true
					class: "col-sm-1"
					name: "enable"
				},
				{
					editor_field: true
					class: "col-sm-2"
					name: "provider_name"
				},
				{
					editor_field: true
					class: "col-sm-3"
					name: "start_url"
				},
				{
					editor_field: true
					class: "col-sm-2"
					name: "rules"
				},
				{
					editor_field: true
					class: "col-sm-1"
					name: "interval"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "modify"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "delete"
				}
			]


	###
	# ## show
	#	
	# 	scrapy 리스트뷰
	# 	@param null
	###
	show: ->
		datas = 
			url: @url
			type: "GET"

		@util.callAjax datas, (msg, datas) =>
			MyApp.log 'callAjax', msg, datas
			object = null
			if @util.isNullOrEmpty(datas)
				object = null
			else
				object = datas.objects
				
			@makePagination(datas)
			coll = new ScrapyController.Collection(object)
			view = new TableView
				params: @tableInfo
				collection: coll

			@layout.content.show(view)
			@layout.pagination.show(@pagination)


	###
	# ## form_show
	#
	# 	form등록 뷰
	# 	@param null 
	###
	form_show: ->
		datas = 
			url: MyApp.rootPath + @formInfo.ajaxPath
			type: "GET"

		@util.callAjax datas, (msg, datas) =>
			view = new FormView
				params: @formInfo

			@layout.content.show(view)

		
###
# # ScrapyController.Collection
# 
# 	Scrapy Collection
###
class ScrapyController.Collection extends MyApp.Collection
	###
	# ## model
	#
	# 	Model
	###
	model: Model


module.exports = ScrapyController 


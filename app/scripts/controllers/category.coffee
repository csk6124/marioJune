MyApp = require 'application'
Model = require 'scripts/models/model'
TableView = require 'scripts/views/partials/table'
FormView = require 'scripts/views/partials/form'
BaseController = require 'scripts/controllers/base'

###
# # CategoryController
# 
# * 등록된 데이타의 카테고리 설정관련 
###
class CategoryController extends BaseController
	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super('category', 'category_field')


		# ## 초기화 변수 세팅
		
		###
		# Form 컨트롤의 옵션 설정

		 - title : 폼컨트롤의 제목상단에 노출된다. 
		 - ajaxPath : 폼전송시 서버에 요청할 주소 
		 - formField : 폼 필드항목을 정의한다.  
		   - title : 폼필드 표시이름 
		   - name : 서버에 전송할 필드이름
		   - type : input type
		   - class :  boostrap 3 UI클래스
		 	@variable
		###
		@formInfo = 
			title: "사용처 등록"
			ajaxPath: "api/category_field"
			formFields: [
				{
					title: "Category Name"
					name: "name"
					type: "text"
					class: "col-md-4"
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
			title: "List & Modify"
			ajaxPath: "api/category_field/"
			headFields: ["Id", "Name","PubDate", "Modify", "Del"]
			dataFields: [
				{ 
					editor_field: true
					class: "col-sm-3"
					name: "name"
				},
				{
					editor_field: false
					class: "col-sm-3"
					name: "pub_date"
				},
				{
					editor_field: false
					class: "col-sm-3"
					name: "modify"
				},
				{
					editor_field: false
					class: "col-sm-3"
					name: "delete"
				}
			]
		

	###
	# ## show
	#
	# 	route에서 디폴트롤 실행하는 category view이다. 
	# 	@param null
	###
	show: ->
		datas = 
			url: @url
			type: "GET"

		@util.callAjax datas, (msg, datas) =>
			MyApp.log 'callAjax', msg, datas, @tableInfo
			object = null
			if @util.isNullOrEmpty(datas)
				object = null
			else
				object = datas.objects

			@makePagination(datas)
			coll = new CategoryController.Collection(object)
			view = new TableView
				params: @tableInfo
				collection: coll

			@layout.content.show(view)
			@layout.pagination.show(@pagination)


	###
	# ## form_show
	#
	# 	category 등록 폼 view 실행
	# 	@param null
	###
	form_show: ->
		view = new FormView
			params: @formInfo

		@layout.content.show(view)


###
# # CategoryController.Collection
# 
# 	카테고리 Collection 모델 싱크 
###
class CategoryController.Collection extends MyApp.Collection
	###
	# ## model
	#
	# 	Model
	###
	model: Model


module.exports = CategoryController
MyApp = require 'application'
Model = require 'scripts/models/model'
FormView = require 'scripts/views/partials/form'
TableView = require 'scripts/views/partials/table'
HistogramView = require 'scripts/views/partials/histogram'
BaseController = require 'scripts/controllers/base'

###
# # AuthController
# 사용자즉 업체관련 처리를 담당한다. 

 - 사용자별 차트
 - 접속제한
 - 블랙리스트
###
class AuthController extends BaseController
	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super('auth', 'auth')


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
			ajaxPath: "api/auth"
			formFields: [
				{
					title: "public ID"
					name: "public_id"
					type: "text"
					class: "col-md-3"
				},
				{
					title: "Company Name"
					name: "company"
					type: "text"
					class: "col-md-3"
				},
				{
					name: "private_key"
					type: "private_key"
					id: "public_id"
				},
				{
					name: "approval"
					type: "hidden"
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
			title: "사용자키 발급승인"
			ajaxPath: "api/auth/"
			headFields: ["Id", "APPROVAL","PUBLIC_ID", "COMPANY", "PRIVATE_KEY", "LAST ACCESS TIME", "ACCESS COUNT(Today)", "PUBDATE", "ENDDATE", "View", "Allow", "Del"]
			dataFields: [
				{ 
					editor_field: true
					class: "col-sm-1"
					name: "approval"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "public_id"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "company"
				},
				{
					editor_field: false
					class: "col-sm-2"
					name: "private_key"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "last_access_key"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "access_count"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "pub_date"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "end_date"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "view"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "allow"
				},
				{
					editor_field: false
					class: "col-sm-1"
					name: "delete"
				}
			]
            

	###
	# ## ventAuthChartComplete
	#
	# 	서버로부터 요청한 차트데이타 완료된경우 이벤트 트리거
	# 	@param layout 
	###
	ventAuthChartComplete: (layout) ->
		MyApp.log 'ventAuthChartComplete', layout, @histogram, @

		if @histogram
			layout.content.show(@histogram)


	###
	# ## show
	#
	# 	get auth user list
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
			coll = new AuthController.Collection(object)
			view = new TableView
				params: @tableInfo
				collection: coll

			@layout.content.show(view)
			@layout.pagination.show(@pagination)


	###
	# ## request_show
	#	
	# 	인증요청 폼 등록 페이지
	# 	@param null
	###
	request_show: ->
		view = new FormView
			params: @formInfo

		@layout.content.show(view)


	###
	# ## statistics_show
	#	
	# 	통계데이타 보기
	# 	@param null
	###
	statistics_show: ->
		@histogram = new HistogramView
			layout: @layout

		MyApp.log 'statistics_show', @, @histogram
		@layout.content.show(@spin)


	###
	# ## accessLimit_show
	#
	# 	사용자별 API접속 제한설정
	# 	@param null
	###
	accessLimit_show: ->
		tableInfo = 
			title: "accessLimit_show"
			headFields: ["Id", "Name","PubDate", "", ""]
			dataFields: []

		view = new TableView
			params: tableInfo

		@layout.content.show(view)


	###
	# ## blackList_show
	#
	# 	블랙리스트 설정
	# 	@param null
	###
	blackList_show: ->
		tableInfo = 
			title: "blackList_show"
			headFields: ["Id", "Name","PubDate", "", ""]
			dataFields: []

		view = new TableView
			params: tableInfo

		@layout.content.show(view)


	###
	# ## traffic_show
	#
	# 	사용자별 트래픽 제한 설정
	# 	@param null
	###
	traffic_show: ->
		tableInfo = 
			title: "Traffic Limit"
			headFields: ["Id", "Name","PubDate", "", ""]
			dataFields: []

		view = new TableView
			params: tableInfo

		@layout.content.show(view)
		

###
# # AuthController.Collection
# 	인증컨트롤 Collection
#
###
class AuthController.Collection extends MyApp.Collection
	###
	# ## model
	#
	# 	Model
	###
	model: Model


module.exports = AuthController
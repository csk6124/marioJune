MyApp = require 'application'
Model = require 'scripts/models/model'
TableView = require 'scripts/views/partials/table'
BaseController = require 'scripts/controllers/base'

###
# # NotificationController
# 
# * noti관련 클래스
###
class NotificationController extends BaseController
	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###	
	initialize: (options) ->
		super('notification', 'notification')


		# ## 초기화 변수 세팅

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
			title: "Notification"
			headFields: ["Id", "Name","PubDate", "", ""]
			dataFields: []


	###
	# ## show
	#
	# 	notification 리스트뷰
	# 	@return: view
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
			coll = new NotificationController.Collection(object)
			view = new TableView
				params: @tableInfo
				collection: coll

			@layout.content.show(view)
			@layout.pagination.show(@pagination)


###
# # NotificationController.Collection
# 
# 	noti관련 클래스 Collection
###
class NotificationController.Collection extends MyApp.Collection
	###
	# ## model
	#
	# 	Model
	###
	model: Model


module.exports = NotificationController
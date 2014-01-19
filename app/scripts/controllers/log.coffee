MyApp = require 'application'
BaseController = require 'scripts/controllers/base'
TableView = require 'scripts/views/partials/table'

###
# # LogController
# 
# * 각종 로그정보 데이타
###
class LogController extends BaseController
	###
	# ## initialize
	#
	# 	초기화
	###
	initialize: ->
		super('log','log')	


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
			title: "Log"
			headFields: ["Id", "Name","PubDate", "", ""]
			dataFields: []


	###
	# ## show
	#
	# 	log 리스트뷰
	# 	@param null
	# 	@return: view
	###
	show: ->
		datas = 
			url: @url
			type: "GET"

		@util.callAjax datas, (msg, datas) =>
			MyApp.log 'callAjax', msg, datas
			@makePagination(datas)
			view = new TableView
				params: @tableInfo

			@layout.content.show(view)
			@layout.pagination.show(@pagination)


module.exports = LogController 
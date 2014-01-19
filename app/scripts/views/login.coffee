MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # LoginView
#
# * Login View
#
###
class LoginView extends BaseView
	###
	# ## template
	#
	# 	templates/login
	###
	template: 'templates/login'


	###
	# ## events
	#
	# 	이벤트 
	# 	"click button#login":"eventLogin"
	###
	events:
		"click button#login":"eventLogin"


	###
	# ## initialize
	#
	# 	초기화 
	# 	@param options
	###
	initialize: (options) ->
		super


	###
	# ## eventLogin
	# 
	# 	login auth to Server
	# 	@param: event
	# 	@return login 
	# 	@event_on
	###
	eventLogin: (event) ->
		event.preventDefault()
		userid = @$el.find('#userid').val()
		password = @$el.find('#password').val()

		MyApp.log 'eventLogin', userid, password

		if @util.isNullOrEmpty(userid) or 
		   @util.isNullOrEmpty(password)
			MyApp.noti.show
				messages: [
					message: "Please, Write a userid and password value"
					type: "warning"
				]
			return

		datas = 
			url:  MyApp.rootPath + 'api/login'
			data:
				userid: userid
				password: password
			type: "GET"

		@util.callAjax datas, (status, data) =>
				MyApp.log 'callAjax', status, data

				if status is 'success'
					MyApp.noti.show
						messages: [
							message: "Successed Login"
							type: "success"
						]
				else 
					MyApp.noti.show
						messages: [
							message: "Failed Login " + data
							type: "error"
						]


module.exports = LoginView
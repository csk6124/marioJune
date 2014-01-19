MyApp = require 'application'
BaseController = require 'scripts/controllers/base'
LoginView = require 'scripts/views/login'

###
# # LoginController
# 
#
###
class LoginController extends BaseController
	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: ->
		super('login','login')	


	###
	# ## show
	# 
	# 	로그인 뷰
	# 	@param null
	# 	@return: view
	###
	show: ->	
		view = new LoginView
		@layout.content.show(view)


module.exports = LoginController 
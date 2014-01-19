MyApp = require 'application'
BaseModel = require 'scripts/models/base'

###
# # Model
#
# * 모델 클래스
#
###
class Model extends BaseModel
	###
	# ## idAttribute
	#
	# 	@attribute
	###
	idAttribute: 'id'


	###
	# ## defaults
	#
	# 	@attribute
	###
	defaults: 
		editor: false


	###
	# ## intialize
	#
	# 	초기화
	###
	intialize: ->


module.exports = Model
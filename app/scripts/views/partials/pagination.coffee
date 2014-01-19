MyApp = require 'application'
Model = require 'scripts/models/model'
BaseView = require 'scripts/views/base'

###
# # Pagination
#
# * Pagination 모듈
#
###
class Pagination extends BaseView
	###
	# ## template
	#
	###
	template: 'templates/partials/pagination'
	model: new Model

	###
	# ## initialize
	#
	# 	초기화 
	# 	@param options
	###
	initialize: (options=null) ->
		super

		MyApp.log 'Pagination view ', options, @model
		if(options)
			@model.set('prevUrl', options.prevUrl)
			@model.set('nextUrl', options.nextUrl)
			@model.set('page', options.page)
			@model.set('pages', options.pages)
			@model.set('entryLimit', options.entryLimit)
			@model.set('maxSize', options.maxSize)
			@model.set('prev', options.prev)
			@model.set('next', options.next)
	
	
	###
	# ## insertOption
	#
	# 	@param options
	###
	insertOption: (options) ->
		@initialize(options)


module.exports = Pagination
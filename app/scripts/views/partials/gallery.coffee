MyApp = require 'application'
Model = require 'scripts/models/model'
BaseView = require 'scripts/views/base'

###
# # ItemView
#
# * 갤러리 모듈 itemView
#
###
class ItemView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/gallery_item
	###
	template: 'templates/partials/gallery_item'


	###
	# ## model
	#
	# 	Model
	###
	model: Model


	###
	# ## events
	#
	# 	"click button#more": "eventMore"
		"click button#close": "eventClose" 
	###
	events: 
		"click button#more": "eventMore"
		"click button#close": "eventClose"


	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super
		

	###
	# ## eventMore
	#
	# 	map and more info view
	# 	@param event
	# 	@return render view
	# 	@event_on
	###
	eventMore: (event) ->
		event.preventDefault()
		@model.set('editor', true)
		@render()
		canvas = document.getElementById("map_canvas")
		MyApp.log 'eventMore', canvas
		map = new jarvisMap
		map.init(canvas)
		MyApp.log 'Galleryview more', event, @model
		@render()


	###
	# ## eventClose
	#
	# 	close extend view
	# 	@param event
	# 	@return render view
	# 	@event_on
	###
	eventClose: (event) ->
		event.preventDefault()
		@model.set('editor', false)
		MyApp.log 'Galleryview more', event, @model
		@render()


###
# # <strong>GalleryView</strong>
#
#   갤러리 모듈 listView
#
###
class GalleryView extends MyApp.CompositeView
	###
	# ## template
	# 
	# 	path templates/partials/gallery_lists
	###
	template: 'templates/partials/gallery_lists'


	###
	# ## itemViewContainer 설정
	#
	# 	class media-list
	###
	itemViewContainer: '.media-list'


	###
	# ## itemView 설정
	#
	# 	ItemView
	###
	itemView: ItemView


module.exports = GalleryView
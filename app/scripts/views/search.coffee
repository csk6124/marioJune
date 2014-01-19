MyApp = require 'application'
Model = require 'scripts/models/model'
BaseView = require 'scripts/views/base'

###
# # SearchView
#
# * Search View
#
###
class SearchView extends BaseView
	###
	# ## template
	#
	#   templates/search
	# 	@attribute
	###
	template: 'templates/search'


	###
	# ## tagName
	#
	# 	form.form-horizontal
	# 	@attribute
	###
	tagName: 'form.form-horizontal'


	###
	# ## events
	#
	# 	'submit #search': 'eventSubmit'
		'keydown': 'eventKey'
		'click ul li a[href="#new"]': 'newTab'
		'click ul li a[href="#location"]': 'locationTab'
		'click ul li a[href="#new_address"]': 'new_addressTab'
		'click ul li a[href="#old_address"]': 'old_addressTab'
		'click ul li a[href="#poitab"]': 'poiTab'
	# 	@attribute
	### 
	events:
		'submit #search': 'eventSubmit'
		'keydown': 'eventKey'
		'click ul li a[href="#new"]': 'newTab'
		'click ul li a[href="#location"]': 'locationTab'
		'click ul li a[href="#new_address"]': 'new_addressTab'
		'click ul li a[href="#old_address"]': 'old_addressTab'
		'click ul li a[href="#poitab"]': 'poiTab'


	###
	# ## initialize
	#
	# 	초기화
	# 	@param options
	###
	initialize: (options) ->
		super
		MyApp.log 'options', options.category
		@category = options.category
		@layout = options.layout
		@current_tab = 'new'

		  

	###
	# ## serializeData
	#
	# 
	###
	serializeData: ->
		distance: @distance
		category: @category


	###
	# ## onShow
	#
	###
	onShow: ->
		# * datepicker UI 설정
		$("#loc_startTime").datepicker
            onSelect: (dateText) =>
                $("#loc_startTime").val(dateText)

        $("#loc_endTime").datepicker
            onSelect: (dateText) =>
                $("#loc_endTime").val(dateText)

        $("#naddr_startTime").datepicker
            onSelect: (dateText) =>
                $("#naddr_startTime").val(dateText)

        $("#naddr_endTime").datepicker
            onSelect: (dateText) =>
                $("#naddr_endTime").val(dateText)

        $("#oaddr_startTime").datepicker
            onSelect: (dateText) =>
                $("#oaddr_startTime").val(dateText)

        $("#oaddr_endTime").datepicker
            onSelect: (dateText) =>
                $("#oaddr_endTime").val(dateText)

        $("#poi_startTime").datepicker
            onSelect: (dateText) =>
                $("#poi_startTime").val(dateText)

        $("#poi_endTime").datepicker
            onSelect: (dateText) =>
                $("#poi_endTime").val(dateText)


	###
	# ## eventKey
	#
	# 	@param event
	###
	eventKey: (event) ->
		if event.keyCode is 13
			@eventSubmit(event)
			

	###
	# ## _initForm
	#
	# 	@private
	###
	_initForm: ->
		@$el.find("#lat").val('')
		@$el.find("#long").val('')
		@$el.find("#distance").val('')
		@$el.find("#poi").val('')
		@$el.find("#address").val('')
		@$el.find("#startTime").val('')
		@$el.find("#endTime").val('')


	###
	# ## newTab
	#
	# 	event
	# 	@param event
	# 	@event_on
	###
	newTab: (event) ->
		MyApp.log 'newTab'
		@current_tab = 'new'
		@_initForm()


	###
	# ## locationTab
	# 
	# 	event
	# 	@param event
	# 	@event_on
	###
	locationTab: (event) ->
		MyApp.log 'locationTab'
		@current_tab = 'location'
		@_initForm()


	###
	# ## new_addressTab
	#
	# 	event
	# 	@param event
	# 	@event_on
	###
	new_addressTab: (event) ->
		MyApp.log 'new_addressTab'
		@current_tab = 'new_address'
		@_initForm()


	###
	# ## old_addressTab
	# 
	# 	event
	# 	@param event
	# 	@event_on
	###
	old_addressTab: (event) ->
		MyApp.log 'old_addressTab'
		@current_tab = 'old_address'
		@_initForm()


	###
	# ## poiTab
	#
	# 	event
	# 	@param event
	# 	@event_on
	###
	poiTab: (event) ->
		MyApp.log 'poiTab'
		@current_tab = 'poitab'
		@_initForm()


	###
	# ## eventSubmit
	#
	# 	event
	# 	@param event
	# 	@event_on
	###
	eventSubmit: (event) ->
		event.preventDefault()

		lat = @$el.find("#lat").val()
		long = @$el.find("#long").val()
		distance = @$el.find("#distance").val()
		poi = @$el.find("#poi").val()
		address = @$el.find("#address").val()
		category = @$el.find("#category").val()
		startTime = @$el.find("#startTime").val()
		endTime = @$el.find("#endTime").val()

		message = {}
		message.layout = @layout
		message.form = {}

		if lat
			message.form.lat = parseFloat(lat)

		if long
			message.form.long = parseFloat(long)

		if distance
			message.form.distance = parseInt(distance)

		if poi
			message.form.poi = poi

		if address
			message.form.address = address

		if category isnt '0'
			message.form.category = parseInt(category)

		if @current_tab is 'location'
			if @util.isNullOrEmpty(lat) or 
			   @util.isNullOrEmpty(long) or 
			   @util.isNullOrEmpty(distance)
				MyApp.noti.show
					messages: [
						message: "You should put a Lat, Long, Distance value in the box"
						type: "warning"
					]
				return


		else if @current_tab is 'new_address' or @current_tab is 'old_address'
			if @util.isNullOrEmpty(address)
				MyApp.noti.show
					messages: [
						message: "You should put a address value in the box"
						type: "warning"
					]
				return 
		else if @current_tab is 'poitab'
			if @util.isNullOrEmpty(poi)
				MyApp.noti.show
					messages: [
						message: "You should put a poi value in the box"
						type: "warning"
					]
				return


		MyApp.log 'message', message, lat
		MyApp.vent.trigger('search_request', message)


module.exports = SearchView
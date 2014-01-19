MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # TimepickerView
#
# * Timepicker 모듈
#
###
class TimepickerView extends BaseView
	###
	# ## template
	#
	# 	path templates/partials/timepicker
	###
	template: 'templates/partials/timepicker'
	#events:
	#	'mouseover #dateinput': 'createDatePicker'


	###
	# ## initialize
	#
	# 	초기화 
	# 	@param options
	###
	initialize: (options) ->
	  	super
	

	###
	# ## serializeData
	#
	###
	serializeData: ->


	###
	# ## onShow
	#
	###
	onShow: ->
		MyApp.log 'TimepickerView onShow'
		$("#dateinput_from").datepicker()
		$("#dateinput_to").datepicker()


	###
	# ## createDatePicker
	#
	# 	event datetime click
	# 	@param event
	# 	@event_on
	###
	createDatePicker: (event) ->
    	MyApp.log 'createDatePicker', event
		self = @
		$(event.currentTarget).datepicker
		  	maxDate:'-2',
		    defaultDate:self.selectedDate,
		    onSelect: (dateText,datePicker) =>
		    	MyApp.log 'onSelect', dateText
		    	@selectedDate = dateText
		    	@onDateChange(datePicker)
		
		
module.exports = TimepickerView
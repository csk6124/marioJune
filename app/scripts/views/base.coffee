MyApp = require 'application'
Model = require 'scripts/models/model'
Util = require 'scripts/utils/util'

###
# # BaseView
#
# * View Base class
#
###
class BaseView extends MyApp.ItemView
	###
	# ## events
	#
	# 	"click #dashboard-menu .dropdown-toggle": "eventDropdownToggle"
		"click .skins-nav .skin": "eventSkinChanger"
	###
	events:
		"click #dashboard-menu .dropdown-toggle": "eventDropdownToggle"
		"click .skins-nav .skin": "eventSkinChanger"


	###
	# ## initialize
	#
	# 	초기화 
	###
	initialize: ->
		@util = new Util
		@notificationDropdown()

	###
	# ## notificationDropdown
	#
	# 	header or any place navbar notification popups
	###
	notificationDropdown: ->
		$(".slider").slider()
		
		$(".notification-dropdown").each (index, el) =>
			$el = $(el)
			$dialog = $el.find(".pop-dialog")
			$trigger = $el.find(".trigger")
			$dialog.click (e) ->
				e.stopPropagation()

			$dialog.find(".close-icon").click (e) =>
				e.preventDefault()
				$dialog.removeClass "is-visible"
				$trigger.removeClass "active"

			$("body").click ->
				$dialog.removeClass "is-visible"
				$trigger.removeClass "active"

			$trigger.click (e) =>
				e.preventDefault()
				e.stopPropagation()

				$(".notification-dropdown .pop-dialog").removeClass "is-visible"
				$(".notification-dropdown .trigger").removeClass "active"
				$dialog.toggleClass "is-visible"
				if $dialog.hasClass("is-visible")
					$(this).addClass "active"
				else
					$(this).removeClass "active"

	###
	# ## eventDropdownToggle
	#
	# 	Menu dropdown-toggle
	# 	@param event
	# 	@event_on
	###
	eventDropdownToggle: (event) ->
		event.preventDefault()
		item = $(event.currentTarget).parent()
		item.toggleClass "active"
		if item.hasClass("active")
			item.find(".submenu").slideDown "fast"
		else
			item.find(".submenu").slideUp "fast"
	
	###
	# ## eventSkinChanger
	#
	# 	Default Skin changer for boostrap color
	# 	@param event
	# 	@event_on
	###
	eventSkinChanger: (event) ->
		MyApp.log 'onSkinChanger', event
		event.preventDefault()
		return  if $(event.currentTarget).hasClass("selected")
		$(".skins-nav .skin").removeClass "selected"
		$(event.currentTarget).addClass "selected"
		$("head").append "<link rel=\"stylesheet\" type=\"text/css\" id=\"skin-file\" href=\"\">"  unless $("#skin-file").length
		$skin = $("#skin-file")
		if $(event.currentTarget).attr("data-file")
			$skin.attr "href", $(event.currentTarget).data("file")
		else
			$skin.attr "href", ""


module.exports = BaseView
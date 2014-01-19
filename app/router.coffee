MyApp = require('application')
AuthController = require('scripts/controllers/auth')
HomeController = require('scripts/controllers/home')
CategoryController = require('scripts/controllers/category')
SearchController = require('scripts/controllers/search')
ScrapyController = require('scripts/controllers/scrapy')
LogController = require('scripts/controllers/log')
MessageController = require('scripts/controllers/message')
NotificationController = require('scripts/controllers/notification')
LoginController = require('scripts/controllers/login')

###
# # Router
#
# * Router
#
###
class Router extends Backbone.Router
	routes:
		'': 'home'
		'auth': 'auth'
		'auth/:id': 'auth'
		'auth-request': 'authRequest'
		'auth-statistics': 'authStatistics'
		'auth-access-limit': 'authAccessLimit'
		'auth-black-list': 'authBlackList'
		'auth-traffic': 'authTraffic'
		'category': 'category'		
		'category/:id': 'category'	
		'category-register': 'categoryRegister'	
		'search': 'search'
		'autoscraping': 'scrapy'
		'autoscraping/:id': 'scrapy'
		'autoscraping-register': 'scrapyRegister'
		'message': 'message'
		'notification': 'notification'
		'log': 'log'
		'login': 'login'
		'logout': 'logout'

	isLogin: ->
		return true

	auth: ->
		if !@isLogin()
			return

		auth = new AuthController
			mainRegion: MyApp.mainRegion.content
		auth.show()
	authRequest: ->
		if !@isLogin()
			return

		auth = new AuthController
			mainRegion: MyApp.mainRegion.content
		auth.request_show()
	authStatistics: ->
		if !@isLogin()
			return

		auth = new AuthController
			mainRegion: MyApp.mainRegion.content
		auth.statistics_show()
	authAccessLimit: ->
		if !@isLogin()
			return

		auth = new AuthController
			mainRegion: MyApp.mainRegion.content
		auth.accessLimit_show()
	authBlackList: ->
		if !@isLogin()
			return

		auth = new AuthController
			mainRegion: MyApp.mainRegion.content
		auth.blackList_show()
	authTraffic: ->
		if !@isLogin()
			return

		auth = new AuthController
			mainRegion: MyApp.mainRegion.content
		auth.traffic_show()
	category: ->
		if !@isLogin()
			return

		category = new CategoryController
			mainRegion: MyApp.mainRegion.content
		category.show()
	categoryRegister: ->
		if !@isLogin()
			return

		category = new CategoryController
			mainRegion: MyApp.mainRegion.content
		category.form_show()
	home: ->
		if !@isLogin()
			return

		home = new HomeController	
			mainRegion: MyApp.mainRegion.content
		home.show()
	search: ->
		if !@isLogin()
			return

		search = new SearchController
			mainRegion: MyApp.mainRegion.content
		search.show()
	scrapy: ->
		if !@isLogin()
			return

		scrapy = new ScrapyController
			mainRegion: MyApp.mainRegion.content

		scrapy.show()
	scrapyRegister: ->
		if !@isLogin()
			return

		scrapy = new ScrapyController
			mainRegion: MyApp.mainRegion.content
		scrapy.form_show()
	message: ->
		if !@isLogin()
			return

		message = new MessageController
			mainRegion: MyApp.mainRegion.content
			
		message.show()
	notification: ->
		if !@isLogin()
			return

		notification = new NotificationController
			mainRegion: MyApp.mainRegion.content
		notification.show()
	log: ->
		if !@isLogin()
			return

		log = new LogController
			mainRegion: MyApp.mainRegion.content
		log.show()
	login: ->
		login = new LoginController
			mainRegion: MyApp.mainRegion.content
		login.show()
	logout: ->
		$.cookie("auth_key", null)
		window.location = "login.html"
		

module.exports = Router

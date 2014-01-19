require 'help/view_helper'

###
# # MyApp
#
# * MyApp
#
###
class MyApp extends Backbone.Marionette.Application
    initialize: ->    
        ###
        # ##  Remote call API 
        #
        #   RESTFULL Root API
        #   @variable
        ###
        @rootPath = "http://localhost:9000/"      
        
        
        ###
        # ##  Collection Wrapper
        #
        #   
        #   @variable
        ###
        @Collection = Backbone.Collection


        ###
        # ##  ItemView Wrapper
        #
        #   
        #   @variable
        ###
        @ItemView = Backbone.Marionette.ItemView


        ### 
        # ##  CompositeView Wrapper 
        #
        #   
        #   @variable
        ###
        @CompositeView = Backbone.Marionette.CompositeView

        ###
        # ##  add Region 
        #
        #   
        #   @variable
        ###
        @addRegions({
          notificationRegion: "#notification-region",
          headerRegion: "#header-region",
          sidevarRegion: "#sidebar-region",
          mainRegion: "#main-region",
          dialogRegion: Marionette.Region.Dialog.extend({
            el: "#dialog-region"
          })
          footerRegion: "#footer-region"
        });


        ###
        # ## initialize:before 
        #
        #   초기화 전 설정
        #   @event_on
        ###
        @on("initialize:before", (options) =>
            
        )


        ###
        # ## initialize:before
        #
        #   초기화 후 설정
        #   @event_on
        ###
        @on("initialize:after", (options) =>
            Backbone.history.start();
            Object.freeze? this
        )


        ###
        # ## addInitializer
        #
        #   초기화 설정
        #   @param options
        ###
        @addInitializer( (options) =>
            Util = require 'scripts/utils/util'
            @util = new Util

            Router = require 'router'
            @router = new Router()

            NotiView = require 'scripts/views/partials/noti'
            @noti = new NotiView

            HeaderView = require 'scripts/views/header'
            @header = new HeaderView
            @headerRegion.show(@header)

            SidebarView = require 'scripts/views/sidebar'
            @sidebar = new SidebarView
            @sidevarRegion.show(@sidebar)

            FooterView = require 'scripts/views/footer'
            @footer = new FooterView
            @footerRegion.show(@footer)

            @elasticsearch_path = 'http://localhost:9200'
        )

        @start()


    ###
    # ## log
    #
    #   시스템 로그
    #   @param msg..
    ###
    log: (msg ...) ->
        console.log msg
        #text = new Date().toLocaleString() + " " + msg
        #$(".ui-dropdown .body #data").prepend("<tr><td>" + text + "</td></tr>")


module.exports = new MyApp()

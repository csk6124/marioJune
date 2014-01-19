MyApp = require('application')

###
# # Spin
#
# * 스핀 컨트롤 모듈
#
###
class Spin extends MyApp.CompositeView
    ###
    # ## template
    #
    #   path templates/partials/spinner
    ###
    template: 'templates/partials/spinner'
    

    ###
    # ## initialize
    #
    #   @param options
    ###
    initialize: (options) ->
        options = options || {}
        #@title = options.title || "Loading..."
        #@message = options.message || "로딩중입니다......"


    ###
    # ## serializeData
    #
    #   title: @title
        message: @message
    ###
    serializeData: ->
        title: @title
        message: @message


    ###
    # ## onShow
    #
    ###
    onShow: ->
        opts =
            lines: 10             # The number of lines to draw
            length: 5            # The length of each line
            width: 5              # The line thickness
            radius: 10            # The radius of the inner circle
            corners: 1            # Corner roundness (0..1)
            rotate: 0             # The rotation offset
            direction: 1          #  1: clockwise, -1: counterclockwise
            color: "#001933"         # #rgb or #rrggbb
            speed: 1              # Rounds per second
            trail: 60             # Afterglow percentage
            shadow: false         # Whether to render a shadow
            hwaccel: false        # Whether to use hardware acceleration
            className: "spinner"  # The CSS class to assign to the spinner
            zIndex: 2e9           # The z-index (defaults to 2000000000)
            top: "100px"           # Top position relative to parent in px
            left: "auto"          # Left position relative to parent in px

        $("#spinner").spin(opts)


module.exports = Spin

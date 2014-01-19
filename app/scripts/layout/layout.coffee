###
# # <strong>Layout</strong>
#
#   화면 Content레이아웃을 region별로 설정
#
###
class Layout extends Backbone.Marionette.Layout
    # ## template
    template: "templates/layout"


    # ## regions
    regions:
        content: "#content"
        timepicker: "#timepicker"
        api_chart: "#api_chart"
        crawler_chart: "#crawler_chart"
        gallery: "#gallery"
        pagination: "#pagination"
        map: "#map"
        


module.exports = Layout
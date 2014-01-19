MyApp = require 'application'
BaseView = require 'scripts/views/base'

###
# # <strong>HistogramView</strong>
#
#   히스토그램 Chart 모듈
#
###
class HistogramView extends BaseView
    ###
    # ## template
    #
    #   templates/partials/histogram
    ###
    template: 'templates/partials/histogram'


    ###
    # ## events
    #
    #   "click button#search": "eventSearch"
        "click [type='checkbox']": "eventChecked"
        "change #selectInterval": "eventSelectChanged"
    ###
    events:
        "click": "allClick"
        "click button#go": "eventSearch"
        "click [type='checkbox']": "eventChecked"
        "change #selectInterval": "eventSelectChanged"


    ###
    # ## initialize
    #
    #   초기화 
    #   @param options
    ###
    initialize: (options) ->
        super
        @chart = new jarvisFlotChart

        # * 시간 설정 && moment 라이브러리을 이용한 시간 설정
        @from_time = new Date("2013-10-28")
        @to_time = new Date()
        @from = moment(@from_time).format("MM/DD/YYYY")
        @to = moment(@to_time).format("MM/DD/YYYY")
        
        # * elastic 기본 interval 설정
        @selectInterval = '1d'

        # * elastic server info
        @elasticInfo =
            indices: []
            elasticsearch: MyApp.elasticsearch_path

        # * flot 차크 기본 세팅 설정
        @opt =
            mode: 'count'
            active: true
            ids: [0]
            field: "@timestamp"
            from: @from
            from_time: @from_time
            to_time: @to_time
            id: 0
            mandate: "must"
            to: "now"
            type: 'time'
            interval: '1d'
            intervals: ['auto','1m','5m','10m','30m','1h','3h','12h','1d','1w','1y']
            bars: true
            lines: false
            points: true
            query_type: 'lucene'
            div: 'statsChart'
            divId: '#statsChart'
            label: 'API'
            title: 'API Statistics'
            xaxis: []

        MyApp.log 'onShow initialize', @opt, @from, @to
        @title = @opt.title
        @div = @opt.div

        # * elastic으로 부터 가져온 데이타를 flot chart에 적용
        @queryElastic(options.status, options.datas)


    ###
    # ## onShow
    #
    #   날짜 datepicker설정 , 차트뷰 
    ###
    onShow: ->
        MyApp.log 'onShow histogram', @opt, @data, @from, @to
        $("#dateinput_from").datepicker
            onSelect: (dateText) =>
                @from = dateText
                @from_time = new Date(dateText)
                @opt.from = dateText


        $("#dateinput_to").datepicker
            onSelect: (dateText) =>
                @to = dateText
                @to_time = new Date(dateText)

        $("#dateinput_from").val(@from)
        $("#dateinput_to").val(@to)
        


    ###
    # ## serializeData
    #
    #   데이타 싱크 with templete
    ###
    serializeData: ->
        title: @title
        div: @div
        opt: @opt
        selectInterval: @selectInterval



    ###

    ###
    allClick: (event)->
        MyApp.log 'allClick'


    ###
    # ## eventSelectChanged
    #
    #   selectchange 이벤트
    #   @param event
    #   @event_on
    ###
    eventSelectChanged: (event)->
        MyApp.log 'selected exchange event'
        event.preventDefault()
        @opt.interval = $('#selectInterval').val()
        @selectInterval = @opt.interval


    ###
    # ## eventChecked
    #
    #   이벤트 체크박스 클릭이벤트 
    #   @param event
    #   @event_on
    ###
    eventChecked: (event) ->
        MyApp.log 'eventChecked click'
        event.preventDefault()
        if event.currentTarget.name is 'bars'
            if event.currentTarget.checked is true then @opt.bars = true else @opt.bars = false
        else if event.currentTarget.name is 'lines'
            if event.currentTarget.checked is true then @opt.lines = true else @opt.lines = false
        else if event.currentTarget.name is 'points'
            if event.currentTarget.checked is true then @opt.points = true else @opt.points = false

    
    ###
    # ## eventSearch
    # 
    #   search method
    #   @param event (object)
    #   @return call queryElastic method 
    #   @event_on
    ###
    eventSearch: (event) ->
        MyApp.log 'click search event'
        event.preventDefault()
        MyApp.vent.trigger("api_chart_request", null)


    ###
    # ## queryElastic
    #
    #   Elasticsearch query
    #   @return trigger event fire
    #   @event_on
    ###
    queryElastic: (status, datas) ->
        MyApp.log 'queryElastic drowing event'
        @getRangeIndices(@from_time, @to_time)
       
        indices = []
        _.each datas, (v, k) =>
            indices.push k

        indices = _.intersection(@possible, indices)
        indices.reverse()
        @elasticInfo.indices = indices

        value = []
        results = @util.getElasticsearchData(@opt, @elasticInfo)
        results.then (results) =>
            total = results.hits.total
            _.each results.facets, (facet) =>
                _.each facet.entries, (entry) =>
                    day = new Date(entry.time)
                    dayWrapper = moment(day); 
                    dayString = dayWrapper.format("YYYY-MM-DD HH:mm:ss"); 
                    value.push [entry.time, entry.count]

            @data = [
                data: value
                label: @opt.label
            ]
            
            # * chart관련 클래스를 생성
            $(@opt.divId).addClass('statsChart')
            # * flot chart를 그린다. 
            @chart.load(@opt.divId, @data, @opt)
    

    ###
    # ## getRangeIndices
    # 
    #   get Indecies between from start to end
    #   @param from (date string)
    #   @param to (date string)
    #   @return logstash-]YYYY.MM.DD format string array 
    ###
    getRangeIndices: (from, to) ->
        @possible = []
        _.each @expand_range(@fake_utc(from), @fake_utc(to), 'days'), (d) =>
            @possible.push d.format('[logstash-]YYYY.MM.DD')


    ###
    # ## fake_utc
    # 
    #   utc date time
    #   @param date (string)
    #   @return moment type
    ###
    fake_utc: (date) ->
        date = moment(date).clone().toDate()
        return moment(new Date(date.getTime() + date.getTimezoneOffset() * 60000));


    ###
    # ## expand_range
    # 
    #   Total period range from start to end 
    #   @param start (moment datetime) 
    #   @param end (moment datetime)
    #   @param interval (string) hour, day, week, month, year so on ..
    #   @return array or false
    ### 
    expand_range: (start, end, interval) ->
        if _.contains(['hour', 'day', 'week', 'month', 'year'], interval)
            start = moment(start).clone()
            range = []
            while start.isBefore(end)

                range.push moment(start).clone()
                switch interval
                    when "hour"
                        start.add('hours', 1)
                    when "day"
                        start.add('days', 1)
                    when "week"
                        start.add('weeks', 1)
                    when "month"
                        start.add('months', 1)
                    when "year"
                        start.add('years', 1)

            range.push moment(end).clone()
            MyApp.log 'indices expand_range', range
            return range
        else 
            return false


module.exports = HistogramView
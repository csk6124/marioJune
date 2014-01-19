/**
 * jqury flot 그래프관련 helper class
 * @dependency : jquery.flot.js, underscore.js
 * @author : watermelon
 *
 */
(function(root, factory) {

  /* CommonJS */
  if (typeof exports == 'object')  module.exports = factory()

  /* AMD module */
  else if (typeof define == 'function' && define.amd) define(factory)

  /* Browser global */
  else root.jarvisFlotChart = factory()
}(this, function () {
    "use strict";

    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {
            position: 'absolute',
            display: 'none',
            top: y - 30,
            left: x - 50,
            color: "#fff",
            padding: '2px 5px',
            'border-radius': '6px',
            'background-color': '#000',
            opacity: 0.80
        }).appendTo("body").fadeIn(200);
    }

    function time_format(interval) {
        var _int = kbn.interval_to_seconds(interval);
        if(_int >= 2628000) {
            return "%Y-%m";
        }
        if(_int >= 86400) {
            return "%Y-%m-%d";
        }
        if(_int >= 60) {
            return "%H:%M<br>%m-%d";
        }
        return "%H:%M:%S";
    }


    var defaults = {
        legend: { show: false},
        series: {
            lines: { 
                show: true,
                lineWidth: 4,
                fill: true, 
                steps: false
                //,color: '#4C9900'
            },
            bars:   {
              show: false,
              fill: 1,
              barWidth: 1,
              zero: false,
              lineWidth: 13,
              order: 1
            },
            points: { 
                show: true, 
                fill: 5,
                fillColor: false,
                radius: 5
            },
            shadowSize: 1,
            stack: true,
            tackpercent: true,
            color: '#4C9900'            // color
        },
        grid: { 
            backgroundColor: null,
            borderWidth: 0,
            hoverable: true,
            color: '#c8c8c8'
        },
        xaxis: {
            show: true,
            timezone: "browser",
            mode: "time",
            timeformat: time_format("1h"),
            label: "Datetime"
        },
        yaxis: {
            show: true,
            min: 0,
            max: null,
            ticks:3, 
            tickDecimals: 0,
            font: {size:12, color: "#9da3a9"},
            label: "접속자수"
        },
        selection:{ 
            mode: "x", 
            color: '#666' 
        }
    };

    var jarvisFlotChart = function() {
        if (typeof this == 'undefined') return new jarvisFlot();
        this.opts = defaults;
    }

    

    jarvisFlotChart.prototype = {

        /**
         * plot chart load and attach div target
         */
        load: function(target, data, options) {
            var self = this;
            self.data = data;
            if(!_.isNull(options) && !_.isUndefined(options)) {
                self.opts.series.lines.show = options.lines;
                self.opts.series.bars.show = options.bars;
                self.opts.series.points.show = options.points;
                self.opts.xaxis.timeformat = time_format(options.interval);
                self.opts.xaxis.min = options.from_time.getTime();
                self.opts.xaxis.max = options.to_time.getTime();
            }


            console.log('plot load', data, options, self.opts);
            $.plot(target, self.data, self.opts);
            var previousPoint = null;
            $(target).bind("plothover", function (event, pos, item) {
                
                if (item) {
                    if (previousPoint != item.dataIndex) {
                        previousPoint = item.dataIndex;
                        $("#tooltip").remove();
                        var x = item.datapoint[0].toFixed(0),
                            y = item.datapoint[1].toFixed(0),
                            c = moment.unix(x/1000).format("YYYY-MM-DD")

                        //console.log('plothover', pos, item, new Date(), x, y, c);
                        showTooltip(item.pageX, item.pageY,  c + " " + item.series.yaxis.options.label + " : " + y);
                    }
                }
                else {
                    $("#tooltip").remove();
                    previousPoint = null;
                }
            });

            $(target).bind("plotselected", function(event, ranges) {
                //console.log('plotselected', event, ranges);
                self.opts.xaxis.min = ranges.xaxis.from;
                self.opts.xaxis.max = ranges.xaxis.to;
                $.plot(target, self.data, self.opts);
            });
        }

        
    };




    return jarvisFlotChart;

}));
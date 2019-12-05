Conf   = require('./Conf')
Stats  = require('stats-js')
Update = require('../libs/Update')


class Profiler

  constructor: ->

    @fps = 60
    @averageFps = @fps
    @isLow = false

    @_totalFps = 0
    @_cnt = 0

    @_stats = new Stats()
    @_stats.domElement.style.position = 'fixed'
    @_stats.domElement.style.left     = '0px'
    @_stats.domElement.style.top      = '0px'
    @_stats.domElement.style.zIndex   = '99999'
    document.body.appendChild(@_stats.domElement)

    if !Conf.FLG.STATS
      @_stats.domElement.style.display = 'none'

    Update.add(=>

      @_cnt++

      @_stats.update()
      # @fps = Number($('#fpsText').html().split(' ')[0])
      # if Number.isNaN(@fps)
      #   @fps = 0
      #
      # if @fps?
      #   @_totalFps += @fps
      # @averageFps = @_totalFps / @_cnt
      #
      # if @_cnt >= 60 * 5
      #   @_cnt = 0
      #   @_totalFps = 0

    )






module.exports = new Profiler()

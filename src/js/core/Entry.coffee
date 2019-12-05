window.$                     = require('jquery')
window.requestAnimationFrame = require('raf')
window.THREE                 = require('three')
window.TweenMax              = require('gsap').TweenMax
window.CustomEase            = require('gsap').CustomEase
window.TimelineMax           = require('gsap').TimelineMax
window.isMobile              = require('ismobilejs')

Param    = require('./Param')
Profiler = require('./Profiler')
Func     = require('./Func')
Conf     = require('./Conf')
Delay    = require('../libs/Delay')
Util     = require('../libs/Util')
Resize   = require('../libs/Resize')
Update   = require('../libs/Update')



# エントリーポイント
class Entry

  constructor: ->

    @isJp = (window.navigator.userLanguage || window.navigator.language || window.navigator.browserLanguage).substr(0,2) == 'ja'



  # ------------------------------------
  # 初期化
  # ------------------------------------
  init: =>

    window.main = @

    if Conf.RELEASE
      console.warn = =>
        return
      # console.log = =>
      #   return

    Number.isNaN = Number.isNaN || (any) ->
      return typeof any == 'number' && isNaN(any)

    if !Conf.IS_WEBGL
      $('body').addClass('is-nowebgl')

    Resize.add(@_resize, true)
    Update.add(@_update)



  # ------------------------------------
  #
  # ------------------------------------
  _update: =>




  # ------------------------------------
  # リサイズ
  # ------------------------------------
  _resize: =>






module.exports = Entry

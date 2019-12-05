Util     = require('../libs/Util')
Resize   = require('../libs/Resize')
Size     = require('../libs/obj/Size')
Type     = require('./Type')
Conf     = require('./Conf')
Profiler = require('./Profiler')
Scroller = require('./Scroller')
Param    = require('./Param')

# 共通関数
class Func

  constructor: ->



  # ------------------------------------
  # レティナのあの値
  # ------------------------------------
  ratio: =>

    return window.devicePixelRatio || 1

    # if isMobile.tablet
    #   # return Math.max(1.5, Math.min(1, window.devicePixelRatio || 1))
    #   # return 1.5
    #   return window.devicePixelRatio || 1
    # else
    #   # return Math.max(1.5, Math.min(3, window.devicePixelRatio || 1))
    #   return window.devicePixelRatio || 1



  # ------------------------------------
  # スクリーンタイプ取得
  # ------------------------------------
  screen: =>

    if window.innerWidth <= Conf.BREAKPOINT
      return Type.SCREEN.XS
    else
      return Type.SCREEN.LG



  # ------------------------------------
  # スクリーンタイプ XS
  # ------------------------------------
  isXS: =>

    return (@screen() == Type.SCREEN.XS)



  # ------------------------------------
  # スクリーンタイプ LG
  # ------------------------------------
  isLG: =>

    return (@screen() == Type.SCREEN.LG)



  # ------------------------------------
  #
  # ------------------------------------
  allHeight: =>

    return @val(@r(800), @sh())



  # ------------------------------------
  # スクリーンタイプで分岐
  # ------------------------------------
  val: (xs, lg) =>

    if @isXS()
      return xs
    else
      return lg



  # ------------------------------------
  # コクのあるサイン 1
  # ------------------------------------
  sin1: (radian) =>

    return Math.sin(radian) + Math.sin(2 * radian)



  # ------------------------------------
  # コクのあるサイン 2
  # ------------------------------------
  sin2: (radian) =>

    return (
      Math.sin(radian) +
      Math.sin(2.2 * radian + 5.52) +
      Math.sin(2.9 * radian + 0.93) +
      Math.sin(4.6 * radian + 8.94)
    ) / 4



  # ------------------------------------
  # コクのあるサイン 1
  # ------------------------------------
  cos1: (radian) =>

    return Math.cos(radian) + Math.cos(2 * radian)



  # ------------------------------------
  # コクのあるサイン 2
  # ------------------------------------
  cos2: (radian) =>

    return (
      Math.cos(radian) +
      Math.cos(2.2 * radian + 5.52) +
      Math.cos(2.9 * radian + 0.93) +
      Math.cos(4.6 * radian + 8.94)
    ) / 4



  # ------------------------------------
  # 画面全体の操作ON/OFF
  # 引数なしの場合、状態が boolean で返る
  # ------------------------------------
  clickable: (bool) =>

    c = 'is-noPointer'
    body = $('body')

    if !bool?
      return !body.hasClass(c)
    else
      if bool
        body.removeClass(c)
      else
        body.addClass(c)



  # ------------------------------------
  #
  # ------------------------------------
  inUrl: (str) =>

    return location.href.indexOf(str) > 0



  # ------------------------------------
  #
  # ------------------------------------
  sw: =>

    return window.innerWidth



  # ------------------------------------
  #
  # ------------------------------------
  sh: =>

    return window.innerHeight



  # ------------------------------------
  #
  # ------------------------------------
  r: (val, max) =>

    base = @val(750, 1680)

    if max?
      sw = Math.min(@sw(), max)
    else
      sw = @sw()

    return (val / base) * sw



  # ------------------------------------
  #
  # ------------------------------------
  useScreen: =>

    return Conf.IS_SP && screen? && @isXS()








module.exports = new Func()

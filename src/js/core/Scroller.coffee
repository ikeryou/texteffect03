Conf   = require('./Conf')
Tween  = require('./Tween')
Update = require('../libs/Update')
Resize = require('../libs/Resize')
Size   = require('../libs/obj/Size')


class Scroller

  constructor: ->

    @normal = 0
    @val = 0
    @docSize = new Size()
    @old = 0
    @d = 0

    @sw = 0
    @sh = 0

    @_cnt = 0

    @_buffer = -1

    @_move = {
      tg:0
    }

    @_init()



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  _init: =>

    Update.add(@_update)
    Resize.add(@_resize, true)

    @_update()



  # -----------------------------------
  # 更新
  # -----------------------------------
  _update: =>

    @_cnt++
    # if ++@_cnt % 30 == 0
    #   @val = $(window).scrollTop()
    #   @normal = @val / ($(document).height() - window.innerHeight)

    #if @_cnt % 3 == 0

    @old = @val
    @val = $(window).scrollTop()

    @d = Math.abs(@old - @val)



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>

    @docSize.height = $(document).height()

    @sw = window.innerWidth
    @sh = window.innerHeight



  # -----------------------------------
  #
  # -----------------------------------
  set: (val) =>

    $(window).scrollTop(val)

    @old = @val = val
    @d = 0


  # -----------------------------------
  #
  # -----------------------------------
  pause: =>

    @_buffer = $(window).scrollTop() / ($(document).height() - window.innerHeight)
    @setNormal(0)



  # -----------------------------------
  #
  # -----------------------------------
  resume: =>

    if @_buffer == -1
      return

    @setNormal(@_buffer)
    @_buffer = -1



  # -----------------------------------
  #
  # -----------------------------------
  setNormal: (val) =>

    s = ($(document).height() - window.innerHeight) * val
    $(window).scrollTop(s)



  # -----------------------------------
  #
  # -----------------------------------
  move: (opt) =>

    dura = opt.duration || 1
    delay = opt.delay || 0

    @_move.tg = $(window).scrollTop()
    Tween.a(@_move, {
      tg:opt.tg
    }, dura, delay, Power2.easeInOut, null, =>
      $(window).scrollTop(@_move.tg)
    )





module.exports = new Scroller()

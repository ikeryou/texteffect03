Param  = require('./Param')
Conf   = require('./Conf')
Func   = require('./Func')
Util   = require('../libs/Util')
Point  = require('../libs/obj/Point')
Update = require('../libs/Update')



# ---------------------------------------------------
# マウス位置
# ---------------------------------------------------
class Mouse


  constructor: ->

    @x = 0
    @y = 0

    @p = new Point()
    @old = new Point()
    @start = new Point()

    @moveDist = new Point()
    @follow = new Point()

    # -1 ~ 1
    @normal = new THREE.Vector2()

    # 3D
    @three = new Point(0, 0)

    @isTouch = false
    @isMove = false

    @useSwipe = true
    @isCancelable = true

    @onSwipe = []
    @onTouchStart = []
    @onTouchEnd = []

    @onMouseDown = []
    @onMouseUp = []

    @_init()



  # ------------------------------------
  # 初期化
  # ------------------------------------
  _init: =>

    @x = Func.sw() * 0.5
    @y = Func.sh() * 0.5

    if isMobile.any
      window.addEventListener('touchmove', @_eTouchMove, {passive:false});
      window.addEventListener('touchstart', @_eTouchStart, {passive:false});
      window.addEventListener('touchend', @_eTouchEnd, {passive:false});
    else
      $(window).on('mousedown', @_eMouseDown)
      $(window).on('mouseup', @_eMouseUp)
      $(window).on('mousemove', @_eMouseMove)

    Update.add(@update)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _eTouchMove: (e) =>

    p = @getTouchPoint()

    if @useSwipe
      @follow.x = p.x - @x
      @follow.y = p.y - @y
      if event.cancelable && @isCancelable
        event.preventDefault()

    @x = @p.x = p.x
    @y = @p.y = p.y

    # if Math.abs(@_touch.followDist.x) > 2
    #   if event.cancelable
    #     event.preventDefault()



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _eTouchStart: (e) =>

    @isTouch = true

    p = @getTouchPoint()
    @x = @p.x = p.x
    @y = @p.y = p.y

    w = Func.sw()
    h = Func.sh()

    @normal.x = Util.map(@p.x, -1, 1, 0, w)
    @normal.y = Util.map(@p.y, -1, 1, 0, h)

    @three.x = Util.map(@p.x, -w * 0.5, w * 0.5, 0, w)
    @three.y = Util.map(@p.y, h * 0.5, -h * 0.5, 0, h)

    @start.x = p.x
    @start.y = p.y

    for val,i in @onTouchStart
      if val? then val()



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _eTouchEnd: (e) =>

    @isTouch = false

    if @useSwipe

      if Math.abs(@follow.x) > 1

        for val,i in @onSwipe
          if val?
            val(@follow)
        @follow.x = 0
        @follow.y = 0

    for val,i in @onTouchEnd
      if val? then val()



  # -----------------------------------------------
  #
  # -----------------------------------------------
  getTouchPoint: =>

    p = new Point()

    touches = event.touches
    if touches? && touches.length > 0
      p.x = touches[0].pageX
      p.y = touches[0].pageY

    return p



  # -----------------------------------
  # 更新
  # -----------------------------------
  update: =>

    w = Func.sw()
    h = Func.sh()

    x = Util.map(@p.x, -1, 1, 0, w)
    y = Util.map(@p.y, -1, 1, 0, h)

    # 動いてるか判定
    dx = x - @normal.x
    dy = y - @normal.y
    dist = Math.sqrt(dx * dx + dy * dy)
    @isMove = (dist > 0.001)

    # タップしてからの
    # if Conf.IS_SP
    # if @isTouch
    #   @moveDist.x = @start.x - @p.x
    #   @moveDist.y = @start.y - @p.y
    # else
    #   @moveDist.x += (0 - @moveDist.x) * 0.15
    #   @moveDist.y += (0 - @moveDist.y) * 0.15

    @moveDist.x = @start.x - @p.x
    @moveDist.y = @start.y - @p.y

    @normal.x = x
    @normal.y = y

    @three.x = Util.map(@p.x, -w * 0.5, w * 0.5, 0, w)
    @three.y = Util.map(@p.y, h * 0.5, -h * 0.5, 0, h)



  # -----------------------------------
  #
  # -----------------------------------
  _eMouseMove: (e) =>

    @old.copy(@p)

    @x = @p.x = e.clientX
    @y = @p.y = e.clientY

    @follow.x = @old.x - @x
    @follow.y = @old.y - @y



  # -----------------------------------
  #
  # -----------------------------------
  _eMouseDown: (e) =>

    @isTouch = true

    @_eMouseMove(e)

    @start.x = @p.x
    @start.y = @p.y

    for val,i in @onMouseDown
      if val? then val()



  # -----------------------------------
  #
  # -----------------------------------
  _eMouseUp: (e) =>

    @isTouch = false

    for val,i in @onMouseUp
      if val? then val()










module.exports = new Mouse()

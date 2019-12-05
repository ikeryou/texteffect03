Entry    = require('./core/Entry')
Param    = require('./core/Param')
Mouse    = require('./core/Mouse')
Conf     = require('./core/Conf')
Func     = require('./core/Func')
Tween    = require('./core/Tween')
Type     = require('./core/Type')
Update   = require('./libs/Update')
Util     = require('./libs/Util')
Delay    = require('./libs/Delay')
Text = require('./Text')


class Main extends Entry

  constructor: ->

    super()

    @_item = []
    @_marginTg

    @_dist = 0
    @_changeCnt = 0



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    num = 12
    str = Util.randomArr(Conf.STR)
    i = 0
    while i < num
      # $('.p-text_tg.is-noside').append('<div class="item"><div class="text">' + str + '</div></div>')
      $('.p-text_tg.is-side').append('<div class="item"><div class="text">' + str + '</div></div>')
      i++


    # $('.p-text_tg.is-noside .item').each((i,e) =>
    #   item = new Text({
    #     el:$(e)
    #     key:i
    #     total:num
    #     isSide:true
    #   })
    #   item.init()
    #   if i != num - 2
    #     $(e).addClass('is-margin')
    #   @_item.push(item)
    # )

    $('.p-text_tg.is-side .item').each((i,e) =>
      item = new Text({
        el:$(e)
        key:i
        total:num
        isSide:false
      })
      item.init()
      if i != num - 2
        $(e).addClass('is-margin')
      @_item.push(item)
    )

    @_marginTg = $('.p-text .item.is-margin')

    Mouse.onTouchStart.push(@_eTouchStart)
    Mouse.onTouchEnd.push(@_eTouchEnd)

    @_changeStr()



  # ------------------------------------
  #
  # ------------------------------------
  _eTouchStart: =>



  # ------------------------------------
  #
  # ------------------------------------
  _eTouchEnd: =>




  # ------------------------------------
  #
  # ------------------------------------
  _changeStr: =>

    color = new THREE.Color()
    color.r = Math.random()
    color.g = Math.random()
    color.b = Math.random()

    rot = new THREE.Vector2(0, 1)
    if @_changeCnt % 2 == 0
      rot.x = 1
      rot.y = 0

    # str = Util.randomArr(Conf.STR)
    # str += str
    # str += str
    # str = 'IKEDA'
    str = Util.randomArr(Conf.STR) + Util.randomArr(Conf.STR) + Util.randomArr(Conf.STR) + Util.randomArr(Conf.STR) + Util.randomArr(Conf.STR)
    # str += str
    # str += str
    if Param.text.shuffle.value
      Util.shuffle(@_item)

    for val,i in @_item
      if Param.text.shuffle.value
        if @_changeCnt % 2 == 0
          val.changeStr(str, color, i, rot)
        else
          val.hide({key:i})
      else
        if @_changeCnt % 2 == 0
          val.changeStr(str, color, val._key, rot)
        else
          val.hide({key:val._key})

    @_changeCnt++



  # ------------------------------------
  #
  # ------------------------------------
  _update: =>

    super()

    sh = Func.sh()

    if Mouse.isTouch
      dy = Util.map(Mouse.moveDist.y, 0, sh * 0.1, 0, sh * 1)
      dy = Math.abs(Mouse.moveDist.y) * 0.1
    else
      dy = 0
    @_dist += (dy - @_dist) * 0.2

    radian = Util.radian(Update.cnt * 10)
    ma = Util.map(Math.sin(radian), 0, sh * 0.05, -1, 1)
    Tween.set(@_marginTg, {
      marginRight:@_dist
    })

    if Update.cnt % 130 == 0
      @_changeStr()



  # ------------------------------------
  #
  # ------------------------------------
  _resize: =>

    super()








module.exports = Main

main = new Main()
main.init()

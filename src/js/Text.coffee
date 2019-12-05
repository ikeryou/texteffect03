Tween       = require('./core/Tween')
MyDisplay   = require('./core/MyDisplay')
Param       = require('./core/Param')
Conf        = require('./core/Conf')
Func        = require('./core/Func')
Type        = require('./core/Type')
Scroller    = require('./core/Scroller')
Util        = require('./libs/Util')
Resize      = require('./libs/Resize')
Update      = require('./libs/Update')
Delay       = require('./libs/Delay')
Point       = require('./libs/obj/Point')
Size        = require('./libs/obj/Size')


class Text extends MyDisplay


  constructor: (opt) ->

    opt.resize = true
    opt.update = true
    super(opt)

    @_key = opt.key
    @_total = opt.total

    @_text

    @_cnt = 0
    @_isChange = false

    @_str = ['A', 'B', 'C', 'D', 'E', 'F']
    @_bufStr = ''

    @_color = new THREE.Color(0xffffff)
    @_tgColor = new THREE.Color(0xffffff)

    @_rate = 0
    @_cntStart = 0

    @_param2 = {
      textWidth:0
      textHeight:0
      conWidth:0
      conHeight:0
      weight:100
    }

    @_rotY = 1
    @_rotX = 1

    @_isHide = false
    @_isVertical = opt.isSide





  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    @_text = @find('> .text')
    @_param2.textHeight = @_text.height()
    @_param2.conHeight = @_param2.textHeight / @_total

    if !@_isVertical
      @addClass('is-side')



  # -----------------------------------------------
  #
  # -----------------------------------------------
  changeStr: (str, color, i, rot) =>

    @_cnt = i * 1
    @_cntStart = @_cnt
    @_isChange = true
    @_bufStr = str
    @_tgColor = color

    @_rotX = rot.x
    @_rotY = rot.y
    @_isHide = false
    Tween.a(@, {
      _rate:[0, 1]
    }, 2, i * 0.05, Power4.easeInOut)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  hide: (opt) =>

    @_isHide = true
    Tween.a(@, {
      _rate:[1, 0]
    }, 2, opt.key * 0.05, Power4.easeInOut, null, null, opt.onComplete)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _update: =>

    super()

    if @_isChange
      str = Util.randomArr(Conf.STR)
      @_cnt += 1
      if Conf.IS_PC
        @_cnt += 1
      if @_cnt >= 60
        @_isChange = false
        @_text.html(@_bufStr)
        @_color.r = @_tgColor.r
        @_color.g = @_tgColor.g
        @_color.b = @_tgColor.b
      else
        # @_text.html(str)
        @_text.html(@_bufStr)
        # @_color.r = Math.random()
        # @_color.g = Math.random()
        # @_color.b = Math.random()
        @_color.r = @_tgColor.r
        @_color.g = @_tgColor.g
        @_color.b = @_tgColor.b
        # @_param2.weight = Util.randomInt(1)

    # @_rate = Util.map(@_cnt, 0, 1, 0, 30)

    if Update.cnt % 20 == 0
      Tween.set(@_text, {
        height: ''
        width: ''
      })
      @_param2.textWidth = @_text.width()
      # console.log(@_param2.textWidth)
      @_param2.textHeight = @_text.height()
      @_param2.conWidth = @_param2.textWidth / @_total
      @_param2.conHeight = @_param2.textHeight / @_total

    if @_isVertical

      Tween.set(@el(), {
        height: @_param2.conHeight
        #rotationX:Util.mix(180, 0, @_rate) * @_rotX
        #rotationY:Util.mix(180, 0, @_rate) * @_rotY
        opacity:Util.map(@_rate, 0, 1, 0, 0.2)
      })

      Tween.set(@_text, {
        # 'font-variation-settings': '"wght" ' + Util.map(@_rate, 800, 100, 0, 1)
        height: @_param2.textHeight
        # y:  @_param2.conHeight * @_key * -1
        y:  Util.mix(@_param2.conHeight * (@_total * 0.5) * -1, @_param2.conHeight * @_key * -1, @_rate)
        color:'#' + @_color.getHexString()
      })

    else

      Tween.set(@el(), {
        # 'transform-origin': (@_param2.conWidth * 0.5) + 'px ' + (@_param2.conHeight * 0.5) + 'px'
        # height: @_param2.conHeight
        width: @_param2.conWidth
        rotationX:Util.mix((if @_isHide then -Param.text.rotationX.value else Param.text.rotationX.value), 0, @_rate) * 1
        skewX:Util.mix((if @_isHide then -Param.text.skewX.value else Param.text.skewX.value), 0, @_rate) * 1
        # rotationZ:Util.mix((if @_isHide then 100 else -100), 0, @_rate) * 1
        opacity:Util.map(@_rate, 0, 1, 0, (if @_isHide then 1 else 0.5))
      })

      Tween.set(@_text, {
        width: @_param2.textWidth
        # height: @_param2.textHeight
        x: Util.mix(@_param2.conWidth * (@_total * 0.5) * -1, @_param2.conWidth * @_key * -1, @_rate)
        # x: @_param2.conWidth * @_key * -1
        y:  Util.mix(@_param2.conHeight * (@_total * 0.5) * (if @_isHide then -2 else -1), 0, @_rate)
        color:'#' + @_color.getHexString()
      })







module.exports = Text

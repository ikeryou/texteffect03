Resize           = require('../libs/Resize')
Update           = require('../libs/Update')
Util             = require('../libs/Util')
Delay            = require('../libs/Delay')
DisplayTransform = require('../libs/disp/DisplayTransform')
Point            = require('../libs/obj/Point')
Size             = require('../libs/obj/Size')
Func             = require('./Func')
Conf             = require('./Conf')
Type             = require('./Type')
Tween            = require('./Tween')


class MyDisplay extends DisplayTransform

  constructor: (opt) ->

    if !opt?
      opt = {}

    if !opt.resize?
      opt.resize = false

    if !opt.update?
      opt.update = false

    super(opt)

    # 更新回数
    @_cnt = 0

    @isActive = true

    @myParam = {}



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    if @_opt.resize
      Resize.add(@_resize)

    if @_opt.update
      Update.add(@_update)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  setHover: (onRollOver, onRollOut, onClick) =>

    @el().on('mouseenter', onRollOver).on('mouseleave', onRollOut).on('click', onClick)



  # -----------------------------------------------
  # 破棄
  # -----------------------------------------------
  dispose: =>

    Resize.remove(@_resize)
    Update.remove(@_update)

    @myParam = null

    super()



  # -----------------------------------------------
  # data-属性取得
  # -----------------------------------------------
  getData: (name) =>

    return @el().attr('data-' + name)



  # -----------------------------------------------
  # 表示切り替え
  # -----------------------------------------------
  setActive: (bool) =>

    if bool
      if !@isActive
        @removeClass('is-none')
    else
      if @isActive
        @addClass('is-none')

    @isActive = bool



  # -----------------------------------------------
  # 表示
  # -----------------------------------------------
  setVisible: (bool) =>

    if bool
      @removeClass('is-none')
    else
      @addClass('is-none')



  # -----------------------------------------------
  #
  # -----------------------------------------------
  getVisible: =>

    return !@el().hasClass('is-none')



  # -----------------------------------------------
  # 機能おわり
  # -----------------------------------------------
  setFinish: (bool) =>

    if bool
      @addClass('is-finish')
    else
      @removeClass('is-finish')



  # ------------------------------------
  # 画面全体の操作ON/OFF
  # 引数なしの場合、状態が boolean で返る
  # ------------------------------------
  clickable: (bool) =>

    c = 'is-noPointer'

    if !bool?
      return !@el().hasClass(c)
    else
      if bool
        @el().removeClass(c)
      else
        @el().addClass(c)



  # ------------------------------------
  # PC
  # ------------------------------------
  isPC: =>

    return !isMobile.any



  # ------------------------------------
  # スマホ
  # ------------------------------------
  isSP: =>

    return isMobile.any



  # ------------------------------------
  # 値半分にする
  # ------------------------------------
  half: (val) =>

    return ~~(val * 0.5)



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    @_cnt++



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: (size) =>



  # -----------------------------------------------
  # ステージ幅
  # -----------------------------------------------
  sw: =>

    return Resize.sw()



  # -----------------------------------------------
  # ステージ高さ
  # -----------------------------------------------
  sh: =>

    return Resize.sh()



  # -----------------------------------------------
  # ステージ幅 半分
  # -----------------------------------------------
  sw2: =>

    return ~~(Resize.sw() * 0.5)



  # -----------------------------------------------
  # ステージ高さ 半分
  # -----------------------------------------------
  sh2: =>

    return ~~(Resize.sh() * 0.5)



  # ------------------------------------
  # スクリーンタイプ XS
  # ------------------------------------
  isXS: =>

    return (Func.screen() == Type.SCREEN.XS)



  # ------------------------------------
  # スクリーンタイプ LG
  # ------------------------------------
  isLG: =>

    return (Func.screen() == Type.SCREEN.LG)



  # ------------------------------------
  # どっちか
  # ------------------------------------
  val: (xs, lg) =>

    if @isXS()
      return xs
    else
      return lg



  # -----------------------------------------------
  # TweenMaxアニメーション設定
  # -----------------------------------------------
  a: (param, duration, delay, easing, onStart, onUpdate, onComplete) =>

    return Tween.a(@el(), param, duration, delay, easing, =>
      @addClass('is-start')
      if onStart? then onStart()
    , onUpdate, onComplete)



  # ------------------------------------
  # TweenMaxパラメータ設定
  # ------------------------------------
  set: (to) =>

    Tween.set(@el(), to)














module.exports = MyDisplay

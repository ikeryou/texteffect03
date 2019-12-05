dat    = require('dat-gui')
Conf   = require('./Conf')
Type   = require('./Type')
Func   = require('./Func')
Util   = require('../libs/Util')
Update = require('../libs/Update')
Resize = require('../libs/Resize')
Size   = require('../libs/obj/Size')


# ---------------------------------------------------
# パラメータ
# ---------------------------------------------------
class Param

  constructor: ->

    @fps = Type.FPS.MID

    @_gui

    @text = {
      rotationX:{value:180, min:0, max:360}
      skewX:{value:180, min:0, max:360}
      shuffle:{value:true}
    }

    @_init()



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  _init: =>

    Update.add(@_update)
    Resize.add(@_resize, true)
    @_update()

    if !Conf.FLG.PARAM
      return

    @_gui = new dat.GUI()
    @_addGui(@text, 'text')

    $('.dg').css({
      zIndex:9999
      position:'fixed'
      right:0
      left:'auto'
    })



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _addGui: (obj, folderName) =>

    folder = @_gui.addFolder(folderName)

    for key,val of obj
      if !val.use?
        if key.indexOf('color') > 0
          folder.addColor(val, 'value').name(key)
        else
          if val.list?
            folder.add(val, 'value', val.list).name(key)
          else
            folder.add(val, 'value', val.min, val.max).name(key)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _listen: (param, name) =>

    if !name? then name = param
    @_gui.add(@, param).name(name).listen()



  # -----------------------------------
  # 更新
  # -----------------------------------
  _update: =>




  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>










module.exports = new Param()


class Type

  constructor: ->

    # スクリーンタイプ
    # XS : スマホ系
    # LG : PC系
    @SCREEN = {
      XS : 0
      LG : 1
    }

    @FPS = {
      HIGH:0
      MID:1
      LOW:2
      NONE:3
    }











module.exports = new Type()

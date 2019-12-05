Util = require('../libs/Util')
Type = require('./Type')


class Conf

  constructor: ->

    # 本番フラグ
    @RELEASE = false

    # フラグ関連
    @FLG = {
      PARAM:true
      STATS:true
    };

    # 本番フラグがtrueの場合、フラグ関連は全てfalseに
    if @RELEASE
      for key,val of @FLG
        @FLG[key] = false

    # ブレイクポイント
    @BREAKPOINT = 992

    # 画像パス
    @PATH_IMG = '/assets/img/mv/'

    @IS_PC = !isMobile.any
    @IS_SP = isMobile.any

    @IS_SIMPLE = isMobile.android.device || Util.isIE() || (!isMobile.any && Util.isSafari()) || isMobile.tablet

    @IS_WEBGL = Util.useWebGL()

    @SCALE_MIN = 0.000001

    @COLOR_LIST = [0xd94f98, 0x922e8e, 0x01a9e4, 0x3eb134, 0xfdd000, 0xf39800]

    @STR = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'N', 'M', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']












module.exports = new Conf()

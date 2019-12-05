

class ImgLoader

  constructor: ->

    @_list
    @_num

    @images = {}
    @_loadedNum = 0

    @onComplete
    @onProgress


  # -----------------------------------------------
  # 読み込み開始
  # -----------------------------------------------
  load: (list, num) =>

    @_list = list

    if !num?
      num = 1
    @_num = num

    @_loadedNum = 0

    @_load()



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _load: =>

    start = @_loadedNum
    end = Math.min(start + @_num, @_list.length)
    i = start
    while i < end
      img = new Image()
      o = @_list[i]
      if !o.id?
        o.id = i
      img.src = o.src
      img.__imgLoader = @
      img.__imgLoaderId = o.id
      img.onload = ->
        @orgWidth  = @width
        @orgHeight = @height
        @__imgLoader._loadedImg(@__imgLoaderId)

      @images[o.id] = img
      i++



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _loadedImg: (id) =>

    @_loadedNum++
    if @onProgress? then @onProgress(@_loadedNum / @_list.length)

    if @_loadedNum >= @_list.length
      if @onComplete? then @onComplete()
      return

    if @_loadedNum % @_num == 0 then @_load()











module.exports = ImgLoader

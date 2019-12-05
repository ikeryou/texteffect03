


# ---------------------------------------------------
#
# ---------------------------------------------------
class Val


  constructor: (val) ->

    @val = val
    @tg = @val


  toTg: (ease) =>

    @val += (@tg - @val) * ease




module.exports = Val



# ---------------------------------------------------
# イージング計算用オブジェクト
# t(0~1)を渡すと歪めた結果(0~1)を返す
# ---------------------------------------------------
class Easing
  
  # -----------------------------------------------
  # コンストラクタ
  # -----------------------------------------------
  constructor: ->
  
  
  
  # -----------------------------------------------
  # メソッド一覧
  # @linear
  #
  # @inBack
  # @inBounce
  # @inCirc
  # @inCubic
  # @inElastic
  # @inExpo
  # @inQuad
  # @inQuart
  # @inQuint
  # @inSine
  #
  # @outBack
  # @outBounce
  # @outCirc
  # @outCubic
  # @outElastic
  # @outExpo
  # @outQuad
  # @outQuart
  # @outQuint
  # @outSine
  #
  # @inOutBack
  # @inOutBounce
  # @inOutCirc
  # @inOutCubic
  # @inOutExpo
  # @inOutQuad
  # @inOutQuart
  # @inOutQuint
  # @inOutSine
  # -----------------------------------------------
  
  
  linear: (t) =>
  
    return t;
  
  
  
  inBack: (t) =>
    
    s = 1.70158;
    return t * t * ((s + 1) * t - s);
  
  
  
  inBounce: (t) =>
    
    t = 1.0 - t;
    
    if t < 1 / 2.75
      return 1.0 - (7.5625 * t * t);
    
    if t < 2 / 2.75
      t -= 1.5 / 2.75;
      return 1.0 - (7.5625 * t * t + 0.75);
    
    if t < 2.5 / 2.75
      t -= 2.25 / 2.75;
      return 1.0 - (7.5625 * t * t + 0.9375);
    
    t -= 2.625 / 2.75;
    return 1.0 - (7.5625 * t * t + 0.984375);
  
  
  
  inCirc: (t) =>
    
    if t >= 1
      return 1;
    else
      return -(Math.sqrt(1 - t * t) - 1);
  
  
  
  inCubic: (t) =>
    
    return t * t * t;
  
  
  
  inElastic: (t) =>
    
    p = 0.3;
    a = 1.0;
    s = 1.70158;
    
    if t == 0
      return 0;
    
    if t == 1.0
      return 1.0;
      
    if a < 1.0
      a = 1.0;
      s = p / 4;
    else
      s = p / (2 * 3.1419) * Math.asin(1.0 / a);
    
    --t;
    return -(a * Math.pow(2, 10 * t) * Math.sin((t - s) * (2 * 3.1419) / p));
  
  
  
  inExpo: (t) =>
    
    if t == 0
      return 0;
    else
      return Math.pow(2, 10 * (t - 1));
  
  
  
  inQuad: (t) =>
    
    return t * t;
  
  
  
  inQuart: (t) =>
    
    return t * t * t * t;
  
  
  
  inQuint: (t) =>
    
    return t * t * t * t * t;
  
  
  
  inSine: (t) =>
    
    return -Math.cos(t * (Math.PI / 2)) + 1.0;
  
  
  
  outBack: (t, s) =>
    
    s = s || 1.70158;
    --t;
    return t * t * ((s + 1.0) * t + s) + 1.0;
  
  
  
  outBounce: (t) =>
    
    if t < 1 / 2.75
      return 7.5625 * t * t;
    
    if t < 2 / 2.75
      t -= 1.5 / 2.75;
      return 7.5625 * t * t + 0.75;
    
    if t < 2.5 / 2.75
      t -= 2.25 / 2.75;
      return 7.5625 * t * t + 0.9375;
      
    t -= 2.625 / 2.75;
    return 7.5625 * t * t + 0.984375;
  
  
  
  outCirc: (t) =>
    
    --t;
    return Math.sqrt(1 - t * t);
  
  
  
  outCubic: (t) =>
    
    --t;
    return t * t * t + 1;
  
  
  
  outElastic: (t, s) =>
    
    p = s || 0.3;
    a = 1.0;
    
    if t == 0
      return 0;
    
    if t == 1.0
      return 1.0;
    
    if a < 1.0
      a = 1.0;
      s = p / 4;
    else
      s = p / (2 * 3.1419) * Math.asin(1.0 / a);
    
    return a * Math.pow(2, -10 * t) * Math.sin((t - s) * (2 * 3.1419) / p) + 1.0;
  
  
  
  outExpo: (t) =>
    
    if t == 1.0
      return 1;
    else
      return -Math.pow(2, -10 * t) + 1;
  
  
  
  outQuad: (t) =>
    
    return -t * (t - 2);
  
  
  
  outQuart: (t) =>
    
    --t;
    return 1.0 - t * t * t * t;
  
  
  
  outQuint: (t) =>
    
    --t;
    return t * t * t * t * t + 1;
  
  
  
  outSine: (t) =>
    
    return Math.sin(t * (Math.PI / 2));
  
  
  
  inOutBack: (t, s) =>
    
    s = s || 1.70158;
    k = 1.525;
    
    t *= 2;
    s *= k;
    
    if t < 1
      return 0.5 * (t * t * ((s + 1) * t - s));
    
    t -= 2;
    return 0.5 * (t * t * ((s + 1) * t + s) + 2);
  
  
  
  inOutBounce: (t) =>
    
    if t < 0.5
      return @inBounce(t * 2) * 0.5;
    else
      return @outBounce(t * 2 - 1.0) * 0.5 + 0.5;
  
  
  
  inOutCirc: (t) =>
    
    t *= 2;

    if t < 1
      return -0.5 * (Math.sqrt(1 - t * t) - 1);

    t -= 2;
    return 0.5 * (Math.sqrt(1 - t * t) + 1);
  
  
  
  inOutCubic: (t) =>
    
    t *= 2;

    if t < 1
      return 0.5 * t * t * t;

    t -= 2;
    return 0.5 * (t * t * t + 2);
  
  
  
  inOutExpo: (t) =>
    
    if t == 0
      return 0;
    
    if t == 1.0
      return 1.0;

    t *= 2;
    if t < 1
      return 0.5 * Math.pow(2, 10 * (t - 1));

    --t;
    return 0.5 * (-Math.pow(2, -10 * t) + 2);
  
  
  
  inOutQuad: (t) =>
    
    t *= 2;

    if t < 1
      return 0.5 * t * t * t * t;

    t -= 2;
    return -0.5 * (t * t * t * t - 2);
  
  
  
  inOutQuart: (t) =>
    
    t *= 2;

    if t < 1
      return 0.5 * t * t * t * t;

    t -= 2;
    return -0.5 * (t * t * t * t - 2);
  
  
  
  inOutQuint: (t) =>
    
    t *= 2;

    if t < 1
      return 0.5 * t * t * t * t * t;

    t -= 2;
    return 0.5 * (t * t * t * t * t + 2);
  
  
  
  inOutSine: (t) =>
    
    return -0.5 * (Math.cos(Math.PI * t) - 1);

















module.exports = Easing;
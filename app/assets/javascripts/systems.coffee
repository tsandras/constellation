# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @StellarSystem
  constructor: (standardCode) ->
    @standardCode = standardCode
    @tree = {}
    @l = 100
    @h = 100
    @r = 7
    @p = 25
    @decal = 5

  isMaj: (char) =>
    if char.toUpperCase() != char
      return false
    else
      return true
    return

  isAlpha: (char) =>
    if isNaN(char)
      return false
    else
      return true
    return

  isMin: (char) =>
    if char.toLowerCase() != char
      return false
    else
      return true
    return

  constructTree: () ->
    number = -1
    i = 0
    while i < @standardCode.length
      if @isMaj(@standardCode[i]) && !@isMin(@standardCode[i])
        @tree[@standardCode[i]] = {}
        lastFirst = @standardCode[i]
        number = -1
      else if @isMin(@standardCode[i]) && !@isMaj(@standardCode[i]) 
        tmp = {}
        tmp[@standardCode[i]] = []
        @tree[lastFirst] = $.extend({}, @tree[lastFirst], tmp)
        lastSecond = @standardCode[i]
        number = number + 1
      else if @isAlpha(@standardCode[i])
        @tree[lastFirst][lastSecond].push(@standardCode[i])
      i++
    return @tree

  totalFirstLevel: () ->
    total = 0
    for key of @tree
      total = total + 1
    return total

  lastOfOneSecondLevel: (keyEl) ->
    for key, val of @tree
      i = 0
      posKey = 0
      if !jQuery.isEmptyObject(val)
         for key, val of val
            i = i + 1
            if key == keyEl
              pos = i
    if pos >= i
      return true
    else
      return false

  PositionSecondLevel: (keyEl) ->
    for key, val of @tree
      i = 0
      if !jQuery.isEmptyObject(val)
         for key of val
            i = i + 1
            if key == keyEl
              return i
    return 0

  PositionThridLevel: (valEl) ->
    i = 0
    for key, val of @tree
      if !jQuery.isEmptyObject(val)
         for key, array of val
            if array && array.length > 0
              for j in array
                i = i + 1
                if j == valEl
                  console.log 'valeur Thrid', i
                  return i
    return 0

  nbsOfAllThridLevel: () ->
    i = 0
    for key, val of @tree
      if !jQuery.isEmptyObject(val)
         for key, array of val
            if array && array.length > 0
              i = i + array.length
    return i

  nbsOfAllSecondLevel: () ->
    i = 0
    for key, val of @tree
      if !jQuery.isEmptyObject(val)
         for key, val of val
            i = i + 1
    return i

  drawConnection: (c, level, parentPos, childPos) ->
    c.beginPath()
    c.moveTo((@p * (level - 1) - @decal + @r), parentPos - @decal)
    c.lineTo(@p * level - @decal, childPos - @decal)
    c.closePath()
    c.stroke()

  drawSubNode: (c, level, nbsStars, starting) ->
    for i in [1..nbsStars]
      c.beginPath()
      c.arc(@p * level - @decal * i, starting - @decal * i, @r, 0, 2 * Math.PI);
      c.strokeStyle = 'rgb(0,10,0)'
      c.lineWidth = 1
      c.fill()
      c.arc(@p * level - @decal * i, starting - @decal * i, @r + 1, 0, 2 * Math.PI);
      c.stroke()

  drawNode: (level, nbsStars, idTarget, pos, parentPos) ->
    mid = @h/2
    canvas = document.getElementById(idTarget)
    c = canvas.getContext('2d')
    c.fillStyle = '#cccccc'
    if level == 1
      @drawSubNode(c, level, nbsStars, mid)
    else if level == 2
      @drawConnection(c, level, mid, @PositionSecondLevel(pos) * (@h/(@nbsOfAllSecondLevel()+1)))
      @drawSubNode(c, level, nbsStars, @PositionSecondLevel(pos) * (@h/(@nbsOfAllSecondLevel()+1)))
    else if level == 3
      parentPos = parentPos * (@h/(@nbsOfAllSecondLevel()+1))
      @drawConnection(c, level, parentPos, pos * (@h/(@nbsOfAllThridLevel()+1)))
      @drawSubNode(c, level, nbsStars, pos * (@h/(@nbsOfAllThridLevel()+1)))
    return

  draw: (idTarget) ->
    firstLevel = 0
    secondLevel = 0
    numberThirdLevel = 1
    for key, val of @tree
      firstLevel = firstLevel + 1
      @drawNode(1, firstLevel, idTarget, key, null)
      for key, array of val
        secondLevel = secondLevel + 1
        if @lastOfOneSecondLevel(key) || (array && array.length > 0)
          @drawNode(2, secondLevel, idTarget, key, 1)
        secondLevel = 0 if array[0] == '0'
        if array && array.length > 0 && array[0] != '0'
          @drawNode(3, array.length, idTarget, numberThirdLevel, @PositionSecondLevel(key))
          numberThirdLevel = numberThirdLevel + array.length
          secondLevel = 0


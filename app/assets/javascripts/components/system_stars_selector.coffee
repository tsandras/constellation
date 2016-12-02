@SystemStars = React.createClass
  updateCanvas: () ->
    @props.stelSys.constructTree()
    @props.stelSys.draw('canvas' + @props.num)
  componentDidMount: -> @updateCanvas()
  chooseStarSystem: (e) ->
    @props.selector.setState(showSystemStars: false)
    $.post '/systems', { system: { standard_code: @props.stelSys.standardCode } }, (data) =>
      # @setState @getInitialState()
      , 'JSON'
  render: ->
    React.DOM.div
      className: 'system-stars'
      onClick: @chooseStarSystem
      @props.stelSys.standardCode
      React.DOM.canvas
        id: 'canvas' + @props.num
        width: '100'
        height: '100'
        name: @props.stelSys.standardCode

@SystemStarsDisplay = React.createClass
  getInitialState: () ->
    tmp = []
    for standardCode in @props.standard_codes
      tmp.push(new StellarSystem(standardCode))
    stellarSystems: tmp
  render: ->
    React.DOM.div
      className: 'systems'
      for stellarSystem, key in @state.stellarSystems
        React.createElement SystemStars, stelSys: stellarSystem, key: key, num: key, selector: @props.selector

@SystemStarsSelector = React.createClass
  getInitialState: () ->
    showSystemStars: false
  handleSystemStars: (e) ->
    if @state.showSystemStars
      @setState showSystemStars: false
    else
      @setState showSystemStars: true
  render: ->
    React.DOM.div
      className: 'system-stars-handle'
      React.DOM.span
        onClick: @handleSystemStars
        className: 'system-stars-selector'
        'Stellar system'
      if @state.showSystemStars 
        React.createElement SystemStarsDisplay, standard_codes: @props.standard_codes, selector: this

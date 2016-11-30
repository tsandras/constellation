@SystemStars = React.createClass
  updateCanvas: () ->
    @props.stelSys.constructTree()
    @props.stelSys.draw('canvas' + @props.num)
  componentDidMount: -> @updateCanvas()
  render: ->
    React.DOM.div
      className: 'system-stars'
      React.DOM.canvas
        id: 'canvas' + @props.num
        width: '100'
        height: '100'

@SystemStarsDisplay = React.createClass
  getInitialState: () ->
    stellarSystems: [new StellarSystem('ABa1b12'), new StellarSystem('ABa')]
  render: ->
    React.DOM.div
      className: 'systems'
      for stellarSystem, key in @state.stellarSystems
        React.createElement SystemStars, stelSys: stellarSystem, key: key, num: key

@SystemStarsSelector = React.createClass
  getInitialState: () ->
    showSystemStars: false
  handleSystemStars: (e) ->
    if @state.showSystemStars
      @setState showSystemStars: false
    else
      @setState showSystemStars: true
  render: ->
    console.log @props.test
    React.DOM.div
      className: 'system-stars-handle'
      React.DOM.span
        onClick: @handleSystemStars
        className: 'system-stars-selector'
        'Stellar system'
      if @state.showSystemStars 
        React.createElement SystemStarsDisplay

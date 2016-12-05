@SystemDisplaying = React.createClass
  getInitialState: () ->
    if @props.system
      showSystem: true
    else
      showSystem: false
  updateCanvas: () ->
    stelSys = new StellarSystem(@props.system.standard_code)
    stelSys.constructTree()
    stelSys.draw('scanvas')
  componentDidMount: -> @updateCanvas()
  render: ->
    React.DOM.div
      className: 'system-displaying'
      if @state.showSystem
        @props.system.standard_code
      React.DOM.canvas
        id: 'scanvas'
        width: '100'
        height: '100'
        name: @props.system.standard_code
